function DialogueScene() constructor {
	dialogues = [];
	currentLine = 0;
    finished = false;

	function GetNextDialogue()
	{
		if (currentLine < array_length(dialogues))
		{
			var line = dialogues[currentLine];
			currentLine += 1;
			return line;
		}
		else
		{
            finished = true;
			return undefined;
		}
	}

    function AddDialogue(_speaker, _line)
    {
        var line = new DialogueLine(_speaker, _line);
        array_push(dialogues, line);
        return self;
    }

	function CanContinue()
	{
		return currentLine < array_length(dialogues);
	}
}

function DialogueLine(_speaker, _line) constructor {
	speaker = _speaker;
	line = _line;
}

function StartDialogue(_dialogueScene, _playerIndex)
{
    switch(_playerIndex)
    {
        case 0: 
            show_message("Make Dialogue for Player 1 Pop up");
        break;
        case 1: 
            show_message("Make Dialogue for Player 2 Popup!");
        break;
    }
}