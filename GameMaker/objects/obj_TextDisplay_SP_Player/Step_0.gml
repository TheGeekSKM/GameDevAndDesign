var shiftHeld = keyboard_check(vk_lshift);
var ctrlHeld = keyboard_check((vk_lcontrol));
var movement = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if (movement != 0 && shiftHeld)
{
    currentFunctionSlotIndex += movement;
    
    if (currentFunctionSlotIndex >= 3)
    {
        currentFunctionSlotIndex = 0;
    }
    else if (currentFunctionSlotIndex < 0)
    {
        currentFunctionSlotIndex = 2;
    }
    
    echo(currentFunctionSlotIndex);
    
    CurrentIndexUpdated();
}

if (keyboard_check_pressed(ord("C")) && shiftHeld && ctrlHeld)
{
    Raise("Compiled", currentFunctionSlot)
}

if (keyboard_check_pressed(ord("E")) && shiftHeld && ctrlHeld)
{
    if (obj_FuncHolder_1.compiledCode != undefined
        || obj_FuncHolder_2.compiledCode != undefined
        || obj_FuncHolder_3.compiledCode != undefined)
    {
        global.CompiledCode1 = obj_FuncHolder_1.compiledCode;
        global.CompiledCode2 = obj_FuncHolder_2.compiledCode;
        global.CompiledCode3 = obj_FuncHolder_3.compiledCode;
        OpenModalWindow("SET UP SUCCESS", "All the code has been compiled and saved. Close this Window to continue!", function() {
            Transition(rmProgrammingGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);    
        })
    }
    else 
    {
        OpenModalWindow("ERROR", "At least one Function Slot needs to have compiled code.")
    }
}

if (keyboard_check_pressed(ord("O")) && ctrlHeld)
{
    if (os_is_network_connected())
    {
        url_open("https://saimangipudi.dev/code-snippet.html")
    }
    else 
    {
        url_open("Pages/code-snippet.html");
    }
}