if (layer_exists("GUI"))
{
    timePassedSequence = layer_sequence_create("GUI", 0, 0, seq_BetweenDays);
    layer_sequence_pause(timePassedSequence);
}