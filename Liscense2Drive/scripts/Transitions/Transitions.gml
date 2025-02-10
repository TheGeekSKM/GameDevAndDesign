global.midTransition = false;
global.roomTarget = -1;

#macro camX camera_get_view_x(camera_get_active())
#macro camY camera_get_view_y(camera_get_active())

function TransitionPlace(_type) 
{
    if (layer_exists("transition")) layer_destroy("transition"); 
    var _layer = layer_create(-9999, "transition");
    
    layer_sequence_create(_layer, camX, camY, _type);
}

function Transition(_roomTarget, _typeOut, _typeIn)
{
    if (!global.midTransition)
    {
        global.midTransition = true;
        global.roomTarget = _roomTarget;
        
        TransitionPlace(_typeOut);
        
        layer_set_target_room(_roomTarget);
        TransitionPlace(_typeIn);
        layer_reset_target_room();
        
        return true;
    }
    else return false;
}

function TransitionChangeRoom()
{
    room_goto(global.roomTarget);
}

function TransitionFinished()
{
    layer_sequence_destroy(self.elementID);
    global.midTransition = false;
}