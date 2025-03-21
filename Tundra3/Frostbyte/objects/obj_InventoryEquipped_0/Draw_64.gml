// Inherit the parent event
draw_self();

//draw eqiupped weapon at 120, 50
var equippedWeaponPos = new Vector2(topLeft.x + 120, topLeft.y + 50);
var equippedWeapon = inventory.GetEquippedWeapon();
var weaponName = "---NO WEAPON EQUIPPED---"
if (!equippedWeapon == undefined)
{
    weaponName = equippedWeapon.name;
}
scribble(weaponName)
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(0.75, 0.75, image_angle)
    .draw(equippedWeaponPos.x, equippedWeaponPos.y);

//draw equipped armor at 120, 85
var equippedArmorPos = new Vector2(topLeft.x + 120, topLeft.y + 85);
var equippedArmor = inventory.GetEquippedArmor();
var armorName = "---NO ARMOR EQUIPPED---"
if (!equippedArmor == undefined)
{
    armorName = equippedArmor.name;
}
scribble(armorName)
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(0.75, 0.75, image_angle)
    .draw(equippedArmorPos.x, equippedArmorPos.y);

// draw equipped bullet at 120, 122
var equippedBulletPos = new Vector2(topLeft.x + 120, topLeft.y + 122);
var equippedBullet = inventory.GetEquippedBullet();
var bulletName = "---NO AMMO EQUIPPED---"
if (!equippedBullet == undefined)
{
    bulletName = equippedBullet.name;
}
scribble(bulletName)
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(0.75, 0.75, image_angle)
    .draw(equippedBulletPos.x, equippedBulletPos.y);

//write player stats at 245, 29, wrapping at 94
var damageText = $"Damage: {inventory.GetTotalDamage()} per attack";
var attackSpeedText = $"Attack Cooldown: {inventory.GetWeaponAttackSpeed()}s between hits";
var defenseText = $"Defense: {inventory.GetDefense()} points of damage reduction\n\n(Some of the stats are due to your attributes)";

scribble($"{damageText}\n\n{attackSpeedText}\n\n{defenseText}")
    .align(fa_left, fa_top)
    .starting_format("Font", c_white)
    .transform(0.5, 0.5, image_angle)
    .wrap(98*2)
    .draw(topLeft.x + 245, topLeft.y + 29);



