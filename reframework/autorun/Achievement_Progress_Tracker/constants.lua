--- Constants to be used throughout the application.
local constants <const> = {
    -- The name of the mod.
    mod_name = "Achievement Progress Tracker",

    -- The directory path for the mod.
    directory_path = "Achievement_Progress_Tracker",

    -- The default fonts directory path for REFramework
    fonts_path = "fonts",

    -- The standard options to use within a color picker without alpha.
    color_picker_options =
        1 << 1      --[[ No Alpha ]]
        | 1 << 3    --[[ No Options ]]
        | 1 << 20   --[[ Display RGB Value Fields ]]
        | 1 << 22,  --[[ Display Hex Value Field ]]

    -- The dropdown options for the size of the achievement trackers.
    size_option = {
        -- The small size option, this will NOT include the description.
        small = 1,

        -- The medium size option, this will include the description.
        medium = 2,

        -- The large size option, this will include the description.
        large = 3
    },

    -- The names for types within the game.
    type_name = {
        -- The Hunter Record Manager type name.
        hunter_record_manager = "snow.HunterRecordManager",

        -- The Player Manager type name.
        player_manager = "snow.player.PlayerManager",

        -- The Quest Manager type name.
        quest_manager = "snow.QuestManager",

        -- The Save Service type name.
        save_service = "snow.SnowSaveService"
    },

    -- The id for the achievements being tracked.
    achievement = {
        -- The id for the `Dreadnought Destroyer Plaque` achievement.
        dreadnought_destroyer_plaque = 1,

        -- The id for the `Hunter's Bronze Shield` achievement.
        hunters_bronze_shield = 2,

        -- The id for the `Hunter's Silver Shield` achievement.
        hunters_silver_shield = 3,

        -- The id for the `Hunter's Gold Shield` achievement.
        hunters_gold_shield = 4,

        -- The id for the `Anomaly Hunt Gold Trophy` achievement.
        anomaly_hunt_gold_trophy = 5,

        -- The id for the `Shining Surmounter's Shield` achievement.
        shining_surmounters_shield = 6,

        -- The id for the `Bahari's Hand-Wound Birdie` achievement.
        baharis_hand_wound_birdie = 7,

        -- The id for the `Rampage Nemesis Certificate` achievement.
        rampage_nemesis_certificate = 8
    },

    -- The sources from where the values for an achievement tracker are pulled to update their value.
    update_source = {
        -- The Hunter Record Manager update source.
        hunter_record_manager = 1,

        -- The Hunter Record Save Data update source.
        hunter_record_save_data = 2
    },

    -- The method used to acquire the update value from the update source.
    acquisition_method = {
        -- The acquisition method that retrieves a field value.
        get_field = 1,

        -- The acquisition method that retrieves the result of calling a function.
        call = 2
    },

    -- The enum that defines the quest end flow types.
    end_flow_type = sdk.enum_to_table("snow.QuestManager.EndFlow")
    --[[ For reference:
        namespace snow::QuestManager {
            enum EndFlow {
                Start = 0,
                WaitEndTimer = 1,
                InitCameraDemo = 2,
                WaitFadeCameraDemo = 3,
                LoadCameraDemo = 4,
                LoadInitCameraDemo = 5,
                LoadWaitCameraDemo = 6,
                StartCameraDemo = 7,
                CameraDemo = 8,
                Stamp = 9,
                WaitFadeOut = 10,
                InitEventCut = 11,
                WaitLoadEventCut = 12,
                WaitPlayEventCut = 13,
                WaitEndEventCut = 14,
                End = 15,
                None = 16,
            };
        }
    ]]
}

-- The language directory path that contains all of the language files.
constants.language_directory_path = constants.directory_path .. "\\languages\\";

return constants;