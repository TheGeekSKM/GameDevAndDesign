if (canEat)
{
    if (instance_exists(targetFoodSource))
    {
        targetFoodSource.DecreaseFood();
        entityHealth.Heal(0.5);
        hunger.Eat(500);
        // Eat food source
    }

    alarm[2] = irandom_range(15, 45);
}