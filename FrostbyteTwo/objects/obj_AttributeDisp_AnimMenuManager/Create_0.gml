if (!layer_exists("Sequences")) layer_create(-100, "Sequences");

seq = layer_sequence_create("Sequences", x, y, Sequence);
layer_sequence_pause(seq);

dragging = false;
mouseOffsetX = 0;
mouseOffsetY = 0;

function StartDragging() {
    dragging = true;
    mouseOffsetX = x - guiMouseX;
    mouseOffsetY = y - guiMouseY;
}
function StopDragging() {
    echo("ball")
    dragging = false;
}