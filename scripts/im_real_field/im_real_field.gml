/// @param min
/// @param max
/// @param unit
/// @param length
/// @param [variableName]
/// @param [elementName]

var _min          = argument[0];
var _max          = argument[1];
var _unit         = argument[2];
var _length       = argument[3];
var _variable     = ((argument_count > 4) && is_string(argument[4]))? argument[4] : undefined;
var _element_name = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;


//Find element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", real field, variable=\"" + string(_variable) + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
if (_element_array[__IM_ELEMENT.NEW])
{
    var _value = _min;
    if (__im_variable_exists(_variable)) _value = __im_limit_real(__im_variable_get(_variable), _min, _max, _unit);
    
    _element_array[@ __IM_ELEMENT.VALUE       ] = _value;
    _element_array[@ __IM_ELEMENT.FIELD_STRING] = im_string_format(_value);
    __im_variable_set(_variable, _value);
}

var _value        = _element_array[__IM_ELEMENT.VALUE       ];
var _old_state    = _element_array[__IM_ELEMENT.STATE       ];
var _field_string = _element_array[__IM_ELEMENT.FIELD_STRING];
var _new_state    = IM_STATE.NULL;


//Position element
var _element_w = _length;
var _element_h = (_field_string == "")? string_height(" ") : string_height(_field_string);

var _l = im_x;
var _t = im_y;
var _r = _l + _element_w;
var _b = _t + _element_h;


//Handle cursor and keyboard interaction
if (point_in_rectangle(__im_cursor_x, __im_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(im_cursor_over_element))
    {
        im_cursor_over_element = _element_name;
        
        _new_state = (_old_state == IM_STATE.DOWN)? IM_STATE.DOWN : IM_STATE.OVER;
        if (__im_cursor_released && (_old_state == IM_STATE.DOWN)) _new_state = IM_STATE.CLICK;
        if (__im_cursor_pressed  && (_old_state == IM_STATE.OVER)) _new_state = IM_STATE.DOWN;
    }
}

if (_new_state == IM_STATE.CLICK)
{
    _element_array[@ __IM_ELEMENT.FIELD_POS] = 0;
}

if (__im_focus == _element_name)
{
    _element_array[@ __IM_ELEMENT.FIELD_FOCUS] = true;
    var _field_pos = string_length(_field_string) - _element_array[__IM_ELEMENT.FIELD_POS];
    
    if (keyboard_check_pressed(vk_anykey) && (ord(keyboard_lastchar) >= 32))
    {
        _field_string = string_insert(keyboard_lastchar, _field_string, _field_pos+1);
        keyboard_lastchar = "";
        _element_array[@ __IM_ELEMENT.FIELD_STRING] = _field_string;
    }
    
    if (keyboard_check_pressed(vk_backspace))
    {
        _field_string = string_delete(_field_string, _field_pos, 1);
        _element_array[@ __IM_ELEMENT.FIELD_STRING] = _field_string;
    }
    
    if (keyboard_check_pressed(vk_delete))
    {
        _field_string = string_delete(_field_string, _field_pos+1, 1);
        _element_array[@ __IM_ELEMENT.FIELD_STRING] = _field_string;
        
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _element_array[@ __IM_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_right))
    {
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _element_array[@ __IM_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_left))
    {
        _field_pos = max(_field_pos - 1, 0);
        _element_array[@ __IM_ELEMENT.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_released(vk_enter)) __im_focus = undefined;
}

if ((__im_focus != _element_name) && _element_array[__IM_ELEMENT.FIELD_FOCUS])
{
    _element_array[@ __IM_ELEMENT.FIELD_FOCUS] = false;
    _value = real(_field_string);
    _value = __im_limit_real(_value, _min, _max, _unit);
    _field_string = im_string_format(_value);
    __im_variable_set(_variable, _value);
    
    _element_array[@ __IM_ELEMENT.VALUE       ] = _value;
    _element_array[@ __IM_ELEMENT.FIELD_STRING] = _field_string;
}


//Draw
draw_rectangle(_l, _t, _r, _b, true);

if (__im_focus == _element_name)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(IM_INVERSE_COLOUR);
    draw_set_halign(fa_right);
    draw_text(_r-2, _t, string_insert(((current_time mod 300) < 200)? "|" : " ", _field_string, _field_pos+1));
    draw_set_halign(fa_left);
    draw_set_colour(_old_colour);
}
else if (_new_state == IM_STATE.OVER)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(IM_INVERSE_COLOUR);
    draw_set_halign(fa_right);
    draw_text(_r-2, _t, _field_string);
    draw_set_halign(fa_left);
    draw_set_colour(_old_colour);
}
else
{
    draw_set_halign(fa_right);
    draw_text(_r-2, _t, _field_string);
    draw_set_halign(fa_left);
}


//Update IM state
im_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);


//Update element state
if (_element_array[__IM_ELEMENT.NEW_STATE] == IM_STATE.NULL) _element_array[@ __IM_ELEMENT.NEW_STATE] = _new_state;


//Reset draw state
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = _value;

return _new_state;