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
		var canContinue = currentLine < array_length(dialogues);
		if (!canContinue)
		{
			currentLine = 0;
			finished = true;
		}
		return currentLine < array_length(dialogues);
	}
}

function DialogueLine(_speaker, _line) constructor {
	speaker = _speaker;
	line = _line;
}

function StartDialogueScene(_dialogueScene, _playerIndex)
{
}