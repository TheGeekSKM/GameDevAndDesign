event_inherited();
open = false;
function OnInteract() {
    open = !open;
    show_debug_message($"{open}")
}