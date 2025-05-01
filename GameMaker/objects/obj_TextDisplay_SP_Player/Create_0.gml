currentFunctionSlotIndex = 0;
currentFunctionSlot = noone;

function CurrentIndexUpdated()
{
    if (instance_exists(currentFunctionSlot))
    {
        // save the code in the code editor into the currentFunctionSlot
        currentFunctionSlot.NotSelected();
        currentFunctionSlot = noone;
    }
    
    switch(currentFunctionSlotIndex)
    {
        case 0:
            currentFunctionSlot = obj_FuncHolder_1;    
        break;
        
        case 1:
            currentFunctionSlot = obj_FuncHolder_2;    
        break;
        
        case 2:
            currentFunctionSlot = obj_FuncHolder_3;    
        break;
    }
    
    if (instance_exists(currentFunctionSlot))
    {
        // open up the new function code in the codeEditor
        
        currentFunctionSlot.Selected();
        Raise("NewFunctionSlotSelected", currentFunctionSlot);
    }
}

CurrentIndexUpdated();