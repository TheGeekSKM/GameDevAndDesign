function HungerSystem(_stats, _owner, _enabled = true) constructor {
    owner = _owner;
    stats = _stats;
    maxHunger = _stats.GetMaxHunger();
    currentHunger = maxHunger;
    enabled = _enabled;

    function Step()
    {
        if (!enabled) return;
        maxHunger = stats.GetMaxHunger();

        if (currentHunger > 0 && owner.canMove)
        {
            currentHunger -= stats.GetHungerRate();
        }

        if (currentHunger <= 0)
        {
            currentHunger = 0;
            owner.entityHealth.TakeDamage(0.05, DamageType.HUNGER, owner.id);
        }
    }

    function Eat(amount)
    {
        currentHunger += amount;
        if (currentHunger > maxHunger)
        {
            currentHunger = maxHunger;
        }
    }

    function IsHungry()
    {
        return currentHunger <= maxHunger * 0.25;
    }
}