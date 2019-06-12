/// @param widgetName

var _widget_name = argument0;

var _array = __guido_widget_find(_widget_name, true);
if (!is_array(_array)) return undefined;

return _array[__GUIDO_WIDGET.VALUE];