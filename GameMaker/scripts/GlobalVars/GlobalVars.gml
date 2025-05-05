function Vars() constructor {
	pause = false;
	
	function PauseGame(_id) {
		Raise("Pause", _id);
		pause = true;
	}
	
	function ResumeGame(_id) {
		Raise("Resume", _id);
		pause = false;
	}
    
    CommandLibrary = {};
}

global.vars = new Vars();

enum PlayerState { Normal, Dashing, Attacking }

function TimeToScore(sec, bestSec, worstSec)
{
    if (worstSec <= bestSec) worstSec = bestSec + 0.001;
    var t = clamp((sec - bestSec) / (worstSec - bestSec), 0, 1);
    t = 1 - t;   
    t = t * t; // quadratic ease‑in – rewards the really fast runs
    var _score = 10 + (t * 20);   
    return round(_score);
}
