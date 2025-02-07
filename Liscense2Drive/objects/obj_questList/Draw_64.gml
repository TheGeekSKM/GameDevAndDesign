draw_self();

var arrayLength = array_length(global.QuestLibrary);

if (arrayLength == 0)
{
	sprite_index = spr_noquests26;
}
else 
{
    sprite_index = questBoard;
}