function Vars() constructor {
	pause = false;
	
	static PauseGame = function(_id)
    {
        Raise("Pause", _id);
        self.pause = true;
    }
	
	static ResumeGame = function(_id)
    {
        Raise("Resume", _id);
        self.pause = false;
    }
    
    CommandLibrary = {};
}

global.vars = new Vars();


