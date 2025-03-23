function DialogueScene() constructor {
	dialogues = [];
	currentLine = -1;
    finished = false;

	function GetNextDialogue()
	{
		if (currentLine + 1 < array_length(dialogues))
		{
            currentLine += 1;
			var line = dialogues[currentLine];
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