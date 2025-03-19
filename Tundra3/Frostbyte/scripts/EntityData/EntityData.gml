function EntityData(_stats, _inventory) constructor {
    stats = _stats;
    inventory = _inventory;
    moveSpeed = 0;

    function Step() {
        moveSpeed = stats.GetMoveSpeed(inventory.GetCurrentWeight());
    }
}