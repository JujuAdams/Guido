/// @param variable

var _variable = argument0;

if (is_string(_variable))
{
    if (string_copy(_variable, 1, 7) == "global.")
    {
        return variable_global_exists(string_delete(_variable, 1, 7));
    }
    else
    {
        return variable_instance_exists(id, _variable);
    }
}

return undefined;