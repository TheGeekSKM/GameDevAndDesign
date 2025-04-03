function EntityData(_stats, _inventory)  : Component("entityData")  constructor  {
    stats = _stats;
    inventory = _inventory;
    moveSpeed = 0;
    
    slowed = false;


    function Step() {
        moveSpeed = round(stats.GetMoveSpeed(inventory.GetCurrentWeight()));
    }
}