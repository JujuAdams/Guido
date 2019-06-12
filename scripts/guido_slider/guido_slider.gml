/// @param min
/// @param max
/// @param unit
/// @param length
/// @param [variableName]
/// @param [widgetName]

var _min          = argument[0];
var _max          = argument[1];
var _unit         = argument[2];
var _length       = argument[3];
var _variable     = ((argument_count > 4) && is_string(argument[4]))? argument[4] : undefined;
var _widget_name = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;


//Find widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    if (__guido_variable_exists(_variable))
    {
        _widget_array[@ __GUIDO_WIDGET.VALUE] = __guido_limit_real(__guido_variable_get(_variable), _min, _max, _unit);
    }
}

var _value     = _widget_array[__GUIDO_WIDGET.VALUE];
var _old_state = _widget_array[__GUIDO_WIDGET.STATE];
var _new_state = GUIDO_STATE.NULL;


//Position widget
var _widget_w = 24;
var _widget_h = 24;

var _min_x = guido_x;
var _max_x = guido_x + _length - _widget_w;

var _pc = clamp((_value - _min) / (_max - _min), 0, 1);
var _l = lerp(_min_x, _max_x, _pc);
var _t = guido_y;
var _r = _l + _widget_w;
var _b = _t + _widget_h;


//Handle cursor interaction
if (point_in_rectangle(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(guido_cursor_over_widget))
    {
        guido_cursor_over_widget = _widget_name;
        
        _new_state = (_old_state == GUIDO_STATE.DOWN)? GUIDO_STATE.DOWN : GUIDO_STATE.OVER;
        if (__guido_cursor_released && (_old_state == GUIDO_STATE.DOWN)) _new_state = GUIDO_STATE.CLICK;
        if (__guido_cursor_pressed  && (_old_state == GUIDO_STATE.OVER))
        {
            _widget_array[@ __GUIDO_WIDGET.CLICK_X] = __guido_cursor_x - _l;
            _widget_array[@ __GUIDO_WIDGET.CLICK_Y] = __guido_cursor_y - _t;
            _new_state = GUIDO_STATE.DOWN;
        }
    }
}

if (__guido_cursor_down && (_old_state == GUIDO_STATE.DOWN))
{
    _new_state = GUIDO_STATE.DOWN;
    
    _l = clamp(__guido_cursor_x - _widget_array[__GUIDO_WIDGET.CLICK_X], _min_x, _max_x);
    _value = lerp(_min, _max, (_l - _min_x) / (_max_x - _min_x));
    _value = __guido_limit_real(_value, _min, _max, _unit);
    _pc = clamp((_value - _min) / (_max - _min), 0, 1);
        
    _l = lerp(_min_x, _max_x, _pc);
    _r = _l + _widget_w;
}

_l = floor(_l);
_r = floor(_r);


//Draw
_max_x += _widget_w;
draw_line(_min_x, _t, _min_x, _b);
draw_line(_min_x, 0.5*(_t + _b), _max_x, 0.5*(_t + _b));
draw_line(_max_x, _t, _max_x, _b);

var _old_colour = draw_get_colour();
draw_set_colour(GUIDO_INVERSE_COLOUR);
draw_rectangle(_l, _t, _r, _b, false);
draw_set_colour(_old_colour);
draw_rectangle(_l, _t, _r, _b, true);

if (_new_state == GUIDO_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
}


//Update IM state
guido_x = _max_x + GUIDO_WIDGET_SEPARATION;
__guido_line_height = max(__guido_line_height, _widget_h);


//Update widget and group
if (_new_state == GUIDO_STATE.DOWN)
{
    _widget_array[@ __GUIDO_WIDGET.VALUE] = _value;
    __guido_variable_set(_variable, _value);
}


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Reset draw state
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;