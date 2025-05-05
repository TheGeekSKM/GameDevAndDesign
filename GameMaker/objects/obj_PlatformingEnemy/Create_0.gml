___ = {
    maxHealth : 20,
    onDamageCallback : undefined,
    onDeathCallback : undefined,
    angle : 0,
    canMove : false
}

function Init(_maxHealth, _onDamageCallback = undefined, _onDeathCallback = undefined)
{
    ___.maxHealth = _maxHealth;
    ___[$ "currentHealth"] = _maxHealth;
    if (_onDamageCallback != undefined) ___.onDamageCallback = _onDamageCallback;
    if (_onDeathCallback != undefined) ___.onDeathCallback = _onDeathCallback;
}

function TakeDamage(_damage)
{
    ___.currentHealth -= _damage;
    if (___.currentHealth <= 0)
    {
        ___.currentHealth = 0;
        if (___.onDeathCallback != undefined) ___.onDeathCallback();
            instance_destroy();
    }
    else 
    {
        if (___.onDamageCallback != undefined) ___.onDamageCallback({
            DamageTaken : _damage,
            CurrentHealth : ___.currentHealth
        })
    }
}

Init(1);

_counter = (1.25 * 60);
canShoot = false;