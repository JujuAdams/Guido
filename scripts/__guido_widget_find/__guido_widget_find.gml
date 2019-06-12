/// @param widgetName
/// @param noCreate

var _widget_name = argument0;
var _no_create    = argument1;

var _length = array_length_1d(__guido_widget_data);
var _e = 0;
repeat(_length)
{
    var _array = __guido_widget_data[_e];
    if (_array[__GUIDO_WIDGET.NAME] == _widget_name) break;
    ++_e;
}

if (_e >= _length)
{
    if (_no_create) return undefined;
    
    if (GUIDO_DEBUG) show_debug_message("IM: Making new widget for \"" + string(_widget_name) + "\"");
    
    var _array = array_create(__GUIDO_WIDGET.__SIZE);
    _array[@ __GUIDO_WIDGET.NEW         ] = true;
    _array[@ __GUIDO_WIDGET.NAME        ] = _widget_name;
    _array[@ __GUIDO_WIDGET.STATE       ] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_WIDGET.NEW_STATE   ] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_WIDGET.VALUE       ] = 0;
    _array[@ __GUIDO_WIDGET.COUNT       ] = 0;
    _array[@ __GUIDO_WIDGET.CLICK_X     ] = 0;
    _array[@ __GUIDO_WIDGET.CLICK_Y     ] = 0;
    _array[@ __GUIDO_WIDGET.FIELD_POS   ] = 0;
    _array[@ __GUIDO_WIDGET.FIELD_STRING] = "";
    _array[@ __GUIDO_WIDGET.FIELD_FOCUS ] = false;
    
    __guido_widget_data[_length] = _array;
}

return _array;