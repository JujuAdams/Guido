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
        variable_instance_set(id, _variable, _value);
    }
}