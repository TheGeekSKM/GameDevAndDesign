echo("test")
// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("enter", 0, [function() {
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide)
    var initialMessage = @"Hello [c_yellow]Developer[/],

Congratulations! You've been selected for our exclusive [slant]Trial-by-Fire[/slant] initiative here at [c_red]CrunchCorp Games[/]. This is your chance to show us you have what it takes-just like the countless talented (and, honestly, very productive) developers who've come before you.

Here's the deal: you'll have a limited amount of time to fully develop and market your game. Keep in mind, payment is contingent upon successful delivery of the final product. After completion, you'll earn a fair percentage of whatever revenue is left after standard deductions.    

Most devs we've worked with have managed to deliver results without needing constant reassurance, so we're confident you'll rise to the challenge. Good luck, and remember-your peers are watching.
    
Any questions, please hesitate to ask.

Mild Regards,
[c_lime]Gregory Glint[/]
Lead Talent Manager
[c_red]CrunchCorp Games[/]
[slant]Turning passion into profit![/]"
    var from = "gGlint@CrunchCorpGames.xyz";
    var subject = "Re:Delayed Response Regarding Game Publishing";
    
    if (instance_exists(obj_ChatManager))
    {
        obj_ChatManager.SaveMessage(from, subject, initialMessage);
    }
    else {
        show_error($"No Chat Manager", true);
    }
    
}]);
commandLibrary.AddCommand("credits", 0, [function() {
    CreateNewWindow(1);    
}]);

commandLibrary.AddCommand("exit", 0, [function() {
    game_end();    
}]);