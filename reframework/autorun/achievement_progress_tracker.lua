log.info("[achievement_progress_tracker.lua] loaded");

--- IMPORTS
require("Achievement_Progress_Tracker.extensions.imgui_extensions");
require("Achievement_Progress_Tracker.extensions.math_extensions");
require("Achievement_Progress_Tracker.extensions.sdk_extensions");
require("Achievement_Progress_Tracker.extensions.table_extensions");
local constants = require("Achievement_Progress_Tracker.constants");
local sdk_manager = require("Achievement_Progress_Tracker.sdk_manager");
local config_manager = require("Achievement_Progress_Tracker.config_manager");
local language_manager = require("Achievement_Progress_Tracker.language_manager");
local tracking_manager = require("Achievement_Progress_Tracker.tracking_manager");
local draw_manager = require("Achievement_Progress_Tracker.draw_manager");
local ui_manager = require("Achievement_Progress_Tracker.ui_manager");
--- END IMPORTS

--- MODULE INIT
sdk_manager.init_module();
config_manager.init_module();
language_manager.init_module();
draw_manager.init_module();
ui_manager.init_module();
--- END MODULE INIT

-- Create a flag to track whether the quest end flow triggered the update values. On the end screen for some reason "updateQuestEndFlow"
-- is called repeatedly, so the flag is used to make sure it only does the update a single time.
local has_updated_via_quest_end_flow = false;

-- Add a hook on the 'saveCharaData' function to update values in the tracking manager.
sdk.add_hook(constants.type_name.save_service, "saveCharaData", nil, function(retval)
    -- Get the hunter record save data.
    local hunter_record_save_data = sdk_manager.get_hunter_record_save_data();
    
    -- Check if the hunter record save data was found.
    if hunter_record_save_data then
        -- If yes, then call the update values on the tracking manager.
        tracking_manager.update_values(hunter_record_save_data);
    end

    -- Set the has updated via quest end flow flag to false.
    has_updated_via_quest_end_flow = false;
    
    -- Return the passthrough return value.
    return retval;
end);

-- Add a hook on the 'updateQuestEndFlow' function to update values in the tracking manager only if the value
-- is 16 (None) AND it hasn't already been done (flag reset when saveCharaData is called).
sdk.add_hook(constants.type_name.quest_manager, "updateQuestEndFlow", nil, function(retval)
    -- Check if the has updated via quest end flow flag is NOT true.
    if not has_updated_via_quest_end_flow then
        -- If yes, then get the end flow status.
        local end_flow = sdk_manager.get_quest_end_flow();
        
        -- Check if the current quest end flow status is none (on the rewards screen).
        if end_flow == constants.end_flow_type.None then
            -- If yes, then get the hunter record save data.
            local hunter_record_save_data = sdk_manager.get_hunter_record_save_data();
            
            -- Check if the hunter record save data was found.
            if hunter_record_save_data then
                -- If yes, then call the update values on the tracking manager.
                tracking_manager.update_values(hunter_record_save_data);
            end
            
            -- Set the has updated via quest end flow flag as true. This is done because in that state this function
            -- is called repeatedly for some reason and there is no reason to update the data more than once.
            has_updated_via_quest_end_flow = true;
        end
    end
    
    return retval;
end);

re.on_frame(function()
    -- Check if the enabled flag on the config is NOT true (meaning the user marked it as disabled).
    if not config_manager.config.current.enabled then
        -- Return to exit early.
        return;
    end
    
    -- Call the reset function on the draw manager to reset the values for the new frame.
    draw_manager.reset();
    
    -- Call the get player function on the sdk manager to get the player object.
    if not sdk_manager.get_player() then
        -- Return to exit early if the player object was NOT found.
        return;
    end
    
    -- Check if the tracking manager is NOT intialized.
    if not tracking_manager.is_initialized then
        -- If yes, then initialize the tracking manager module.
        tracking_manager.init_module();
    end
    
    -- Set the draw flag on the draw manager as true.
    draw_manager.flags.draw = true;
end)