// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("clear", 0, [function() {
    global.MainTextBox.AddMessage("> clear", true)
    global.MainTextBox.ClearBox();

}]);

commandLibrary.AddCommand("cls", 0, [function() {
    global.MainTextBox.AddMessage("> cls", true)
    global.MainTextBox.ClearBox();
}]);

commandLibrary.AddCommand("chat", 0, [function() {
    global.MainTextBox.AddMessage("> chat", true)
    var done = CreateNewWindow(2);
    if (done) global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Opened Chat Window Log!", true);
    else global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Chat Window Log already Open!", true)
}]);

commandLibrary.AddCommand("list", 0, [function() {
    global.MainTextBox.AddMessage($"> list", true);
    var str = global.LocationManager.GetAllOptionsInCurrentMenu();
    global.MainTextBox.AddMessage($"{str}", true);
}]);

commandLibrary.AddCommand("dir", 0, [function() {
    global.MainTextBox.AddMessage($"> dir", true);
    var str = global.LocationManager.GetAllOptionsInCurrentMenu();
    global.MainTextBox.AddMessage($"{str}", true);
}]);

commandLibrary.AddCommand("cd", 1, [function(_args) {
    global.MainTextBox.AddMessage($"> cd {_args[0]}", true);
    if (_args[0] == "..")
    {
        global.LocationManager.GoBackMenu();
        var str = global.LocationManager.GetAllOptionsInCurrentMenu();
        //global.MainTextBox.AddMessage($"{str}", true);
    }
    else
    {
        global.LocationManager.TryOpenElement(_args[0]);
    }
}]);

commandLibrary.AddCommand("start", 1, [function(_args) {
    global.MainTextBox.AddMessage($"> start {_args[0]}", true)
    global.LocationManager.TryOpenElement(_args[0]);
}]);


commandLibrary.AddCommand("exit", 0, [function() {
    global.MainTextBox.AddMessage("> exit", true)
    game_end();
}]);

commandLibrary.AddCommand("help", 0, [function() {
    global.MainTextBox.AddMessage("> help", true)
    CreateNewWindow(5);
}]);

function EnterPressed()
{
    if (text != "" && text != undefined)
    {
        array_push(recentlyEnteredCommands, text);
        recentlyEnteredCommandIndex = array_length(recentlyEnteredCommands);
        echo(recentlyEnteredCommands)
        
        var fileOptionsArray = global.LocationManager.GetFileNameArrayInCurrentMenu();
        for (var i = 0; i < array_length(fileOptionsArray); i++) {
            if (string_trim(string_lower(text)) == string_trim(string_lower(fileOptionsArray[i])))
            {
                if (global.LocationManager.GetFileTypeFromName(fileOptionsArray[i]) == FileType.FILE)
                {
                    text = string_concat("start ", fileOptionsArray[i]);
                }
            }
        }

        // separate the text before the (
        text = string_lower(string_trim(text));
        var textSplit = string_split_ext(text, [ "(", ")", ",", " "], true);
        var commandName = textSplit[0];

        currentKeyword = commandName;
        
        var commandParamArray = [];
        for (var i = 1; i < array_length(textSplit); i += 1) {
            array_push(commandParamArray, textSplit[i]);
        }

        currentParamArray = commandParamArray;

        var couldRun = commandLibrary.RunCommand(commandName, commandParamArray);
        
        if (couldRun) {
            text = "";
            commandParamArray = [];
            return;
        }
        else {
            text = "";
            commandParamArray = [];
        }
        
    }

    FailedToRunCommand();
}

//commandLibrary.AddCommand("mainmenu", 0, [function() {
    //global.WindowManager.GameEnd();
    //Transition(rmInit2, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
//}]);

currentBurnoutValue = 0;
Subscribe("BurnoutModified", function(burnoutAmount) {
    var value = burnoutAmount - currentBurnoutValue;
    var text = "";
    var textCol = c_white;
    
    if (value > 0)
    {
        text = $"Burnout +{value}";
        textCol = c_red;
    }
    else 
    {
        text = $"Burnout -{value}";
        textCol = c_lime;
    }
    
    instance_create_depth(600, 750, depth - 5, obj_PopUpText, {
        textToDisplay : text,
        textColor : textCol
    })
    
    currentBurnoutValue = burnoutAmount;
})

alarm[0] = 45;
messageIndex = -1;

