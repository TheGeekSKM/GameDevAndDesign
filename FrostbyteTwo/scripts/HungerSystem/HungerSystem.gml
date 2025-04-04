function HungerSystem(_stats, _owner, _enabled = true)  : Component("hunger")  constructor {
    owner = _owner;
    stats = _stats;
    maxHunger = _stats.GetMaxHunger();
    currentHunger = maxHunger;
    enabled = _enabled;
    followHunger = 0;

    function Step()
    {
        if (!enabled) return;
        maxHunger = stats.GetMaxHunger();

        if (currentHunger > 0 && (owner.canMove or owner.speed != 0))
        {
            currentHunger -= stats.GetHungerRate();
        }

        if (currentHunger <= 0)
        {
            currentHunger = 0;
            owner.entityHealth.TakeDamage(0.05, DamageType.HUNGER, owner.id);
        }

        followHunger = lerp(followHunger, currentHunger, 0.1);
        followHunger = clamp(followHunger, 0, maxHunger);
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

    function Draw(_width, _height, _x, _y, _color, _followColor)
    {
        draw_healthbar(_x, _y, _x + _width, _y + _height, (followHunger / maxHunger) * 100, _followColor, _followColor, _followColor, 0, false, false);
        draw_healthbar(_x, _y, _x + _width, _y + _height, (currentHunger / maxHunger) * 100, _color, _color, _color, 0, false, false);
    }
}