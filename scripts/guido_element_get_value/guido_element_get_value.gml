/// @param elementName

var _element_name = argument0;

var _array = __guido_element_find(_element_name, true);
if (!is_array(_array)) return undefined;

return _array[__GUIDO_ELEMENT.VALUE];