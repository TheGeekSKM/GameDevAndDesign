enum UIMenuState
{
    NONE,
    DROPDOWN,
    CRAFTING,
    DIALOGUE,
    INVENTORY,
    PAUSE,
    PCVIEW,
    QUEST,
    STATS
}

currentState = UIMenuState.NONE;


function ShowMenuState(_state)
{
    OnExit();
    currentState = _state;
    OnEnter();
}

function OnExit()
{
    switch (currentState)
    {
        case UIMenuState.NONE:
            // No action needed for NONE state
            break;
        case UIMenuState.DROPDOWN:
            // Code to exit dropdown menu
            break;
        case UIMenuState.CRAFTING:
            // Code to exit crafting menu
            break;
        case UIMenuState.DIALOGUE:
            // Code to exit dialogue menu
            break;
        case UIMenuState.INVENTORY:
            // Code to exit inventory menu
            break;
        case UIMenuState.PAUSE:
            // Code to exit pause menu
            break;
        case UIMenuState.PCVIEW:
            // Code to exit PC view menu
            break;
        case UIMenuState.QUEST:
            // Code to exit quest menu
            break;
        case UIMenuState.STATS:
            // Code to exit stats menu
            break;
    }
}

function OnEnter()
{
    switch (currentState)
    {
        case UIMenuState.NONE:
            // No action needed for NONE state
            break;
        case UIMenuState.DROPDOWN:
            // Code to enter dropdown menu
            break;
        case UIMenuState.CRAFTING:
            // Code to enter crafting menu
            break;
        case UIMenuState.DIALOGUE:
            // Code to enter dialogue menu
            break;
        case UIMenuState.INVENTORY:
            // Code to enter inventory menu
            break;
        case UIMenuState.PAUSE:
            // Code to enter pause menu
            break;
        case UIMenuState.PCVIEW:
            // Code to enter PC view menu
            break;
        case UIMenuState.QUEST:
            // Code to enter quest menu
            break;
        case UIMenuState.STATS:
            // Code to enter stats menu
            break;
    }
}