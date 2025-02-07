draw_self();

var arrayLength = array_length(global.QuestLibrary);

if (arrayLength == 0)
{
	var _x = x + (sprite_width / 2);
	var _y = y + (sprite_height / 2);
	
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_color(c_gray);
	draw_set_font(Born);
	
	//draw_text(_x, _y, "You have no quests!");
	draw_text_transformed(_x, _y, "You have no quests!", 3, 3, 45);
}