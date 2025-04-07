// Inherit the parent event
event_inherited();

draw_healthbar(
    topLeft.x + 115, topLeft.y + 64, 
    topLeft.x + 138, topLeft.y + 223, 
    followCPU, 
    c_yellow, c_yellow, c_yellow, 3, false, false
);
draw_healthbar(
    topLeft.x + 115, topLeft.y + 64, 
    topLeft.x + 138, topLeft.y + 223, 
    (obj_PCManager.cpu_stock / 50) * 100, 
    c_green, c_red, c_green, 3, false, false
);

draw_healthbar(
    topLeft.x + 216, topLeft.y + 64, 
    topLeft.x + 239, topLeft.y + 223, 
    followGPU, 
    c_yellow, c_yellow, c_yellow, 3, false, false
);
draw_healthbar(
    topLeft.x + 216, topLeft.y + 64, 
    topLeft.x + 239, topLeft.y + 223, 
    (obj_PCManager.gpu_stock / 50) * 100, 
    c_green, c_red, c_green, 3, false, false
);

draw_healthbar(
    topLeft.x + 315, topLeft.y + 64, 
    topLeft.x + 338, topLeft.y + 223, 
    followRAM, 
    c_yellow, c_yellow, c_yellow, 3, false, false
);
draw_healthbar(
    topLeft.x + 315, topLeft.y + 64, 
    topLeft.x + 338, topLeft.y + 223, 
    (obj_PCManager.ram_stock / 50) * 100, 
    c_green, c_red, c_green, 3, false, false
);