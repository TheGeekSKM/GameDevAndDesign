layer_sequence_headdir(pauseMenuSequence, seqdir_left);
layer_sequence_play(pauseMenuSequence);

layer_sequence_headdir(questMenuSequence, seqdir_left);
layer_sequence_play(questMenuSequence);

layer_sequence_headdir(inventoryMenuSequence, seqdir_left);
layer_sequence_play(inventoryMenuSequence);

layer_sequence_headdir(dialogueMenuSequence, seqdir_left);
layer_sequence_play(dialogueMenuSequence);

layer_sequence_headdir(crashDetectorSequence, seqdir_left);
layer_sequence_play(crashDetectorSequence);

layer_sequence_headdir(compassSequence, seqdir_left);
layer_sequence_play(compassSequence);

layer_sequence_destroy(pauseMenuSequence);
layer_sequence_destroy(questMenuSequence);
layer_sequence_destroy(inventoryMenuSequence);
layer_sequence_destroy(dialogueMenuSequence);
layer_sequence_destroy(crashDetectorSequence);
layer_sequence_destroy(compassSequence);