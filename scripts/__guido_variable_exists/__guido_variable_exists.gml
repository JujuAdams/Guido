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
        var _pos = string_pos(".", _variable);
        
        if (_pos > 0)
        {
            var _object   = string_copy(_variable, 1, _pos-1);
            var _variable = string_delete(_variable, 1, _pos);
            return variable_instance_exists(asset_get_index(_object).id, _variable);
        }
        else
        {
            return variable_instance_exists(id, _variable);
        }
    }
}

return false;