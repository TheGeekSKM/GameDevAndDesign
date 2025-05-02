// Movement Settings
moveSpeed = 4;
acceleration = 0.5;
deceleration = 0.8;
gravityForce = 0.6;
gravityForceFall = 0.9;
jumpForce = -12;
maxFallSpeed = 10;

// State & Flags
state = PlayerState.Normal;
onGround = false;
facing = 1;
onPlatform = noone;                 // id of the moving platform the player is on
platformHorizontalMomentum = 0;     // horizontal momentum from the platform

// Velocities
hsp = 0;
vsp = 0;

// Coyote Time
coyoteTimeMax = 6;
coyoteTimer = 0;

// Input Buffering
jumpBufferMax = 6;
jumpBufferTimer = 0;
dashBufferMax = 6;
dashBufferTimer = 0;

// Chain Jumps
maxJumps = 2;
jumpsRemaining = maxJumps;

// Dashing
dashSpeed = 10;
dashTimeMax = 8;
dashCooldownMax = 20;
dashTimer = 0;
dashCooldownTimer = 0;
dashDirX = 0;
dashDirY = 0;
canDash = true;
dashedInAir = false;
hyperSpeedBoost = 6;
waveDashWindow = 4;
waveDashTimer = 0;

// Attacks
attackPrimaryCooldownMax = 15;
attackPrimaryCooldown = 0;
attackSecondaryCooldownMax = 30;
attackSecondaryCooldown = 0;

// Assist Mode Options
assistInfiniteJumps = false;
assistInfiniteDashes = false;
assistLongerCoyoteTime = false;
assistLongerBufferTime = false;

// Trail Settings
trailCooldown = 0;

function CrushedDamage() {}

function PlayerStateNormal(coyoteMax, _jumpBufferMax, _dashBufferMax) 
{
    // Gather Input
    var moveInput = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
    var jumpPressed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
    var jumpHeld = keyboard_check(vk_space) || keyboard_check(ord("W"));
    var dashPressed = keyboard_check_pressed(ord("D"));
    var attackPrimaryPressed = keyboard_check_pressed(ord("J"));
    var attackSecondaryPressed = keyboard_check_pressed(ord("K"));

    // Input Buffering
    if (jumpPressed) jumpBufferTimer = _jumpBufferMax;
    if (dashPressed) dashBufferTimer = _dashBufferMax;

    // Horizontal Movement
    if (moveInput != 0)
    {
        facing = moveInput;
        hsp += moveInput * acceleration;
        hsp = clamp(hsp, -moveSpeed, moveSpeed);
        
        image_index = 0;
    }
    else
    {
        hsp = lerp(hsp, 0, deceleration);
        if (abs(hsp) < 0.1) hsp = 0;
            
        image_index = 1;

    }

    // Vertical Movement
    var isAirborne = !collision_rectangle(bbox_left+1, bbox_bottom+1, bbox_right-1, bbox_bottom+1, obj_Solid, false, true);
    if (isAirborne)
    {
        if (vsp < 0) vsp += gravityForce; // Ascending
        else vsp += gravityForceFall; // Descending
        
        vsp = min(vsp, maxFallSpeed);
    }

    // Jumping
    var canInitiateGroundJump = collision_rectangle(bbox_left+1, bbox_bottom+1, bbox_right-1, bbox_bottom+1, obj_Solid, false, true) || coyoteTimer > 0;
    var hasAirJumps = jumpsRemaining > (assistInfiniteJumps ? 0 : 1);

    if (jumpBufferTimer > 0)
    {
        var jumped = false;
        if (canInitiateGroundJump)
        {
            vsp = jumpForce;
            jumpsRemaining = maxJumps - 1;
            coyoteTimer = 0;
            jumpBufferTimer = 0;
            jumped = true;
        }
        else if (hasAirJumps)
        {
            vsp = jumpForce;
            jumpsRemaining--;
            jumpBufferTimer = 0;
            jumped = true;
        }

        if (jumped)
        {
            hsp += platformHorizontalMomentum;
            onPlatform = noone;
        }
    }

    // Variable Jump Height
    if (vsp < 0 && !jumpHeld)
    {
        vsp = max(vsp, jumpForce * 0.5);
    }

    // Dashing
    var canDashNow = (dashCooldownTimer <= 0 || assistInfiniteDashes);
    if (dashBufferTimer > 0 && canDashNow)
    {
        StartDash();
        dashBufferTimer = 0;
    }

    // Attacking
    if (attackPrimaryPressed && attackPrimaryCooldown <= 0)
    {
        AttackPrimary();
        attackPrimaryCooldown = attackPrimaryCooldownMax;
    }
    if (attackSecondaryPressed && attackSecondaryCooldown <= 0)
    {
        AttackSecondary();
        attackSecondaryCooldown = attackSecondaryCooldownMax;
    }

}

