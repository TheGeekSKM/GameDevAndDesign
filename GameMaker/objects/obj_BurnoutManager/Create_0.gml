Subscribe("BurnoutModified", function(_value) {

    heatWaveFX = layer_get_fx("HeatWave");
    heatWaveFXParams = fx_get_parameters(heatWaveFX);

    var _burnout = global.GameData.Burnout;
    var _burnoutPercent = _burnout / 10; // 0 to 1.0
    echo($"Burnout%: {_burnoutPercent}")
    
    var part1 = _burnoutPercent * 3;
    var part2 = _burnoutPercent * 5;
    
    echo(part1)
    echo(part2)
    
    heatWaveFXParams.g_Distort1Amount = part1;
    heatWaveFXParams.g_Distort2Amount = part2;
    
    fx_set_parameters(heatWaveFX, heatWaveFXParams);
    
    echo(fx_get_parameters(heatWaveFX))

})