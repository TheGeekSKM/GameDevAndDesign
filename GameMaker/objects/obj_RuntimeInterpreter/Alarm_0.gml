if (!isRunning) return;

if (variable_global_exists("PlayerCurrentlyActing") && global.PlayerCurrentlyActing || global.CanMove)
{
    alarm[0] = tickDelay;
    //show_message($"Player Currently Acting")
    return;
}

var executedCount = 0;
while (isRunning && executedCount < instructionsPerAlarmTick) 
{
    if (currentIndex >= array_length(compiledInstructions)) 
    { 
        //show_message($"Interpreter end. Current Index: {currentIndex}"); 
        StopInterpreter(); 
        return; 
    }

    var instr = compiledInstructions[currentIndex];
    //show_message($"Current Instruction: {instr}\nInstruction Index: {currentIndex} our of TotalCommands: {array_length(compiledInstructions) - 1}")
    if (currentIndex < array_length(lineMapping)) 
    { 
        currentRawLine = lineMapping[currentIndex]; 
    }
    else 
    { 
        currentRawLine = -1; 
        //show_message(string_concat("Warning: Missing line map index ", string(currentIndex))); 
    }

    var indexBeforeExecute = currentIndex;
    Raise("ExecutingInstruction", currentRawLine);
    ExecuteInstruction(instr);
    
    if (isRunning && currentIndex == indexBeforeExecute) 
    {
        currentIndex += 1;
    }
    executedCount++;
    
    if (!isRunning || (variable_global_exists("PlayerCurrentlyActing") && global.PlayerCurrentlyActing || global.CanMove))
    {
        break;
    }
}

if (isRunning) { alarm[0] = tickDelay; }