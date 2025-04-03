if (!layer_exists("Sequences")) layer_create(-100, "Sequences");

seq = layer_sequence_create("Sequences", x, y, Sequence);
layer_sequence_pause(seq);

dragging = false;
mouseOffsetX = 0;
mouseOffsetY = 0;

function StartDragging() {
    var mx = guiMouseX;
    var my = guiMouseY;
    dragging = true;
    mouseOffsetX = x - mx;
    mouseOffsetY = y - my;
}
function StopDragging() {
    echo("ball")
    dragging = false;
}