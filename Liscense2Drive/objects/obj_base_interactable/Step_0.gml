if (point_distance(x, y, obj_player.x, obj_player.y) <= interactableRange)
    {
        playerInRange = true;
        SwitchState(InteractableState.Interactable);
    }
    else {
        playerInRange = false;
    }
    
    switch (currentInteractableState)
    {
        case InteractableState.NotInteractable: 
            TurnToLook();
            break;
        case InteractableState.Interactable:
            LookAtPlayer();   
    }