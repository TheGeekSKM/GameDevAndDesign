enum QuestState
{
	Inactive,
	Active,
	Completed
}

/// @description Quest struct
/// @param {string} _name
/// @param {string} _description
/// @param {id} _giver
function Quest(_name, _description, _giver) constructor
{
	name = _name;
	description = _description;
	giver = _giver;
	state = QuestState.Inactive;
	index = -1; // index in the quest list
}

/// @description Get quest by name
/// @param {string} _name
function GetQuest(_name)
{
	if (variable_struct_exists(global.vars.QuestList, _name))
	{
		return global.vars.QuestList[$ _name];
	}
	else
	{
		show_debug_message("Quest with name " + _name + " does not exist!");
		return undefined;
	}
}

/// @description Add quest to the quest list
/// @param {Struct} _quest
function AddQuest(_quest)
{
	if (variable_struct_exists(global.vars.QuestList, _quest.name))
	{
		show_debug_message("Quest with name " + _quest.name + " already exists!");
		return;
	}

	global.vars.QuestList[$ _quest.name] = _quest;
	_quest.index = GetNumberOfQuests() - 1; // Set the index of the quest in the list
}


function GetNumberOfQuests()
{
	var keys = variable_struct_get_names(global.vars.QuestList);
	return array_length(keys);
}

function GetQuestByIndex(_index)
{
	var keys = variable_struct_get_names(global.vars.QuestList);
	for (var i = 0; i < array_length(keys); i += 1)
	{
		var quest = global.vars.QuestList[$ keys[i]];
		if (quest.index == _index)
		{
			return quest;
		}
	}
}

function QuestStateToString(_state)
{
	switch (_state)
	{
		case QuestState.Inactive:
			return "Inactive";
		case QuestState.Active:
			return "Active";
		case QuestState.Completed:
			return "Completed";
		default:
			return "Unknown";
	}
}
