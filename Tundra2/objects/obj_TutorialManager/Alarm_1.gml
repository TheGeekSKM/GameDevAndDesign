drawSlide = false;
slideIndex++;
if (slideIndex < 5)
{
    alarm[0] = random_range(1, 2) * 60;
}
else {
    layer_sequence_play(seq);
}