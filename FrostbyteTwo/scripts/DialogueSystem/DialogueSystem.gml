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

	/// @desc Returns the current line of dialogue
	/// @param {SpeakerData} _speakerData the data of the speaker
	/// @param {string} _line the line of dialogue
    function AddDialogue(_speakerData, _line)
    {
        var line = new DialogueLine(_speakerData, _line);
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

function DialogueLine(_speakerData, _line) constructor {
	speakerData = _speakerData;
	line = _line;
}

function SpeakerData(_speakerName, _speakerColor) constructor {
	speakerName = _speakerName;
	speakerColor = _speakerColor;
}