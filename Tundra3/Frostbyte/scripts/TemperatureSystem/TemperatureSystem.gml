function TemperatureSystem(_stats, _health, _owner, _enabled = true) constructor {
    owner = _owner;
    stats = _stats;
    health = _health;
    maxTemperature = _stats.GetMaxTemperature();
    enabled = _enabled;

    currentTemperature = maxTemperature;

    function UseTemperature(amount) { currentTemperature = max(0, currentTemperature - amount); }
    function GetTemperature() { return currentTemperature; }

    function AddWarmth(amount) { currentTemperature = min(maxTemperature, currentTemperature + amount); }

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
            owner.entityHealth.TakeDamage(0.05, DamageType.COLD, owner.id);
            currentTemperature = 0;
        }
    }
}