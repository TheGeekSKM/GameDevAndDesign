// if game instance has child
if (global.GAME_INSTANCE_ID == 0) 
{ // if parent process
    fname = global.saveLocation + "proc/" + string(ProcIdFromSelf()) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                game_end();
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }
    
    fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_1) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                global.CHILD_PROCESS_ID_1 = 0
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }
    
    fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_2) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                global.CHILD_PROCESS_ID_2 = 0
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }    
    
    fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_3) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                global.CHILD_PROCESS_ID_3 = 0
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }
    
    fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_4) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                global.CHILD_PROCESS_ID_4 = 0
            }
            var data = SafeReadJson(working_directory + "GameData.json");
            global.GameData = data;
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] Great! Game Data Stored! Feel free to check the Log.txt in the V: Folder to see your deadline!");
            
            
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }  
    
    fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_5) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "CHILD_PROCESS_DIED") 
            {
                global.CHILD_PROCESS_ID_5 = 0
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }      
}
else 
{
    // if child process
    var fname = global.saveLocation + "proc/" + string(ProcIdFromSelf()) + ".tmp";
    if (file_exists(fname)) 
    {
        var fd = file_text_open_read(fname);
        if (fd != -1) 
        {
            var str = file_text_read_string(fd);
            file_text_readln(fd);
            file_text_close(fd);
            if (str == "GAME_PROCESS_DIED") 
            {
                game_end();
            }
        } 
        else 
        {
            show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }
}