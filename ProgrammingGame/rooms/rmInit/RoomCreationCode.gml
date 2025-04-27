if (EnvironmentGetVariableExists("OWNER_WINDOW_ID"))
{
    SetOwnerWindowId(string(int64(window_handle())), EnvironmentGetVariable("OWNER_WINDOW_ID"));
}