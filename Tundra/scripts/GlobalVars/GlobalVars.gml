#macro mouseGUIX device_mouse_x_to_gui(0)
#macro mouseGUIY device_mouse_y_to_gui(0)

function Vars() constructor {
	pause = false;
	
	function PauseGame(_id) {
		Raise("Pause", _id);
		pause = true;
	}
	
	function ResumeGame(_id) {
		Raise("Resume", _id);
		pause = false;
	}
    
    highlightColors = [
        c_white,
        c_white,
        c_red,
        c_yellow,
        c_aqua,
        c_black,
    ];
    
    sequencesLayerName = "Sequences";
}

global.vars = new Vars();
global.mainColor = make_color_rgb(196, 129, 126);

enum ButtonState
{
    Idle,
    Hovered,
    Clicked    
}

function EntityMovementData() constructor {
    distances = new Vector3(64, 8, 1);
    function SetDistances(runDist, walkDist, slowDist) { distances = new Vector3(runDist, walkDist, slowDist); return self;}
    
    speeds = new Vector3(4, 2, 1);
    function SetSpeeds(runSpeed, walkSpeed, slowSpeed) { distances = new Vector3(runSpeed, walkSpeed, slowSpeed); return self;}
}

enum MouseState
{
    Normal = 0,
    Point = 1,
    Attack = 2,
    Mine = 3,
    Talk = 4,
    Null = 5,
}


function HealthSystem(_maxHealth, _owner) constructor {
    owner = _owner;
    maxHealth = _maxHealth;
    currentHealth = maxHealth;
    
    function TakeDamage(_dmg)
    {
        currentHealth -= _dmg;
        if (currentHealth <= 0)
        {
            Die();
        }
        
        Raise("Damage", [self, _dmg]);
    }
    
    function Die() {
        Raise("Dead", owner);
        instance_destroy(owner);
    }
}