function TemperatureSystem(_stats, _health, _owner, _enabled = true)  : Component("temperature")  constructor {
    owner = _owner;
    stats = _stats;
    health = _health;
    maxTemperature = _stats.GetMaxTemperature();
    enabled = _enabled;

    followTemperature = 0;
    currentTemperature = maxTemperature;

    function UseTemperature(amount) { currentTemperature = max(0, currentTemperature - amount); }
    function GetTemperature() { return currentTemperature; }

    function AddWarmth(amount) { currentTemperature = min(maxTemperature, currentTemperature + amount); }

    function Step() 
    {
        if (!enabled) return;   
        maxTemperature = stats.GetMaxTemperature();

        currentTemperature -= stats.GetTemperatureRate();

        if (currentTemperature < 0) 
        {
            owner.entityHealth.TakeDamage(0.05, DamageType.TEMP, owner.id);
            currentTemperature = 0;
        }

        followTemperature = lerp(followTemperature, currentTemperature, 0.1);
        followTemperature = clamp(followTemperature, 0, maxTemperature);
    }

    function Draw(_width, _height, _x, _y, _color, _followColor) 
    {
        draw_healthbar(_x, _y, _x + _width, _y + _height, (followTemperature / maxTemperature) * 100, _followColor, _followColor, _followColor, 0, false, false);
        draw_healthbar(_x, _y, _x + _width, _y + _height, (currentTemperature / maxTemperature) * 100, _color, _color, _color, 0, false, false);
    }
}