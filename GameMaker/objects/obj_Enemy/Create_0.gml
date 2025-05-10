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
    var inst = instance_create_layer(x, y, layer, obj_HitFeedback);
    inst.image_angle = random(360);
    if (___.currentHealth <= 0)
    {
        ___.currentHealth = 0;
        if (___.onDeathCallback != undefined) ___.onDeathCallback();
        global.ProgrammingScore += 1;
    }
    else 
    {
        if (___.onDamageCallback != undefined) ___.onDamageCallback({
            DamageTaken : _damage,
            CurrentHealth : ___.currentHealth
        })
    }
}



Init(5);

_counter = (1.25 * 60);
canShoot = false;