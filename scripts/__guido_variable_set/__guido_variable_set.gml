/// @param variable
/// @param value

var _variable = argument0;
var _value    = argument1;

if (is_string(_variable))
{
    if (string_copy(_variable, 1, 7) == "global.")
    {
        variable_global_set(string_delete(_variable, 1, 7), _value);
    }
    else
    {
        var _pos = string_pos(".", _variable);
        
        if (_pos > 0)
        {
            var _object   = string_copy(_variable, 1, _pos-1);
            var _variable = string_delete(_variable, 1, _pos);
            variable_instance_set(asset_get_index(_object).id, _variable, _value);
        }
        else
        {
            variable_instance_set(id, _variable, _value);
        }
    }
}