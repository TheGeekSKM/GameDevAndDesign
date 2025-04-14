// Inherit the parent event
event_inherited();

textToDisplay = "";

switch(global.vars.loseReason)
{
    case LoseReason.BANKRUPT:
        textToDisplay = "You have gone bankrupt! The Nobles have accumulated too much wealth and you have lost your title!";
        break;
    case LoseReason.DESERTED:
        textToDisplay = "You have deserted your post...The King will not look upon this kindly!";
        break;
    case LoseReason.NOBLE_SURRENDER:
        textToDisplay = "You surrendered to the Nobles! After robbing you blind, they sent you to the gallows!";
        break;
    case LoseReason.FARMER_SURRENDER:
        textToDisplay = "You surrendered to the Farmers! They have taken your title and sent you to the gallows!";
        break;
    case LoseReason.KILLED:
        textToDisplay = "You have been killed! Anarchy now floods the streets of your Province!";
        break;
}

Init(textToDisplay);