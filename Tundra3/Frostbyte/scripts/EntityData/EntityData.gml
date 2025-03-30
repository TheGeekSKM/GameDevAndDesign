function EntityData(_stats, _inventory) constructor {
    stats = _stats;
    inventory = _inventory;
    moveSpeed = 0;
    
    slowed = false;


    function Step() {
        moveSpeed = stats.GetMoveSpeed(inventory.GetCurrentWeight()) * (slowed ? 0.5 : 1);
    }
}