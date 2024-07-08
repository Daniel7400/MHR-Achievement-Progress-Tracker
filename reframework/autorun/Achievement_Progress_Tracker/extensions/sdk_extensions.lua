---
--- Converts the in-game enum that matches the provided `type_name` as a table. If the provided `value_as_key` flag is true the name of the
--- enum field will be the key in the table and the enum value as the table value, otherwise these are reversed.
---
---@param type_name string The type name of the enum to make as a table.
---@param value_as_key? boolean [OPTIONAL] The flag used to determine if the generated table should use the enum value as the key. Defaults to false.
---
---@return table
function sdk.enum_to_table(type_name, value_as_key)
    -- Call the find type definition from the sdk with the provided type name to get the type definition.
    local type_def = sdk.find_type_definition(type_name);
	if not type_def then
        -- Return an empty table if the type definition was not found.
		return {};
	end

    -- Check if the provided optional value as key flag is nil.
    if value_as_key == nil then
        -- If yes, then set the value as key flag as false by default.
        value_as_key = false;
    end

    -- Get the fields from the type definition.
    local fields = type_def:get_fields();

    -- Create an empty table to build the enum.
    local enum_table = {};

    -- Iterate over each ipair for the fields, discarding the index.
    for _, field in ipairs(fields) do
        -- Check if the current field is static.
        if field:is_static() then
            -- If yes, then get the name and data (use nil since it is static) of the current field.
            local name = field:get_name();
            local data = field:get_data(nil);

            -- Check if the provided value as key flag is true.
            if value_as_key then
                -- If yes, then use the field value (data) as the key in the table and set the table value as the field name.
                enum_table[data] = name;
            else
                -- Use the field name as the key in the table and set the table value as the field value (data).
                enum_table[name] = data;
            end
        end
    end

    -- Return the populated enum table.
    return enum_table;
end

---
--- Adds a hook into the method described by the provided method name on the type described by the provided type name.
--- The provided pre function will execute before the hooked method does, and the post function executes after.
---
--- @param type_name string The name of the type to check for the provided `method_name`.
--- @param method_name string The name of the method to hook into.
--- @param pre_function? function [OPTIONAL] The function to execute before the method is hooked.
--- @param post_function? function [OPTIONAL] The function to execute after the method is hooked.
function sdk.add_hook(type_name, method_name, pre_function, post_function)
    assert(pre_function or post_function, "Either the provided 'pre_function' or 'post_function' must not be nil.");

    sdk.hook(sdk.find_type_definition(type_name):get_method(method_name), pre_function, post_function);
end