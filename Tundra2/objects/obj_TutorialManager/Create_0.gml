slideIndex = 0
drawSlide = false;
slides = ["Click to Live", "You MUST NOT die!", "kill", "Kill", "KILL"]
if (!layer_exists("Sequences")) layer_create(-100, "Sequences");
seq = layer_sequence_create("Sequences", 0, 0, seq_HUD);
layer_sequence_pause(seq);


alarm[0] = 1.2 * 60;

alarm[2] = 5 * 60;