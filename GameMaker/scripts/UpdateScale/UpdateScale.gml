function UpdateScale(_internalW, _internalH)
{
    var monW = display_get_width();
    var monH = display_get_height();

    var scale = floor(min(monW / _internalW, monH / _internalH));
    scale = max(scale, 1);

    // Resize application surface to *room* design size
    surface_resize(application_surface, _internalW, _internalH);

    // Resize window to scaled size
    window_set_size(_internalW * scale, _internalH * scale + 2);

    // Center (optional)
    window_set_position((monW - window_get_width()) div 2,
                        (monH - window_get_height()) div 2);

    // Store for Draw GUI scaling
    global.viewScale  = scale;
    global.viewWidth  = _internalW;
    global.viewHeight = _internalH;
}