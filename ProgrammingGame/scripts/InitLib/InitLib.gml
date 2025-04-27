function __loaderBase() constructor 
{
    static Process = function(_init) { return true; }
}

function LoaderSystem() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // create gamestate object
        // load system data
        // load persistent camera
        
        global.FilePath = string_concat(environment_get_variable("LOCALAPPDATA"), "\\GameMaker\\" ,"ProgrammingResults.json");

        randomize();

        return true;
    }    
}

function LoaderAssets() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // load assets
        // load fonts
        // load sprites
        // load sounds
        // load shaders

        get_perlin_noise_buffer();
        return true;
    }    
}

function LoaderGameData() : __loaderBase() constructor 
{
    static Process = function(_init) 
    {
        // load game data
        // load levels
        // load objects

        return true;
    }    
}