function PlayerStateDashing()
{
    onPlatform = noone;
    hsp = dashDirX * dashSpeed;
    vsp = dashDirY * dashSpeed;

    if (dashTimer <= 0)
    {
        state = PlayerState.Normal;
        var _postDashGroundCheck = collision_rectangle(bbox_left+1, bbox_bottom+1, bbox_right-1, bbox_bottom+1, obj_Solid, false, true);
        var _postDashPlatformInst = instance_place(x, y + 1, obj_MovingPlatform);

        hsp *= 0.5;
        vsp *= 0.3;

        if (dashDirY > 0.5 && dashDirX != 0 && _postDashGroundCheck) {
            hsp = sign(dashDirX) * (moveSpeed + hyperSpeedBoost);
        }
        if (dashDirY >= 0 && _postDashGroundCheck && !dashedInAir) {
            waveDashTimer = waveDashWindow;
        }

        if (_postDashGroundCheck)
        {
            groundCheck = true;
            vsp = 0;
            jumpsRemaining = maxJumps;
            dashedInAir = false;

            if (instance_exists(_postDashPlatformInst))
            {
                onPlatform = _postDashPlatformInst;
                y = _postDashPlatformInst.bbox_top - (bbox_bottom - y);
            }
            else
            {
                onPlatform = noone;
            }
        }
        else 
        {
            onGround = false;
            onPlatform = noone;
        }
    }
}

function StartDash()
{
    state = PlayerState.Dashing;
    dashTimer = dashTimeMax;

    if (!assistInfiniteDashes) {
        dashCooldownTimer = dashCooldownMax;
    }

    var inputH = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
    var inputV = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));
    if (inputH == 0 && inputV == 0)
    {
        dashDirX = facing;
        dashDirY = 0;
        image_index = 1;
    }
    else 
    {
        var len = point_distance(0, 0, inputH, inputV);
        if (len > 0)
        {
            dashDirX = inputH / len;
            dashDirY = inputV / len;
        }
        else 
        {
            dashDirX = facing;
            dashDirY = 0;
        }
        
        hsp = 0;
        vsp = 0;
        onPlatform = noone;
        image_index = 0;
    }
}

function ApplyMovementAndCollision(_solidObject)
{
    // Horizontal Collision
    if (place_meeting(x + hsp, y, _solidObject))
    {
        var moveDir = sign(hsp);
        while (!place_meeting(x + moveDir, y, _solidObject)) 
        {
            x += moveDir;
        }
        hsp = 0;
    }
    x += hsp;

    // Vertical Collision
    onGround = false;
    onPlatform = noone;

    var landedThisFrame = false;
    if (place_meeting(x, y + vsp, _solidObject))
    {
        var moveDir = sign(vsp);
        var instCollidedV = instance_place(x, y + vsp, _solidObject);
        while (!place_meeting(x, y + moveDir, _solidObject)) 
        {
            y += moveDir;
        }

        if (vsp >= 0 && instCollidedV != noone)
        {
            landedThisFrame = true;
            onGround = true;
            var instBelowFinal = instance_place(x, y + 1, _solidObject);
            if (instance_exists(instBelowFinal))
            {
                y = instBelowFinal.bbox_top - (bbox_bottom - y);
                if (object_get_parent(instBelowFinal.object_index) == obj_MovingPlatform || instBelowFinal.object_index == obj_MovingPlatform)
                {
                    onPlatform = instBelowFinal;
                }
            }

            jumpsRemaining = maxJumps;
            dashedInAir = false;
        }
        vsp = 0;
    }
    y += vsp;

    if (!landedThisFrame)
    {
        onGround = false;
        onPlatform = noone;
    }

    // Wave Dash
    if (waveDashTimer > 0 && jumpBufferTimer > 0 && onGround)
    {
        vsp = jumpForce;
        hsp = sign(hsp) * (moveSpeed + hyperSpeedBoost * 0.8);
        waveDashTimer = 0;
        jumpBufferTimer = 0;
        onGround = false;
        coyoteTimer = 0;
        jumpsRemaining = maxJumps - 1;
        onPlatform = noone;
    }
}

function AttackPrimary() 
{
    // Primary attack logic here
}
function AttackSecondary() 
{
    // Secondary attack logic here
}