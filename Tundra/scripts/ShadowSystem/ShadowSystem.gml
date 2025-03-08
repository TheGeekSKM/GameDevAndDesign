function ShadowCaster(_ownerID) constructor { 
    owner = _ownerID;
    
    function Draw() {
        draw_set_alpha(0.7);
        draw_circle_color(owner.x, owner.y, 10, c_black, c_black, false);
        draw_set_alpha(1);
    }
}
