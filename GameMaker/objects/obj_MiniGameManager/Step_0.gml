// if the game is a programming game, check if the completion status is set to true
if (global.programmingGameID && CompletionStatusFromExecutedProcess(global.programmingGameID))
{
    FreeExecutedProcessStandardInput(global.programmingGameID);
    FreeExecutedProcessStandardOutput(global.programmingGameID);
    global.programmingGameID = 0;

    // Read score from working_directory + "ProgrammingGame.json"
    show_message($"TODO: Read score from \"{working_directory}ProgrammingGame.json\"");
}


// if the game is an editing game, check if the completion status is set to true
if (global.editingGameID && CompletionStatusFromExecutedProcess(global.editingGameID))
{
    FreeExecutedProcessStandardInput(global.editingGameID);
    FreeExecutedProcessStandardOutput(global.editingGameID);
    global.editingGameID = 0;

    // Read score from working_directory + "EditingGame.json"
    show_message($"TODO: Read score from \"{working_directory}EditingGame.json\"");
}