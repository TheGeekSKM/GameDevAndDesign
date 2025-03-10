enum MenuState
{
    Opened,
    Closed
}

if (!layer_exists("Sequences")) layer_create(-100, "Sequences");

seq = layer_sequence_create("Sequences", 400, 224, Sequence);
layer_sequence_pause(seq);

dragging = false;
mouseOffsetX = 0;
mouseOffsetY = 0;

function StartDragging() {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    dragging = true;
    mouseOffsetX = layer_sequence_get_x(seq) - mx;
    mouseOffsetY = layer_sequence_get_y(seq) - my;
}
function StopDragging() {
    echo("ball")
    dragging = false;
}

function OpenMenu()
{
    layer_sequence_headdir(seq, seqdir_right);
    layer_sequence_play(seq);    
}

function CloseMenu()
{
    layer_sequence_headdir(seq, seqdir_left);
    layer_sequence_play(seq);
}