fsm = new SnowState("idle");


fsm.add("idle", {
    enter: function() {
        image_index = 0;
        image_speed = 0;
    },
    
    step: function() {
        image_blend = merge_color(image_blend, c_white, 0.1);
    },
    
    draw: function() {
        draw_self();
        scribble(Text)
            .align(fa_center, fa_middle)
            .transform(1, 1, image_angle)        
            .starting_format("Font", c_black)
            .draw(x, y);
    }
});

fsm.add("hovered", {
    enter: function() {
        image_index = 0;
        image_speed = 0;
    },
    
    step: function() {
        image_blend = merge_color(image_blend, c_white, 0.1);
    },
    
    draw: function() {
        draw_self();
        scribble($"> {Text} <")
            .align(fa_center, fa_middle)
            .starting_format("Font", c_black)
            .transform(1, 1, image_angle)
            .sdf_shadow(c_black, 0.7, 0, 0, 20)
            .draw(x, y);
    },
});

fsm.add("clicked", {
    enter: function() {
        image_index = 1;
        image_speed = 0;
        image_blend = make_color_rgb(84, 78, 104);
    },
    
    draw: function() {
        draw_self();
        scribble($"> {Text} <")
            .align(fa_center, fa_middle)
            .starting_format("Font", c_black)
            .transform(1, 1, image_angle)        
            .sdf_shadow(c_black, 0.7, 0, 0, 20)
            .draw(x, y + 5);
    },
});

function OnClickEnd()
{
    
}

Manager.AddButtonToList(id);