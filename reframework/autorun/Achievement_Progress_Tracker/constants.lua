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
        save_service = "snow.SnowSaveService",

        -- The KPI Telemetry Manager type name.
        kpi_telemetry_manager = "snow.telemetry.KpiTelemetryManager"
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
        rampage_nemesis_certificate = 8,

        -- The id for the `Golden Spiribug Plate` achievement.
        golden_spiribug_plate = 9,

        -- The id for the `Hunting Helpers Plate` achievement.
        hunting_helpers_plate = 10,
        
        -- The id for the `Spiritwood Necklace` achievement.
        spiritwood_necklace = 11,

        -- The id for the `Frozen Lampsquid Earring` achievement.
        frozen_lampsquid_earring = 12,

        -- The id for the `Silver Cactus Ring` achievement.
        silver_cactus_ring = 13,
        
        -- The id for the `Prismatic Chalice` achievement.
        prismatic_chalice = 14,
        
        -- The id for the `Heliotrope Bracelet` achievement.
        heliotrope_bracelet = 15,
        
        -- The id for the `Copal Brooch` achievement.
        copal_brooch = 16,
        
        -- The id for the `Sea-Blue Amulet` achievement.
        sea_blue_amulet = 17,
        
        -- The id for the `Thank-mew Letter` achievement.
        thank_mew_letter = 18,
        
        -- The id for the `Well-done Grillmeister` achievement.
        well_done_grillmeister = 19
    },

    -- The sources from where the values for an achievement tracker are pulled to update their value.
    update_source = {
        -- The Hunter Record Manager update source.
        hunter_record_manager = 1,

        -- The Hunter Record Save Data update source.
        hunter_record_save_data = 2,

        -- The Snapshot Product data update source.
        snapshot_product = 3
    },

    -- The method used to acquire the update value from the update source.
    acquisition_method = {
        -- The acquisition method that retrieves a field value.
        get_field = 1,

        -- The acquisition method that retrieves the result of calling a function.
        call = 2
    },

    -- The ids for environmental creatures.
    env_creature = {
        Wirebug = "Ec008_00",
        OrangeSpiribird = "Ec009_01",
        YellowSpiribird = "Ec009_03",
        PuppetSpider = "Ec017_00",
        PrisimSpiribird = "Ec009_08",
        Blastoad = "Ec002_02",
        Antidobra = "Ec007_00",
        RedSpiritbird = "Ec009_00",
        GreenSpiritbird = "Ec009_02",
        Thunderbeetle = "Ec010_01",
        Snowbeetle = "Ec010_02",
        GoldenSpiribird = "Ec022_00",
        Trapbugs = "Ec034_00",
        Firebeetle = "Ec010_04",
        Stinkmink = "Ec014_00",
        Escuregot = "Ec015_00",
        Mudbeetle = "Ec010_00",
        Brewhare = "Ec035_00",
        Lanternbug = "Ec004_00",
        Felicicrow = "Ec033_00",
        FortuneOwl = "Ec032_00",
        GildedSpiribird = "Ec022_01",
        Poisontoad = "Ec002_03",
        Aurortle = "Ec005_00",
        Gustcrab = "Ec038_00",
        Sleeptoad = "Ec002_01",
        Wailnard = "Ec018_00",
        Paratoad = "Ec002_00",
        RubyWirebug = "Ec056_01",
        GoldWirebug = "Ec056_02",
        MarionetteSpider = "Ec057_00",
    },

    -- The collection of creature ids that are considered hunting helpers.
    hunting_helper = {},

    -- The ids for the different playable maps.
    map = {
        Default = 1,
        ShrineRuins = 2,
        SandyPlans = 3,
        FloodedForest = 4,
        FrostIslands = 5,
        LavaCaverns = 6,
        Unknown1 = 7,
        Rampage = 8,
        Unknown2 = 9,
        InfernalSprings = 10,
        Arena = 11,
        CoralPalace = 12,
        Jungle = 13,
        Citadel = 14,
        ForlornArena = 15,
        YawningAbyss = 16,
        Unknown3 = 17,
        Unknown4 = 18,
        Unknown5 = 19,
        Unknown6 = 20
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

-- Add all of the creature ids that correspond to environmental creatures that are considered hunting helpers.
-- Use the creature id as the string, value doesn't matter. 
constants.hunting_helper[constants.env_creature.PuppetSpider] = true;
constants.hunting_helper[constants.env_creature.Blastoad] = true;
constants.hunting_helper[constants.env_creature.Antidobra] = true;
constants.hunting_helper[constants.env_creature.Thunderbeetle] = true;
constants.hunting_helper[constants.env_creature.Snowbeetle] = true;
constants.hunting_helper[constants.env_creature.Trapbugs] = true;
constants.hunting_helper[constants.env_creature.Firebeetle] = true;
constants.hunting_helper[constants.env_creature.Stinkmink] = true;
constants.hunting_helper[constants.env_creature.Escuregot] = true;
constants.hunting_helper[constants.env_creature.Mudbeetle] = true;
constants.hunting_helper[constants.env_creature.Brewhare] = true;
constants.hunting_helper[constants.env_creature.Lanternbug] = true;
constants.hunting_helper[constants.env_creature.Poisontoad] = true;
constants.hunting_helper[constants.env_creature.Aurortle] = true;
constants.hunting_helper[constants.env_creature.Gustcrab] = true;
constants.hunting_helper[constants.env_creature.Sleeptoad] = true;
constants.hunting_helper[constants.env_creature.Wailnard] = true;
constants.hunting_helper[constants.env_creature.Paratoad] = true;
constants.hunting_helper[constants.env_creature.MarionetteSpider] = true;

return constants;