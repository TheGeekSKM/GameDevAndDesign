// if game instance has child
if (global.GAME_INSTANCE_ID <= global.GAME_INSTANCE_MAX - 1) 
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
    
    //// global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
    //if (global.CHILD_PROCESS_ID_1 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_1)) {
      //// die if child is dead
        //var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_1) + ".tmp";
        //if (file_exists(fname)) 
        //{
            //var fd = file_text_open_read(fname);
            //if (fd != -1) 
            //{
                //var str = file_text_read_string(fd);
                //file_text_readln(fd);
                //file_text_close(fd);
                //if (str == "CHILD_PROCESS_DIED") 
                //{
                    //game_end();
                //}
            //} 
            //else 
            //{
                //show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            //}
        //}
    //}
    //
    //// global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        //if (global.CHILD_PROCESS_ID_2 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_2)) {
        //// die if child is dead
            //var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_2) + ".tmp";
            //if (file_exists(fname)) 
            //{
                //var fd = file_text_open_read(fname);
                //if (fd != -1) 
                //{
                    //var str = file_text_read_string(fd);
                    //file_text_readln(fd);
                    //file_text_close(fd);
                    //if (str == "CHILD_PROCESS_DIED") 
                    //{
                        //game_end();
                    //}
                //} 
                //else 
                //{
                    //show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
                //}
            //}
        //}
    //
    //// global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        //if (global.CHILD_PROCESS_ID_3 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_3)) {
        //// die if child is dead
            //var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_3) + ".tmp";
            //if (file_exists(fname)) 
            //{
                //var fd = file_text_open_read(fname);
                //if (fd != -1) 
                //{
                    //var str = file_text_read_string(fd);
                    //file_text_readln(fd);
                    //file_text_close(fd);
                    //if (str == "CHILD_PROCESS_DIED") 
                    //{
                        //game_end();
                    //}
                //} 
                //else 
                //{
                    //show_error("ERROR: Failed to open file for reading!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
                //}
            //}
        //}
}