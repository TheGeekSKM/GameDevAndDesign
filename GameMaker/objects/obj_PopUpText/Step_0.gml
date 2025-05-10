fadeCounter++;
guiCoords.y = lerp(guiCoords.y, lastPos, 0.05);
textAlpha = 1 - (fadeCounter / fadeTime);