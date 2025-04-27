if (keyboard_check_pressed(vk_numpad0))
{

    var code = @"function Bungus() 
{
    // Bungus
    var times = 5;
    Repeat(times)
    {
        Move(FindAngleToEnemy());
    }
}";

    var result = ValidateSyntax(code);
    show_message(result);
    var result2 = 0;
    var result3 = "";
    
    if (result.Valid)
    {
        result2 = CalculateMemoryCost(code);
        result3 = CompileCode(code);
        show_message($"Memory Cost: {result2}")
        show_message($"Compiled Code Struct: {result3}")

        global.Interpreter.StartInterpreter(result3);
    }
}