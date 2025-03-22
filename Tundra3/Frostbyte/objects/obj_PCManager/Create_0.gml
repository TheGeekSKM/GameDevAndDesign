event_inherited();
// Resources
cpu_stock = irandom_range(30, 50); // Initial CPU stock
gpu_stock = irandom_range(30, 50);; // Initial GPU stock
ram_stock = irandom_range(30, 50);; // Initial RAM stock

// Consumption Timer
consume_timer = 0;
consume_interval = irandom_range(120, 180); // 2-3 seconds at 60 FPS

// Possible resources to consume
resources = ["CPU", "GPU", "RAM"];

function OnInteract()
{
    global.vars.Players[playerInRange.PlayerIndex].controller.OpenMenu();
}

function ToString()
{
    var str = "";
    str += $"CPU: {cpu_stock}\n";
    str += $"GPU: {gpu_stock}\n";
    str += $"RAM: {ram_stock}\n";
    return str;
}
