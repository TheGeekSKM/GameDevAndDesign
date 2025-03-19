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

        if (currentHunger < maxHunger && owner.speed != 0)
        {
            currentHunger -= stats.GetHungerRate();
        }

        if (currentHunger <= 0)
        {
            currentHunger = 0;
            owner.health.TakeDamage(1, DamageType.HUNGER);
        }
    }
}