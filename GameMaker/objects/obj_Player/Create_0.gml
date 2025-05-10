global.ProgrammingScore = 0;

___ = {
    maxHealth : 80,
    onDamageCallback : undefined,
    onDeathCallback : undefined,
    goalAngle : 0,
    angle : 0,
    moveSpeed : 2,
    canMove : false,
    numberOfShots : 0,
    shootSpeed : 30,
}

codeRuntimeSequence = layer_sequence_create("GUI", 0, 0, seq_CodeRuntimeDisplay)
layer_sequence_pause(codeRuntimeSequence);

Subscribe("StartingInterpreter", function(_data) {
    layer_sequence_headdir(codeRuntimeSequence, seqdir_right);
    layer_sequence_play(codeRuntimeSequence);
})

Subscribe("StoppingInterpreter", function(_data) {
    layer_sequence_headdir(codeRuntimeSequence, seqdir_left);
    layer_sequence_play(codeRuntimeSequence);
})




global.CanMove = false;
global.PlayerCurrentlyActing = false;

function Init(_maxHealth, _onDamageCallback = undefined, _onDeathCallback = undefined)
{
    ___.maxHealth = _maxHealth;
    ___[$ "currentHealth"] = _maxHealth;
    if (_onDamageCallback != undefined) ___.onDamageCallback = _onDamageCallback;
    if (_onDeathCallback != undefined) ___.onDeathCallback = _onDeathCallback;
}

function GetCurrentHealth()
{
    return ___.currentHealth;
}

function TakeDamage(_damage)
{
    ___.currentHealth -= _damage;
    if (___.currentHealth <= 0)
    {
        ___.currentHealth = 0;
        if (___.onDeathCallback != undefined) ___.onDeathCallback();
            
        programmingResults = {
            PlayedGame : true,
            Score : global.ProgrammingScore
        };
        
        var jsonText = json_stringify(programmingResults, true);
        
        var tempPath = string_concat(global.ProgrammingFilePath, ".tmp")
        
        var file = file_text_open_write(tempPath);
        if (file != -1)
        {
            file_text_write_string(file, jsonText);
            file_text_close(file);
    
            if (file_exists(tempPath))
            {
                file_delete(global.ProgrammingFilePath); 
                file_rename(tempPath, global.ProgrammingFilePath); 
            }
        }
        
        Transition(rmDonw, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }
    else 
    {
        if (___.currentHealth > ___.maxHealth)
        {
            ___.currentHealth = ___.maxHealth;
        }
        
        if (___.onDamageCallback != undefined) ___.onDamageCallback({
            DamageTaken : _damage,
            CurrentHealth : ___.currentHealth,
            MaxHealth : ___.maxHealth,
            Percentage : ___.currentHealth / ___.maxHealth,
        })
    }
    
    
}

Subscribe("Turn", function(_angle) {
    global.PlayerCurrentlyActing = true;
    ___.goalAngle += _angle;
    if (___.goalAngle > 360) ___.goalAngle -= 360;
    if (___.goalAngle < 0) ___.goalAngle += 360;
})

Subscribe("TurnTo", function(_angle) {
    global.PlayerCurrentlyActing = true;
    ___.goalAngle = _angle;
    if (___.goalAngle > 360) ___.goalAngle -= 360;
    if (___.goalAngle < 0) ___.goalAngle += 360;
})

Subscribe("Move", function(_numOfSteps) {
    global.PlayerCurrentlyActing = true;
    ___.canMove = true;
    Raise("CanMove", true);
    global.CanMove = true;
    alarm[0] = _numOfSteps * 30;
})


Subscribe("Shoot", function(_numOfShots) {
    global.PlayerCurrentlyActing = true;
    ___.numberOfShots = _numOfShots;
    alarm[1] = ___.shootSpeed;
})

Subscribe("EscPressed", function() {
    global.PlayerCurrentlyActing = false;
    alarm[0] = -1;
    ___.canMove = false;
    Raise("CanMove", false);
    global.CanMove = false;
    
    alarm[1] = -1;
    ___.numberOfShots = 0;
})




Init(200);

_counter = 0;
