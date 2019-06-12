/// @param elementName
/// @param noCreate

var _element_name = argument0;
var _no_create    = argument1;

var _length = array_length_1d(__guido_element_data);
var _e = 0;
repeat(_length)
{
    var _array = __guido_element_data[_e];
    if (_array[__GUIDO_ELEMENT.NAME] == _element_name) break;
    ++_e;
}

if (_e >= _length)
{
    if (_no_create) return undefined;
    
    if (GUIDO_DEBUG) show_debug_message("IM: Making new element for \"" + string(_element_name) + "\"");
    
    var _array = array_create(__GUIDO_ELEMENT.__SIZE);
    _array[@ __GUIDO_ELEMENT.NEW         ] = true;
    _array[@ __GUIDO_ELEMENT.NAME        ] = _element_name;
    _array[@ __GUIDO_ELEMENT.STATE       ] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_ELEMENT.NEW_STATE   ] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_ELEMENT.VALUE       ] = 0;
    _array[@ __GUIDO_ELEMENT.COUNT       ] = 0;
    _array[@ __GUIDO_ELEMENT.CLICK_X     ] = 0;
    _array[@ __GUIDO_ELEMENT.CLICK_Y     ] = 0;
    _array[@ __GUIDO_ELEMENT.FIELD_POS   ] = 0;
    _array[@ __GUIDO_ELEMENT.FIELD_STRING] = "";
    _array[@ __GUIDO_ELEMENT.FIELD_FOCUS ] = false;
    
    __guido_element_data[_length] = _array;
}

return _array;