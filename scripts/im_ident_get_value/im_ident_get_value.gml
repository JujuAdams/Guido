/// @param ident

var _ident = argument0;

var _array = __im_ident_find(_ident, true);
if (!is_array(_array)) return undefined;

return _array[__IM_IDENT_DATA.VALUE];