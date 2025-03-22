// Countdown Timer
consume_timer += 1;

if (consume_timer >= consume_interval) {
    // Pick a random resource
    var resource_index = irandom(2);
    var resource_chosen = resources[resource_index];

    // Consume the chosen resource if available
    switch (resource_chosen) {
        case "CPU":
            if (cpu_stock > 0) cpu_stock -= 1;
            break;
        case "GPU":
            if (gpu_stock > 0) gpu_stock -= 1;
            break;
        case "RAM":
            if (ram_stock > 0) ram_stock -= 1;
            break;
    }

    // Reset timer with a new interval (random between 2-3 sec)
    consume_timer = 0;
    consume_interval = irandom_range(120, 180);

    var total = cpu_stock + gpu_stock + ram_stock;
    if (total <= 0) Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

if (playerInRange != noone)
{
    var key = global.vars.InputManager.GetKey(playerInRange.PlayerIndex, ActionType.Action1);
    interactText = $"\"{KeybindToString(key)}\" to Open PC";
}
