if (___.currentHealth <= 0) image_index = 1;
else image_index = 0;

// ----- Turning ----- //
___.angle = lerp(___.angle, ___.goalAngle, 0.1);
if (abs(___.angle - ___.goalAngle) <= 0.15)
{
    ___.angle = ___.goalAngle;
    if (global.PlayerCurrentlyActing)
    {
        global.PlayerCurrentlyActing = false;
    }
}

// ----- Movement ----- //
if (___.canMove)
{
    _allocationCounter++;
    if (_allocationCounter >= 30)
    {
        TakeDamage(5, true);
        _allocationCounter = 0;
    }
    
    var _x = lengthdir_x(1, ___.angle);
    var _y = lengthdir_y(1, ___.angle);
    
    
    move_and_collide(_x, _y, [obj_block], 4, 0, 0, ___.moveSpeed, ___.moveSpeed);
}

// ----- Function Execution ----- //
if (keyboard_check_pressed(vk_numpad1) || keyboard_check_pressed(ord("1")))
{
    global.Interpreter.StartInterpreter(global.CompiledCode1);
}
else if (keyboard_check_pressed(vk_numpad2) || keyboard_check_pressed(ord("2")))
{
    global.Interpreter.StartInterpreter(global.CompiledCode2);
}
else if (keyboard_check_pressed(vk_numpad3) || keyboard_check_pressed(ord("3")))
{
    global.Interpreter.StartInterpreter(global.CompiledCode3);
}

if (keyboard_check_pressed(vk_numpad0))
{
    TakeDamage(2, true);
}


if (global.CanMove)
{
    _counter++;
    if (_counter >= 2 * 60)
    {
        TakeDamage(-5);
        _counter = 0;
    }    
}

if (global.ProgrammingScore >= 18)
{
    programmingResults = {
        PlayedGame : true,
        Score : global.ProgrammingScore
    };
    
    var jsonText = json_stringify(programmingResults, true);
    SafeWriteJson(global.ProgrammingFilePath, jsonText);
    
    Transition(rmDonw, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

if (keyboard_check_pressed(ord("Q")))
{
    programmingResults = {
        PlayedGame : true,
        Score : global.ProgrammingScore
    };
    
    var jsonText = json_stringify(programmingResults, true);
    
    //var tempPath = string_concat(global.ProgrammingFilePath, ".tmp")
    //var file = file_text_open_write(tempPath);
    //if (file != -1)
    //{
        //file_text_write_string(file, jsonText);
        //file_text_close(file);
        //if (file_exists(tempPath))
        //{
            //file_delete(global.ProgrammingFilePath); 
            //file_rename(tempPath, global.ProgrammingFilePath); 
        //}
    //}
    
    SafeWriteJson(global.ProgrammingFilePath, jsonText);
    
    Transition(rmDonw, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

if (canSpawnHitParticles)
{
    
}