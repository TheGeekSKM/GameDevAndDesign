function drawText(xPos = undefined, yPos = undefined, halign = undefined, valign = undefined, textFont = undefined, textColor = undefined, text = undefined){
	xPos ??= 0;
	yPos ??= 0;
	halign ??= fa_center;
	valign ??= fa_middle;
	textFont ??= Born;
	textColor ??= c_white;
	text ??= "Default Text";
	
	
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(textFont);
	draw_set_color(textColor);
	
	draw_text(xPos, yPos, text);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(textFont);
	draw_set_color(c_white);
}