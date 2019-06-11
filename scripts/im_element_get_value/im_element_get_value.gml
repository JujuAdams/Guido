/// @param elementName

var _element_name = argument0;

var _array = __im_element_find(_element_name, true);
if (!is_array(_array)) return undefined;

return _array[__IM_ELEMENT.VALUE];