function GeneratePublisherEmail(_interest, _quality, _currentDay, _maxNumOfDays)
{
    var sections = [];
    
    // Interest Section
    var interestText = "";
    if (_interest > 80)
    {
        interestText = "Your game's audience interest is [c_gold]exploding![/] The community forums won't stop talking about it-almost worrying, actually. Hope you can handle the pressure, superstar! Just remember that many many people are watching you very closely. This is the biggest chance you'll get, pal. Prove to me that you have a good reason for existing :) !!";
    }
    else if (_interest > 60)
    {
        interestText = "So, public interest in your game's not bad, kid. People are curious, but remember, curiosity fades quickly if not maintained. Don't let them down. Don't forget that this is the only chance you're ever gonna get in your entire miserable life, bestie <3!! Get Creating!!"
    }
    else if (_interest > 40)
    {
        interestText = "Your game's audience interest is [c_red]low[/]. That is...well...disgusting!! You need more buzz, more hype, more everything! You need to get people talking about your game. You need to make them want it. You need to make them NEED it. I really really hope you can do that, because if you can't, I don't know what to say. I don't want to see you fail, but if you do, it's not my fault. I warned you!!"
    }
    else
    {
        interestText = "I was searching Steam and...it seems that no one has ever heard of your game...? Lemme spell it out for ya: THIS IS A BIG PROBLEM!! CAN YOU SEE THAT?! MAKE DEVLOGS NOW!! MAKE TRAILERS NOW!! MAKE EVERYTHING NOW!! Please for the love of any god, do not let us down!!"
    }
    array_push(sections, interestText);

    // Quality Section
    var qualityText = "";
    if (_quality > 80)
    {
        qualityText = "Your game is looking [c_gold]amazing[/]! I can't believe how good it looks. I mean, wow. Just wow. You are a genius. This is the kind of work that gives your life any value! If you don't keep this up, you're life WILL become meaningless. Keep working hard, and remember that sleep just holds you back!";
    }
    else if (_quality > 60)
    {
        qualityText = "This is good! This is definitely good. It will be...well...it'll be a game, right? But...it could be much better. You know this. You know that you can do better. You know that you have the potential to make something truly great. So why are you holding back? Why are you wasting your time on this mediocre project? You need to push yourself harder. You need to work harder. You need to make this game the best it can be. You need to make it a game that people will remember for years to come, because that is the only meaning to your life.";
    }
    else if (_quality > 40)
    {
        qualityText = "I am so impressed by the sheer level of mediocrity you have achieved. If I ate Airplane food and threw it back up, it'd look a lot like this. Be better, please. Don't make me beg. Stop screwing around. No one will care about you unless you make something worth caring about!";
    }
    else
    {
        qualityText = "[c_red]This is not a game. This is a liability.[/] If we had known this was your idea of 'development', we would've gone with literally anyone else. Please stop. You're not worth the investment. You're probably not worth anyone's investment.";
    }
    array_push(sections, qualityText);

    var deadline = _currentDay / _maxNumOfDays;
    var deadlineText = "";
    if (deadline < 0.3)
    {
        deadlineText = "I wanna point out that you might feel as if you've got plenty of time, right? That's what the last five devs thought. Only one of them shipped anything. Spoiler: no one knows who that person is anymore.";
    }
    else if (deadline < 0.5)
    {
        deadlineText = "Half the time's gone. Are you halfway done? Or are we staring at a beautiful menu screen and excuses? Don't answer. Show us.";
    }
    else if (deadline < 0.7)
    {
        deadlineText = "[wave]Crunch time is knocking[/wave], and we're not seeing 'crunch' - we're seeing 'stall'. Work smarter, harder, faster. Preferably all three.";
    }
    else
    {
        deadlineText = "[c_red]This is your final sprint.[/] Hope you like working weekends. People are watching. Don't ruin this.";
    }
    array_push(sections, deadlineText);

    array_shuffle(sections);
    var msg = string_concat(sections[0], "\n\n", sections[1], "\n\n", sections[2]);

    var critical = min(_interest, _quality);
    var deadline_pct = _currentDay / _maxNumOfDays;
    var subject = "";
    if (deadline_pct >= 0.9) 
    {
        subject = "We're All Holding Our Breath";
    }
    else if (critical > 75) 
    {
        subject = "Hope You Can Keep This Up";
    }
    else if (critical > 50) 
    {
        subject = "The Numbers Make Us Nervous";
    }
    else 
    {
        subject = "This Needs Fixing. Fast.";
    }

    return {
        From: "Gregory Glint <gGlint@crunchcorpgames.xyz>",
        Subject: subject,
        Text: msg
    }
}