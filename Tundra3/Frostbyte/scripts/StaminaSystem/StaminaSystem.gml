/// @desc This is the struct that holds the stats for the StaminaSystem
/// @param {Struct} _stats the stats for the entity
/// @param {Id} _owner the id of the entity
function StaminaSystem(_stats, _owner) constructor {
    owner = _owner;
    stats = _stats;
    maxStamina = _stats.GetMaxStamina();

    followStamina = 0;

    currentStamina = maxStamina;

    /// @desc Use stamina
    /// @param {Real} amount the amount of stamina to use
    /// @returns {Bool} whether the stamina can be used or not
    function UseStamina(amount) {
        if (currentStamina < amount) return false;

        currentStamina = max(0, currentStamina - amount);
        return true;
    }

    function AddStamina(amount) {
        currentStamina = min(maxStamina, currentStamina + amount);
    }

    function GetStamina() {
        return currentStamina;
    }

    function Step() {
        maxStamina = stats.GetMaxStamina();

        if (currentStamina < maxStamina && owner.speed == 0) {
            currentStamina = min(maxStamina, currentStamina + 1);
        }

        if (currentStamina > maxStamina) {
            currentStamina = maxStamina;
        }

        followStamina = lerp(followStamina, currentStamina, 0.1);
        followStamina = clamp(followStamina, 0, maxStamina);
    }

    function Draw(_width, _height, _x, _y, _color, _followColor) {
        draw_healthbar(_x, _y, _x + _width, _y + _height, (followStamina / maxStamina) * 100, _followColor, _followColor, _followColor, 0, false, false);
        draw_healthbar(_x, _y, _x + _width, _y + _height, (currentStamina / maxStamina) * 100, _color, _color, _color, 0, false, false);
    }
}