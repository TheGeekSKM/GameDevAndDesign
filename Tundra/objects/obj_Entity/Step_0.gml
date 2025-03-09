if (mouseOver) hoverCounter++;

if (hoverCounter == 60) {
    echo("MOOVE!!")
    Raise("DisplayInteractableInfo", [infoName, infoString, id]);
}