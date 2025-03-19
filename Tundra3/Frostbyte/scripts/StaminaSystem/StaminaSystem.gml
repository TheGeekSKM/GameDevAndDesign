/// @desc This is the struct that holds the stats for the StaminaSystem
/// @param {Struct} _stats the stats for the entity
/// @param {Id} _owner the id of the entity
function StaminaSystem(_stats, _owner) constructor {
    owner = _owner;
    stats = _stats;
    maxStamina = _stats.GetMaxStamina();

    currentStamina = maxStamina;

    /// @desc Use stamina
    /// @param {Real} amount the amount of stamina to use
    /// @returns {Bool} whether the stamina can be used or not
    function UseStamina(amount) {
        if (currentStamina < amount) return false;

        currentStamina = max(0, currentStamina - amount);
        return true;
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
    }
}