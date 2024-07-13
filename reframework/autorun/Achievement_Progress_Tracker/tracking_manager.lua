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
            1000, 0,
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

        achievementtracker:new(constants.achievement.golden_spiribug_plate,
            language_manager.language.default.achievement.golden_spiribug_plate.name,
            language_manager.language.default.achievement.golden_spiribug_plate.description,
            "4438c45e33a48888161f76d3b3615fd85f377f12.jpg",
            1000, 0,
            constants.update_source.snapshot_product,
            constants.acquisition_method.get_field,
            "creature_count",
            ---@param creature_count userdata
            ---@return number
            function(creature_count)
                -- Check if the provided creature count is NOT valid.
                if not creature_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Convert the provided creature count userdata into an arary and get the elements.
                local creature_count_array = creature_count:call("ToArray");
                local creature_count_elements = creature_count_array:get_elements();

                -- Create the return value, defaulting to 0.
                local sum = 0;

                -- Iterate over each creature count element.
                for _, value in ipairs(creature_count_elements) do
                    -- Get the creature id of the current creature count element.
                    local creature_id = value:get_field("creature_id");

                    -- Check if the creature id is either the Golden Spiribird OR the Gilded Spiribird.
                    if creature_id == constants.env_creature.GoldenSpiribird or creature_id == constants.env_creature.GildedSpiribird then
                        -- If yes, then increase the sum by the got amount of the current creature count element.
                        sum = sum + value:get_field("got_count");
                    end
                end

                -- Return the sum.
                return sum;
            end),

        achievementtracker:new(constants.achievement.hunting_helpers_plate,
            language_manager.language.default.achievement.hunting_helpers_plate.name,
            language_manager.language.default.achievement.hunting_helpers_plate.description,
            "74e6123073af676f4eb33a3e44c268ce65dcd1bd.jpg",
            500, 0,
            constants.update_source.snapshot_product,
            constants.acquisition_method.get_field,
            "creature_count",
            ---@param creature_count userdata
            ---@return number
            function(creature_count)
                -- Check if the provided creature count is NOT valid.
                if not creature_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Convert the provided creature count userdata into an arary and get the elements.
                local creature_count_array = creature_count:call("ToArray");
                local creature_count_elements = creature_count_array:get_elements();

                -- Create the return value, defaulting to 0.
                local sum = 0;

                -- Iterate over each creature count element.
                for _, value in ipairs(creature_count_elements) do
                    -- Get the creature id of the current creature count element.
                    local creature_id = value:get_field("creature_id");

                    -- Check if the current creature id exists in the hunting helper table (meaning this creature is a hunting helper).
                    if constants.hunting_helper[creature_id] then
                        -- If yes, then increase the sum by the got amount of the current creature count element.
                        sum = sum + value:get_field("got_count");
                    end
                end

                -- Return the sum.
                return sum;
            end),

        achievementtracker:new(constants.achievement.spiritwood_necklace,
            language_manager.language.default.achievement.spiritwood_necklace.name,
            language_manager.language.default.achievement.spiritwood_necklace.description,
            "2c7283692778bee7a248c281a9dc164a4a9fb574.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Shrine Ruins (minus one because it is 0 indexed).
                return map_clear_count[constants.map.ShrineRuins - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.frozen_lampsquid_earring,
            language_manager.language.default.achievement.frozen_lampsquid_earring.name,
            language_manager.language.default.achievement.frozen_lampsquid_earring.description,
            "55804b31f23ba50b6628f5275a282f0beefefd84.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Frost Islands (minus one because it is 0 indexed).
                return map_clear_count[constants.map.FrostIslands - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.silver_cactus_ring,
            language_manager.language.default.achievement.silver_cactus_ring.name,
            language_manager.language.default.achievement.silver_cactus_ring.description,
            "33737246fe5a2f3053d3c54b0e721c056ab4f73f.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Sandy Plains (minus one because it is 0 indexed).
                return map_clear_count[constants.map.SandyPlans - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.prismatic_chalice,
            language_manager.language.default.achievement.prismatic_chalice.name,
            language_manager.language.default.achievement.prismatic_chalice.description,
            "4293cb2344e8ccc6bef4857b4770e8507699f106.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Flooded Forest (minus one because it is 0 indexed).
                return map_clear_count[constants.map.FloodedForest - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.heliotrope_bracelet,
            language_manager.language.default.achievement.heliotrope_bracelet.name,
            language_manager.language.default.achievement.heliotrope_bracelet.description,
            "e01d0712b7edc6e403259826e5840740073980c4.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Lava Caverns (minus one because it is 0 indexed).
                return map_clear_count[constants.map.LavaCaverns - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.copal_brooch,
            language_manager.language.default.achievement.copal_brooch.name,
            language_manager.language.default.achievement.copal_brooch.description,
            "83f9fa26abadafe3a12d24c9992f66b26b13a960.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Citadel (minus one because it is 0 indexed).
                return map_clear_count[constants.map.Citadel - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.sea_blue_amulet,
            language_manager.language.default.achievement.sea_blue_amulet.name,
            language_manager.language.default.achievement.sea_blue_amulet.description,
            "6eb187d16158dbee1c7df6b63a54333c949d7d13.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "MapClearCount",
            ---@param map_clear_count userdata
            ---@return number
            function(map_clear_count)
                -- Check if the provided map clear count is NOT valid.
                if not map_clear_count then
                    -- Return 0 by default.
                    return 0;
                end

                -- Return the map clear count for the Jungle (minus one because it is 0 indexed).
                return map_clear_count[constants.map.Jungle - 1]:get_field("mValue");
            end),

        achievementtracker:new(constants.achievement.thank_mew_letter,
            language_manager.language.default.achievement.thank_mew_letter.name,
            language_manager.language.default.achievement.thank_mew_letter.description,
            "310edaaf8de012593573d03f5d1c4e682b6cdfb6.jpg",
            50, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "OtomoHireCount"),

        achievementtracker:new(constants.achievement.well_done_grillmeister,
            language_manager.language.default.achievement.well_done_grillmeister.name,
            language_manager.language.default.achievement.well_done_grillmeister.description,
            "fade54d9440434f91b94466975184973fea475b7.jpg",
            30, 0,
            constants.update_source.hunter_record_save_data,
            constants.acquisition_method.get_field,
            "GrilMeatCount"),
    },

    -- The flag used to determine if the tracking manager initialized or not yet.
    is_initialized = false
};

---
--- Update the value of the provided `achievement_tracker` with the provided `update_source`.
---
---@param achievement_tracker achievementtracker The achievement tracker to update the value for.
---@param update_source userdata The source used to get the update value from.
local function update_tracker_value(achievement_tracker, update_source)
    -- Create a variable to store the acquired value. Default to 0.
    local acquired_value = 0;

     -- Check if the acquisition method on the provided achievement tracker is get field.
    if achievement_tracker.update_params.acquisition_method == constants.acquisition_method.get_field then
        -- If yes, then set the acquired value with the result of calling get field on the provided update source.
        acquired_value = update_source:get_field(achievement_tracker.update_params.name);

    -- Else if, check if the acquisition method on the provided achievement tracker is call.
    elseif achievement_tracker.update_params.acquisition_method == constants.acquisition_method.call then
        -- If yes, then set the acquired value with the result of calling call on the provided update source.
        acquired_value = update_source:call(achievement_tracker.update_params.name);
    end

    -- If yes, check if the additional processing function on the provided achievement tracker is nil.
    if achievement_tracker.update_params.additional_processing == nil then
        -- If yes, then set the current value on the provided achievement tracker as previously acquired value.
        achievement_tracker.current = acquired_value;
    else
        -- Set the current value on the provided achievementtracker as the result of the additional processing function after
        -- passing in the previously acquired value.
        achievement_tracker.current = achievement_tracker.update_params.additional_processing(acquired_value);
    end

    -- Check if the provided achievement tracker should be displayed.
    if achievement_tracker:should_display() then
        -- If yes, then call the update values function on the draw manager.
        draw_manager.update_values(achievement_tracker.name, achievement_tracker.description);
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
        draw_manager.update_values(achievement_tracker.name, achievement_tracker.description);
    end
end

---
--- Update the current values for all of the achievements being tracked through the tracking manager.
---
---@param hunter_record_save_data userdata The hunter record save data to acquire update values from.
---@param snapshot_product userdata The KPI telemetry snapshot product data to acquire update values from.
function tracking_manager.update_values(hunter_record_save_data, snapshot_product)
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
        -- Else if, check if the update source on the current achievement tracker is the snapshot product.
        elseif achievement_tracker.update_params.source == constants.update_source.snapshot_product then
            -- If yes, then set the update source as the provided snapshot product.
            update_source = snapshot_product;
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
--- Update the current language for all achievement names and descriptions to match the current language. Also used to
--- get the new potential longest text width with a size change.
---
function tracking_manager.update_language()
    -- Call the reset values function on the draw manager.
    draw_manager.reset_values();
    
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

    -- Get the KPI telemetry snapshot product data.
    local snapshot_product = sdk_manager.get_snapshot_product();

    -- Check if the hunter record save data and snapshot product were found.
    if hunter_record_save_data and snapshot_product then
        -- If yes, then call the update values on the tracking manager.
        tracking_manager.update_values(hunter_record_save_data, snapshot_product);
    else
        return;
    end
    
    -- Set the is initialized flag on the tracking manager as true.
    tracking_manager.is_initialized = true;
end

return tracking_manager;