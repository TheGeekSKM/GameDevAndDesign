// Inherit the parent event
event_inherited();

AddMessage(@"[c_yellow][scale, 2]help[/]
- Opens this Command Help Window.
- No parameters are required.");

AddMessage(@"[c_yellow][scale, 2]cls[/]
- Clears the current Text Stream to tidy up the CLI.
- No parameters are required.");

AddMessage(@"[c_yellow][scale, 2]dir[/]
- Lists out all of the directories and files in the current directory location.
- No parameters are required.");

AddMessage(@"[c_yellow][scale, 2]cd [slant]_fileName[/slant][/]
- Opens the specified directory.
- Requires 1 parameter (_fileName) which needs to be the exact name of the directory you wish to open.");

AddMessage(@"[c_yellow][scale, 2]start [slant]_fileName[/slant][/]
- Runs the specified file.
- Requires 1 parameter (_fileName) which needs to be the exact name of the file you wish to open.");

AddMessage(@"[c_yellow][scale, 2]exit[/]
- Closes out of the Virtual Machine and allows you to go on with your life.
- No parameters are required.");

AddMessage(@"[c_yellow][scale, 2]cd ..[/]
- Exits out of the current directory and goes to the previous directory.
- No parameters are required.");

ScrollToTop();