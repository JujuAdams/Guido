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
    _element_name = "AUTO " + string(__im_auto_element) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
if (_element_array[__IM_ELEMENT.NEW])
{
    if (__im_variable_exists(_variable)) _element_array[@ __IM_ELEMENT.VALUE] = __im_variable_get(_variable);
}

var _value     = _element_array[__IM_ELEMENT.VALUE];
var _old_state = _element_array[__IM_ELEMENT.STATE];
var _new_state = IM_STATE.NULL;


//Position element
var _element_w = 24;
var _element_h = 24;

var _min_x = im_x;
var _max_x = im_x + _length - _element_w;

var _pc = clamp((_value - _min) / (_max - _min), 0, 1);
var _l = lerp(_min_x, _max_x, _pc);
var _t = im_y;
var _r = _l + _element_w;
var _b = _t + _element_h;


//Handle cursor interaction
if (point_in_rectangle(__im_cursor_x, __im_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(im_cursor_over_element))
    {
        im_cursor_over_element = _element_name;
        
        _new_state = (_old_state == IM_STATE.DOWN)? IM_STATE.DOWN : IM_STATE.OVER;
        if (__im_cursor_released && (_old_state == IM_STATE.DOWN)) _new_state = IM_STATE.CLICK;
        if (__im_cursor_pressed  && (_old_state == IM_STATE.OVER))
        {
            _element_array[@ __IM_ELEMENT.CLICK_X] = __im_cursor_x - _l;
            _element_array[@ __IM_ELEMENT.CLICK_Y] = __im_cursor_y - _t;
            _new_state = IM_STATE.DOWN;
        }
    }
}

if (__im_cursor_down && (_old_state == IM_STATE.DOWN))
{
    _new_state = IM_STATE.DOWN;
    
    _l = clamp(__im_cursor_x - _element_array[__IM_ELEMENT.CLICK_X], _min_x, _max_x);
    _value = lerp(_min, _max, (_l - _min_x) / (_max_x - _min_x));
    _value = __im_limit_real(_value, _min, _max, _unit);
    _pc = clamp((_value - _min) / (_max - _min), 0, 1);
        
    _l = lerp(_min_x, _max_x, _pc);
    _r = _l + _element_w;
}

_l = floor(_l);
_r = floor(_r);


//Draw
_max_x += _element_w;
draw_line(_min_x, _t, _min_x, _b);
draw_line(_min_x, 0.5*(_t + _b), _max_x, 0.5*(_t + _b));
draw_line(_max_x, _t, _max_x, _b);

var _old_colour = draw_get_colour();
draw_set_colour(IM_INVERSE_COLOUR);
draw_rectangle(_l, _t, _r, _b, false);
draw_set_colour(_old_colour);
draw_rectangle(_l, _t, _r, _b, true);

if (_new_state == IM_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
}


//Update IM state
im_x = _max_x + IM_ELEMENT_SEPARATION;
__im_line_height = max(__im_line_height, _element_h);


//Update element and group
if (_new_state == IM_STATE.DOWN)
{
    _element_array[@ __IM_ELEMENT.VALUE] = _value;
    __im_variable_set(_variable, _value);
}


//Update element state
if (_element_array[__IM_ELEMENT.NEW_STATE] == IM_STATE.NULL) _element_array[@ __IM_ELEMENT.NEW_STATE] = _new_state;


//Reset draw state
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = _value;

return _new_state;