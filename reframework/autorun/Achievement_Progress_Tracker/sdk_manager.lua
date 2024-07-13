--- IMPORTS
local constants = require("Achievement_Progress_Tracker.constants");
--- END IMPORTS

--- The manager for all things related calling into the sdk.
local sdk_manager = {
    -- The hunter record manager managed singleton from the sdk.
    hunter_record_manager = nil,
    
    -- The player manager managed singleton from the sdk.
    player_manager = nil,
    
    -- The quest manager managed singleton from the sdk.
    quest_manager = nil,

    -- The kpi telemetry manager managed singleton from the sdk.
    kpi_telemetry_manager = nil,
};

---
--- Attempt to get the `HunterReocrdSaveData` (it is spelled this way in-game) object from the game.
---
--- @return userdata? hunter_record_save_data The HunterReocrdSaveData object obtained from the hunter record manager, otherwise nil.
function sdk_manager.get_hunter_record_save_data()
    -- Check if the hunter record manager on the sdk manager is NOT already loaded/valid.
    if not sdk_manager.hunter_record_manager then
        -- If yes, then call into the sdk to get the hunter record manager managed singleton.
        sdk_manager.hunter_record_manager = sdk.get_managed_singleton(constants.type_name.hunter_record_manager);
    end
    
    -- Check if the hunter record manager is stil NOT valid.
    if not sdk_manager.hunter_record_manager then
        -- If yes, then return nil since no hunter record can be found.
        return nil;
    end
    
    -- Return the player object as a result of the find master player call on the hunter record manager.
    return sdk_manager.hunter_record_manager:call("get_SaveData");
end

---
--- Attempt to get the player object from the game.
---
--- @return userdata? player The player object obtained from the player manager, otherwise nil.
function sdk_manager.get_player()
    -- Check if the player manager on the sdk manager is NOT already loaded/valid.
    if not sdk_manager.player_manager then
        -- If yes, then call into the sdk to get the player manager managed singleton.
        sdk_manager.player_manager = sdk.get_managed_singleton(constants.type_name.player_manager);
    end
    
    -- Check if the player manager is stil NOT valid.
    if not sdk_manager.player_manager then
        -- If yes, then return nil since no player can be found.
        return nil;
    end
    
    -- Return the player object as a result of the find master player call on the player manager.
    return sdk_manager.player_manager:call("findMasterPlayer")
end

---
--- Attempt to get the '_EndFlow' field on the quest manager from the game.
---
--- @return any end_flow The '_EndFlow' field value obtained from the quest manager, otherwise nil.
function sdk_manager.get_quest_end_flow()
    -- Check if the quest manager on the sdk manager is NOT already loaded/valid.
    if not sdk_manager.quest_manager then
        -- If yes, then call into the sdk to get the quest manager managed singleton.
        sdk_manager.quest_manager = sdk.get_managed_singleton(constants.type_name.quest_manager);
    end
    
    -- Check if the quest manager is stil NOT valid.
    if not sdk_manager.quest_manager then
        -- If yes, then return nil since no quest can be found.
        return nil;
    end
    
    -- Return the player object as a result of the get field call for the end flow on the quest manager.
    return sdk_manager.quest_manager:get_field("_EndFlow");
end

---
--- Attempt to get the snapshot product object from the game.
---
---@return userdata? snapshot_product The snapshot product object obtained from the kpi telemetry manager, otherwise nil.
function sdk_manager.get_snapshot_product()
    -- Check if the kpi telemetry manager on the sdk manager is NOT already loaded/valid.
    if not sdk_manager.kpi_telemetry_manager then
        -- If yes, then call into the sdk to get the kpi telemetry manager managed singleton.
        sdk_manager.kpi_telemetry_manager = sdk.get_managed_singleton(constants.type_name.kpi_telemetry_manager);
    end
    
    -- Check if the kpi telemetry manager is stil NOT valid.
    if not sdk_manager.kpi_telemetry_manager then
        -- If yes, then return nil since no snapshot product can be found.
        return nil;
    end

    -- Return the snapshot product object as a result of the get snapshot call on the kpi telemetry manager.
    return sdk_manager.kpi_telemetry_manager:call("get_Snapshot");
end

---
--- Attempt to get the unique id of the character.
---
---@return string? character_unique_id The GUID/UUID string that represents the unique id of the character.
function sdk_manager.get_character_unique_id()
    -- Check if the kpi telemetry manager on the sdk manager is NOT already loaded/valid.
    if not sdk_manager.kpi_telemetry_manager then
        -- If yes, then call into the sdk to get the kpi telemetry manager managed singleton.
        sdk_manager.kpi_telemetry_manager = sdk.get_managed_singleton(constants.type_name.kpi_telemetry_manager);
    end
    
    -- Check if the kpi telemetry manager is stil NOT valid.
    if not sdk_manager.kpi_telemetry_manager then
        -- If yes, then return nil since no character unique id can be found.
        return nil;
    end

    -- Get the snapshot save data and make sure it is valid.
    local snapshot_save_data = sdk_manager.kpi_telemetry_manager:call("get_SaveData");
    if not snapshot_save_data then
        -- If yes, then return nil since no character unique id can be found.
        return nil;
    end

    -- Return the character unique id string as a result of the get field call for the character unique id user id on the kpi telemetry manager.
    return snapshot_save_data:get_field("_CharacterUniqueId");
end

---
--- Initializes the sdk manager module.
---
function sdk_manager.init_module()
    sdk_manager.hunter_record_manager = sdk.get_managed_singleton(constants.type_name.hunter_record_manager);
    sdk_manager.player_manager = sdk.get_managed_singleton(constants.type_name.player_manager);
    sdk_manager.quest_manager = sdk.get_managed_singleton(constants.type_name.quest_manager);
    sdk_manager.kpi_telemetry_manager = sdk.get_managed_singleton(constants.type_name.kpi_telemetry_manager);
end

return sdk_manager;