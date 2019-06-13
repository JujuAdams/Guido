/// @param scriptName
/// @param [argument0...]

var _script = argument[0];

var _array = array_create(argument_count);
_array[@ 0] = _script;

var _i = 1;
repeat(argument_count)
{
    _array[_i] = argument[_i];
    ++_i;
}

var _queue_array = __guido_layer_array[__guido_layer];
_queue_array[@ array_length_1d(_queue_aarray)] = _array;

return _array;