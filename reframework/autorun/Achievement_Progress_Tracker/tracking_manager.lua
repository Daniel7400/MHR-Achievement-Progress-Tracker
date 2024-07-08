-- IMPORTS
local constants = require("Achievement_Progress_Tracker.constants");
local achievementtracker = require("Achievement_Progress_Tracker.classes.achievement_tracker");
local sdk_manager = require("Achievement_Progress_Tracker.sdk_manager");
local language_manager = require("Achievement_Progress_Tracker.language_manager");
local draw_manager = require("Achievement_Progress_Tracker.draw_manager");
-- END IMPORTS

local tracking_manager = {
    -- The table of achievements being tracked by the tracking manager.
    achievements = {
        achievementtracker:new(constants.achievement.dreadnought_destroyer_plaque,
            language_manager.language.default.achievement.dreadnought_destroyer_plaque.name,
            language_manager.language.default.achievement.dreadnought_destroyer_plaque.description,
            "1d3f00d8ad0ce2e6ad17d8982b8f2bba08fbb818.jpg",
            1000, 980,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "BigEnemyHuntingCount"),
        achievementtracker:new(constants.achievement.hunters_bronze_shield,
            language_manager.language.default.achievement.hunters_bronze_shield.name,
            language_manager.language.default.achievement.hunters_bronze_shield.description,
            "51ff886f1f521f776b3133288f13aa7ceff3f6ee.jpg",
            100, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "BigEnemyHuntingCountMR"),
        achievementtracker:new(constants.achievement.hunters_silver_shield,
            language_manager.language.default.achievement.hunters_silver_shield.name,
            language_manager.language.default.achievement.hunters_silver_shield.description,
            "651ae29f3cc7b5c594ebf4d0c4a9c21ea071f1ec.jpg",
            500, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "BigEnemyHuntingCountMR"),
        achievementtracker:new(constants.achievement.hunters_gold_shield,
            language_manager.language.default.achievement.hunters_gold_shield.name,
            language_manager.language.default.achievement.hunters_gold_shield.description,
            "b32d311bcfe2e40af789c1806716b512fb1ac7f7.jpg",
            1000, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "BigEnemyHuntingCountMR"),
        achievementtracker:new(constants.achievement.anomaly_hunt_gold_trophy,
            language_manager.language.default.achievement.anomaly_hunt_gold_trophy.name,
            language_manager.language.default.achievement.anomaly_hunt_gold_trophy.description,
            "2cf0d44a81c431cff3d5e045e001d8d9a6b9d5d1.jpg",
            100, 0,
            constants.update_source.hunter_record_manager,
            constants.acquisition_method.call,
            "getMysteryEnemyHuntingNum"),
        achievementtracker:new(constants.achievement.shining_surmounters_shield,
            language_manager.language.default.achievement.shining_surmounters_shield.name,
            language_manager.language.default.achievement.shining_surmounters_shield.description,
            "12c28189df096e6d1d4a913936d77431635a0d5a.jpg",
            15, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MysteryOvercomeEnemyHuntingCount"),
        achievementtracker:new(constants.achievement.baharis_hand_wound_birdie,
            language_manager.language.default.achievement.baharis_hand_wound_birdie.name,
            language_manager.language.default.achievement.baharis_hand_wound_birdie.description,
            "26496d8203a5f58878194a9a1b8757cfad4df140.jpg",
            3000, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "UsedLaboCoinCount"),
        achievementtracker:new(constants.achievement.rampage_nemesis_certificate,
            language_manager.language.default.achievement.rampage_nemesis_certificate.name,
            language_manager.language.default.achievement.rampage_nemesis_certificate.description,
            "fc85009f4ba5ff9b9f6e81ec63f04942a2512bb7.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "QuestClearCountHyakuryu"),
    },

    -- The flag used to determine if the tracking manager initialized or not yet.
    is_initialized = false
};

---
--- Update the value of the provided `achievement_tracker` with the provided `update_source`.
---
---@param achievement_tracker achievementtracker The achievement tracker to update the value for.
---@param update_source any The source used to get the update value from.
local function update_tracker_value(achievement_tracker, update_source)
    if achievement_tracker.id == 1 then
        achievement_tracker.current = achievement_tracker.current + 1
    else
    -- Check if the acquisition method on the provided achievement tracker is get field.
    if achievement_tracker.update_params.acquisition_method == constants.acquisition_method.get_field then
        -- If yes, then set the current value on the achievement tracker as the get field result on the update source.
        achievement_tracker.current = update_source:get_field(achievement_tracker.update_params.name);
    -- Else if, check if the acquisition method on the provided achievement tracker is call.
    elseif achievement_tracker.update_params.acquisition_method == constants.acquisition_method.call then
        -- If yes, then set the current value on the achievement tracker as the call result on the update source.
        achievement_tracker.current = update_source:call(achievement_tracker.update_params.name);
    end
    end

    -- Check if the provided achievement tracker should be displayed.
    if achievement_tracker:should_display() then
        -- If yes, then call the update values function on the draw manager.
        draw_manager.update_values(achievement_tracker.name, achievement_tracker.description, true);
    end
end

---
--- Update the language values of the provided `achievement_tracker`.
---
---@param achievement_tracker achievementtracker The achievement tracker to update language values for.
local function update_tracker_language(achievement_tracker)
    -- Set the name and description of the provided achievement tracker as the values set on the current language.
    achievement_tracker.name = language_manager.language.current.achievement[achievement_tracker.key].name;
    achievement_tracker.description = language_manager.language.current.achievement[achievement_tracker.key].description;

    -- Check if the provided achievement tracker should be displayed.
    if achievement_tracker:should_display() then
        -- If yes, then call the update values function on the draw manager.
        draw_manager.update_values(achievement_tracker.name, achievement_tracker.description, false);
    end
end

---
--- Update the current values for all of the achievements being tracked through the tracking manager.
---
--- @param hunter_record_save_data any The hunter record save data to acquire update values from.
function tracking_manager.update_values(hunter_record_save_data)
    -- Call the reset values function on the draw manager.
    draw_manager.reset_values();

    -- Create a flag to track whether all tracked achievements are completed or not. Default to true.
    local all_completed = true;

    -- Iterate over each achievement tracker.
    for _, achievement_tracker in ipairs(tracking_manager.achievements) do
        -- Set the update source as nil by default.
        local update_source = nil;

        -- Check if the update source on the current achievement tracker is the hunter record manager.
        if achievement_tracker.update_params.source == constants.update_source.hunter_record_manager then
            -- If yes, then set the update source as the hunter record manager.
            update_source = sdk_manager.hunter_record_manager;
        -- Else if, check if the update source on the current achievement tracker is the hunter record save data.
        elseif achievement_tracker.update_params.source == constants.update_source.hunter_record_save_data then
            -- If yes, then set the update source as the hunter record save data.
            update_source = hunter_record_save_data;
        else
            return;
        end

        -- Call the update tracker value for the current achievement tracker and update source.
        update_tracker_value(achievement_tracker, update_source);

        -- Update the all completed flag as the and between itself and the is complete function of the current achievement tracker.
        all_completed = all_completed and achievement_tracker:is_complete();
    end

    -- Set the all completed flag on the draw manager as the local all completed flag.
    draw_manager.flags.all_completed = all_completed;
end

---
--- Update the current language for all achievement names and descriptions to match the current language.
---
function tracking_manager.update_language()
    -- Set the longest text width value on the draw manager as 0.
    draw_manager.values.longest_text_width = 0;
    
    -- Iterate over each achievement tracker.
    for _, achievement_tracker in ipairs(tracking_manager.achievements) do
        -- Call the update tracker language function for the current achievement tracker.
        update_tracker_language(achievement_tracker);
    end
end

---
--- Initializes the tracking manager module.
---
function tracking_manager.init_module()
    -- Get the hunter record save data.
    local hunter_record_save_data = sdk_manager.get_hunter_record_save_data();

    -- Call the update values function with the hunter record save data.
    tracking_manager.update_values(hunter_record_save_data);

    -- Set the is initialized flag on the tracking manager as true.
    tracking_manager.is_initialized = true;
end

return tracking_manager;