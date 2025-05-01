___ = {
    moveSpeed : 0,
    direction : 0,
    canMove : 0,
    onHitCallback : undefined,
    targetObjects : [],
    onHitObjectSummon : noone,
}

function Init(_moveSpeed, _onHitCallback, _direction, _targetObjects = [], _onHitObjectSummon = noone)
{
    ___.moveSpeed = _moveSpeed;
    ___.direction = _direction;
    ___.onHitCallback = _onHitCallback;
    ___.targetObjects = _targetObjects;
    ___.onHitObjectSummon = _onHitObjectSummon;    
}

alarm[0] = 5 * 60;