if (!isRunning) return;

var executedCount = 0;
while (isRunning && executedCount < instructionsPerAlarmTick) 
{
    if (currentIndex >= array_length(compiledInstructions)) 
    { 
        show_debug_message("Interpreter end."); StopInterpreter(); break; 
    }

    var instr = compiledInstructions[currentIndex];
    if (currentIndex < array_length(lineMapping)) 
    { 
        currentRawLine = lineMapping[currentIndex]; 
    }
    else 
    { 
        currentRawLine = -1; 
        show_debug_message(string_concat("Warning: Missing line map index ", string(currentIndex))); 
    }

    var indexBeforeExecute = currentIndex;
    ExecuteInstruction(instr);
    if (isRunning && currentIndex == indexBeforeExecute) 
    {
        currentIndex += 1;
    }
    executedCount++;
}

if (isRunning) { alarm[0] = tickDelay; }