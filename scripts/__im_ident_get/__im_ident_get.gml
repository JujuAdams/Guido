/// @param ident

var _ident = argument0;

var _length = array_length_1d(__im_ident_data);
var _i = 0;
repeat(_length)
{
    var _array = __im_ident_data[_i];
    if (_array[__IM_IDENT_DATA.IDENT] == _ident) break;
    ++_i;
}

if (_i >= _length)
{
    if (IM_DEBUG) show_debug_message("IM: Making new ident for \"" + string(_ident) + "\"");
    
    var _array = array_create(__IM_IDENT_DATA.__SIZE);
    _array[@ __IM_IDENT_DATA.IDENT] = _ident;
    _array[@ __IM_IDENT_DATA.STATE] = -1;
    
    __im_ident_data[_length] = _array;
}

return _array;