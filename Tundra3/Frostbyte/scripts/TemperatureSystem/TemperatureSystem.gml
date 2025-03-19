function TemperatureSystem(_stats, _health, _owner, _enabled = true) constructor {
    owner = _owner;
    stats = _stats;
    health = _health;
    maxTemperature = _stats.GetMaxTemperature();
    enabled = _enabled;

    currentTemperature = maxTemperature;

    function UseTemperature(amount) { currentTemperature = max(0, currentTemperature - amount); }
    function GetTemperature() { return currentTemperature; }

    function Step() 
    {
        if (!enabled) return;   
        maxTemperature = stats.GetMaxTemperature();

        if (currentTemperature < maxTemperature && owner.speed != 0) 
        {
            currentTemperature -= stats.GetTemperatureRate();
        }

        if (currentTemperature < 0) 
        {
            health.TakeDamage(1, DamageType.COLD);
            currentTemperature = 0;
        }
    }
}