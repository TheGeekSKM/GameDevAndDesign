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

        randomize();
        //instance_create_depth(0, 0, -1600, display_manager);
        instance_create_depth(0, 0, -1600, obj_Mouse);
        global.textDisplay = "\"[c_yellowPalette]These creatures that walk in your footsteps...they have no hope, save you...[/]\"";
        global.textDisplay = string_concat(global.textDisplay, "[c_parchment], your father's voice croaks...\n\n[/]");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]They cling to you like the seeds of a thorn-bush...[/]\"\n\n");
        global.textDisplay = string_concat(global.textDisplay, "[c_parchment]The sounds of your father coughing echo amongst the rotting wood...[/]\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]You must lead them unto salvation, my child...[/]\"\n\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_lighterPurple]What is this salvation you speak of, father? Where does it lie?[/]\"\n\n\n");
        global.textDisplay = string_concat(global.textDisplay, "\"[c_yellowPalette]...[/]\"\n\n\n");
        
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