if (!layer_exists("Sequences")) layer_create(-100, "Sequences");

seq = layer_sequence_create("Sequences", SeqCreateX, SeqCreateY, Sequence);
layer_sequence_pause(seq);

dragging = false;
mouseOffsetX = 0;
mouseOffsetY = 0;

open = false;

function StartDragging() {
    var mx = guiMouseX;
    var my = guiMouseY;
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
    open = true;  
}

function CloseMenu()
{
    layer_sequence_headdir(seq, seqdir_left);
    layer_sequence_play(seq);
    open = false;
}