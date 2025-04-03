// Inherit the parent event
event_inherited();

global.NotificationManager = id;
notifictionDisplayRef = noone;

function SetRef(_id) {notifictionDisplayRef = _id; echo($"Set Ref to {_id}");}


Subscribe("NotificationOpen", function(_str) { 
    echo("test")
    if (instance_exists(notifictionDisplayRef))
    {
        notifictionDisplayRef.SetData(_str);
    }
    
    layer_sequence_headdir(seq, seqdir_right);
    layer_sequence_play(seq);
});

Subscribe("NotificationClose", function(_id) {
    layer_sequence_headdir(seq, seqdir_left);
    layer_sequence_play(seq);
});

alarm[0] = 5;