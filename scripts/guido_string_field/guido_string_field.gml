/// @param length
/// @param [allowNewline]
/// @param [variableName]
/// @param [elementName]

var _length        = argument[0];
var _allow_newline = ((argument_count > 2) && (is_real(argument[2]) || is_bool(argument[2])))? argument[2] : false;
var _variable      = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _element_name  = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;


//Find element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__guido_auto_element) + ", string field, variable=\"" + string(_variable) + "\"";
    ++__guido_auto_element;
}

var _element_array = __guido_element_find(_element_name, false);
if (_element_array[__GUIDO_ELEMENT.NEW])
{
    var _value = "";
    if (__guido_variable_exists(_variable)) _value = guido_string_format(__guido_variable_get(_variable));
    
    _element_array[@ __GUIDO_ELEMENT.VALUE       ] = _value;
    _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _value;
    __guido_variable_set(_variable, _value);
}

var _value        = _element_array[__GUIDO_ELEMENT.VALUE       ];
var _old_state    = _element_array[__GUIDO_ELEMENT.STATE       ];
var _field_string = _element_array[__GUIDO_ELEMENT.FIELD_STRING];
var _new_state    = GUIDO_STATE.NULL;


//Position element
var _element_w = _length;
var _element_h = string_height(_field_string + " ");

var _l = guido_x;
var _t = guido_y;
var _r = _l + _element_w;
var _b = _t + _element_h;


//Handle cursor and keyboard interaction
if (point_in_rectangle(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(guido_cursor_over_element))
    {
        guido_cursor_over_element = _element_name;
        
        _new_state = (_old_state == GUIDO_STATE.DOWN)? GUIDO_STATE.DOWN : GUIDO_STATE.OVER;
        if (__guido_cursor_released && (_old_state == GUIDO_STATE.DOWN)) _new_state = GUIDO_STATE.CLICK;
        if (__guido_cursor_pressed  && (_old_state == GUIDO_STATE.OVER)) _new_state = GUIDO_STATE.DOWN;
    }
}

if (_new_state == GUIDO_STATE.CLICK)
{
    _element_array[@ __GUIDO_ELEMENT.FIELD_POS] = 0;
}

if (__guido_focus == _element_name)
{
    _element_array[@ __GUIDO_ELEMENT.FIELD_FOCUS] = true;
    var _field_pos = string_length(_field_string) - _element_array[__GUIDO_ELEMENT.FIELD_POS];
    
    if (keyboard_check_pressed(vk_anykey) && (ord(keyboard_lastchar) >= 32))
    {
        _field_string = string_insert(keyboard_lastchar, _field_string, _field_pos+1);
        keyboard_lastchar = "";
        _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _field_string;
        
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _element_array[@ __GUIDO_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_backspace))
    {
        _field_string = string_delete(_field_string, _field_pos, 1);
        _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _field_string;
    }
    
    if (keyboard_check_pressed(vk_delete))
    {
        _field_string = string_delete(_field_string, _field_pos+1, 1);
        _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _field_string;
        
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _element_array[@ __GUIDO_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_right))
    {
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _element_array[@ __GUIDO_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_left))
    {
        _field_pos = max(_field_pos - 1, 0);
        _element_array[@ __GUIDO_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_released(vk_enter))
    {
        if (keyboard_check(vk_shift))
        {
            if (_allow_newline)
            {
                _field_string += "\n";
                _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _field_string;
            }
        }
        else
        {
            __guido_focus = undefined;
        }
    }
}

if ((__guido_focus != _element_name) && _element_array[__GUIDO_ELEMENT.FIELD_FOCUS])
{
    _value = _field_string;
    _element_array[@ __GUIDO_ELEMENT.FIELD_FOCUS ] = false;
    _element_array[@ __GUIDO_ELEMENT.FIELD_STRING] = _field_string;
    __guido_variable_set(_variable, _value);
}


//Draw
draw_rectangle(_l, _t, _r, _b, true);

if (__guido_focus == _element_name)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_text(_l+2, _t, string_insert(((current_time mod 500) < 250)? "|" : " ", _field_string, _field_pos+1));
    draw_set_colour(_old_colour);
}
else if (_new_state == GUIDO_STATE.OVER)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_text(_l+2, _t, _field_string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(_l+2, _t, _field_string);
}


//Update IM state
guido_x += GUIDO_ELEMENT_SEPARATION + _element_w;
__guido_line_height = max(__guido_line_height, _element_h);


//Update element state
if (_element_array[__GUIDO_ELEMENT.NEW_STATE] == GUIDO_STATE.NULL) _element_array[@ __GUIDO_ELEMENT.NEW_STATE] = _new_state;


//Reset draw state
guido_prev_name  = _element_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;