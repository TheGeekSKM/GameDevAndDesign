// Inherit the parent event
event_inherited();

index = irandom_range(0, 2);
count = irandom_range(1, 3);

possibleParts = [
    new Item().SetName("GPU")
        .SetDescription("Consuming the GPU will make you more powerful and give a temporary boost to your [wave]Strength[/wave]!")
        .SetWeight(3)
        .SetSprite(spr_pcParts)
        .AddStatIncrease(new StatIncrease(AttributeType.Strength, irandom_range(1, 2), random(2))),
    new Item().SetName("Motherboard")
        .SetDescription("Consuming the Motherboard will make you more robust and give a temporary boost to your [wave]Constitution[/wave]!")
        .SetWeight(3)
        .SetSprite(spr_pcParts)
        .AddStatIncrease(new StatIncrease(AttributeType.Constitution, irandom_range(1, 2), random(2))),
    new Item().SetName("RAM Stick")
        .SetDescription("Consuming the RAM Stick will make you more expeditious and give a temporary boost to your [wave]Dexterity[/wave]!")
        .SetWeight(3)
        .SetSprite(spr_pcParts)
        .AddStatIncrease(new StatIncrease(AttributeType.Dexterity, irandom_range(1, 2), random(2)))
];

Initialize(possibleParts[index], count);
image_index = index;

spr = [];
for (var i = 1; i < count; i++)
{
    array_push(
        spr,
        [ x + random_range(-5, 5), y + random_range(-5, 5), random(360)]
    );
}