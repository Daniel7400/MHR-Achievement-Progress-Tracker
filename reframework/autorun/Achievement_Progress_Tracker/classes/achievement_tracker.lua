-- IMPORTS
local constants = require("Achievement_Progress_Tracker.constants");
local config_manager = require("Achievement_Progress_Tracker.config_manager");
-- END IMPORTS

---@class (exact) achievementtracker
---@field private __index achievementtracker
---@field id number The id of the achievement to track.
---@field key number The look up key of the achievement to reference the config and language entries.
---@field name string The name of the achievement to track.
---@field description string The image of the achievement to track.
---@field image_path string The image of the achievement to track.
---@field amount number The amount to reach for the achievement to track to be considered complete.
---@field current number The current amount of progress for the achievement to track tracked. When this reaches or exceeds the amount, it will be considered complete.
---@field update_params achievementtracker.updateparams The parameters to use when updating the current value on an update request.
local achievementtracker = {};
achievementtracker.__index = achievementtracker;

---@class (exact) achievementtracker.updateparams
---@field source number The source from which the data to use when updating will come from.
---@field acquisition_method number The method to acquire the data from the source.
---@field name string The name of the field/function used to acquire the data from the source via the acquisition method.

---
--- Create a new achievement tracker.
---
---@param id number The id of the achievement to track.
---@param name string The name of the achievement to track.
---@param description string The image of the achievement to track.
---@param image_path string The image of the achievement to track.
---@param amount number The amount to reach for the achievement to track to be considered complete.
---@param current number The current amount of progress for the achievement to track tracked. When this reaches or exceeds the amount, it will be considered complete.
---@param update_params_source number The source from which the data to use when updating will come from.
---@param update_params_acquisition_method number The method to acquire the data from the source.
---@param update_params_name string The name of the field/function used to acquire the data from the source via the acquisition method.
---
---@return achievementtracker
function achievementtracker:new(id, name, description, image_path, amount, current, update_params_source, update_params_acquisition_method, update_params_name)
    -- Find the achievement key that matches the provided id.
    local achievement_key = table.find_key(constants.achievement, id);

    -- Assert the achievement key was found (not nil).
    assert(achievement_key, string.format("The provided 'id' (value = '%i'), does not correlate to any trackable achievements.", id));

    self = setmetatable({}, self);
    self.update_params = setmetatable({}, self.update_params);

    self.id = id;
    self.key = achievement_key;
    self.name = name;
    self.description = description;
    self.image_path = image_path;
    self.amount = amount;
    self.current = current;
    self.update_params.source = update_params_source;
    self.update_params.acquisition_method = update_params_acquisition_method;
    self.update_params.name = update_params_name;

    return self;
end

---
--- Determines if the achievement being tracked is considered complete or not.
---
---@return boolean
function achievementtracker:is_complete()
    return self.current >= self.amount
end

---
--- Determines if the achievement being tracked is enabled (in the config) or not.
---
---@return boolean
function achievementtracker:is_enabled()
    return config_manager.config.current.achievement_tracking[self.key];
end

---
--- Determines if the achievement being tracked should be displayed on-screen or not.
---
---@return boolean
function achievementtracker:should_display()
    return (not self:is_complete() or config_manager.config.current.display.show_completed) and self:is_enabled();
end

return achievementtracker;