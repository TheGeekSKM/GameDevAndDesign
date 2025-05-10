function UpdateScale(_baseW, _baseH, centerWindow = true)
{
    // 1) Current monitor size
    var monW = display_get_width();
    var monH = display_get_height();

    // 2) How many times bigger (or smaller) than 1080p
    var scale = monH / 1080.0;

    // 3) Calculate new window size
    var winW = round(_baseW * scale);
    var winH = round(_baseH * scale);

    //   Make sure we don't exceed monitor width (ultra-wide monitors)
    if (winW > monW)
    {
        var overscale = monW / winW;
        winW = round(winW * overscale);
        winH = round(winH * overscale);
        scale = winW / _baseW;          // update scale to final value
    }

    // 4) Keep the internal render size fixed (your design res)
    surface_resize(application_surface, _baseW, _baseH);

    // 5) Resize and center the window
    window_set_size(winW, winH);
    window_set_position((monW - winW) div 2, (monH - winH) div 2);

    // 6) Store scale for GUI draw
    global.viewScale  = scale;
    global.baseWidth  = _baseW;
    global.baseHeight = _baseH;
}