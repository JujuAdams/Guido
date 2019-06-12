/// @param value
/// @param min
/// @param max
/// @param unit

var _value = argument0;
var _min   = argument1;
var _max   = argument2;
var _unit  = argument3;

if (!is_real(_value)) return undefined;

if (is_real(_min))
{
    _value = max(_min, _value);
    if (_value <= _min) return _min;
}

if (is_real(_max))
{
    _value = min(_max, _value);
    if (_value >= _max) return _max;
}

if (is_real(_unit) && (_unit > 0.0)) _value = _unit*round(_value/_unit);

if (is_real(_min) && (_value <= _min)) return _min;
if (is_real(_max) && (_value >= _max)) return _max;

return _value;