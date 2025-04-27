// --- Clean Up Event ---
// Make sure this event exists and frees the map
if (ds_exists(variableStore, ds_type_map)) 
{
    ds_map_destroy(variableStore);
}