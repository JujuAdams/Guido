/// @param widgetName

var _widget_name = argument0;

var _array = __guido_widget_find(_widget_name, true);
if (!is_array(_array)) return GUIDO_STATE.NULL;

return _array[__GUIDO_WIDGET.NEW_STATE];