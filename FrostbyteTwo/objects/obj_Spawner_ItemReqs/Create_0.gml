// Inherit the parent event
event_inherited();

SetData([
    obj_ItemReq_CopperDeposit, 
    obj_ItemReq_SiliconDeposit,
    obj_ItemReq_BauxiteDeposit,
    obj_ItemReq_GoldDeposit,
    obj_ItemReq_GraphiteDesposit,
    obj_ItemReq_LeadDeposit,
    obj_ItemReq_PlasticDeposit,
    obj_ItemReq_SandDeposit,
    obj_ItemReq_SteelDeposit,
    obj_ItemReq_ThermalGooDeposit
], [obj_BASE_Entity, obj_Blocker], 150, "LowerInteractables");