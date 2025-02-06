__keyBoardButtons = ds_list_create();
selectedIndex = 0;
oldIndex = 0;
selectedButton = noone;

/// @desc Adds KeyboardButton to Array
/// @param {Any} kbBtnID Ideally, this is an obj_base_keyboardButton
AddToKeyboardButtonManager = function(kbBtnID) {
    ds_list_add(__keyBoardButtons, kbBtnID);
}

RemoveFromKeyboardButtonManager = function(kbBtnID) {
    var index = ds_list_find_index(__keyBoardButtons, kbBtnID);
    ds_list_delete(__keyBoardButtons, index);
}

OnIndexUpdate = function(maxSize) {
    selectedIndex = loop(selectedIndex, 0, maxSize);
    //var btn = __keyBoardButtons[| selectedIndex];
    //if (instance_exists(btn)) {
        //with(btn) {
            //OnClick();
        //}
    //}
    
    var i = 0;
    repeat (maxSize + 1) {
        if (i == selectedIndex) {
            
            // some weird shenanigans since the list stores objects as generics
            var btn = __keyBoardButtons[| selectedIndex];
            if (instance_exists(btn)) {
                with (btn) {
                    OnHover();
                }
                selectedButton = btn;
            }
        }
        else {
            // some weird shenanigans since the list stores objects as generics
            var btn = __keyBoardButtons[| i];
            if (instance_exists(btn)) {
                with (btn) {
                    OnIdle();
                }
            }
        }
        i++;
    }
}
alarm[0] = 2;