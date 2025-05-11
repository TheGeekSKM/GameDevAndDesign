if (messageIndex < 0)
{
    global.MainTextBox.AddMessage($"[c_gold]MAIL:[/] New Email Recieved from [slant]gGlint@CrunchCorpGames.xyz[/]. Start the [c_gold][wave]MailManager.exe[/] in the [c_gold]V:[/] drive to see it!")
    //alarm[0] = irandom_range(2, 3) * 3600;
    alarm[0] = irandom_range(5, 10);
    messageIndex++;
}
else {
    if (variable_global_exists("GameData") && global.GameData.CurrentDay > 0)
    {
        var message = GeneratePublisherEmail(global.GameData.Interest, global.GameData.Quality, global.GameData.CurrentDay, global.GameData.MaxNumOfDays);
        if (instance_exists(obj_ChatManager))
        {
            obj_ChatManager.SaveMessage(message.From, message.Subject, message.Text);
        }
        alarm[0] = irandom_range(5, 8) * 3600;
    }
    else
    {
        alarm[0] = irandom_range(5, 10);
    }
}