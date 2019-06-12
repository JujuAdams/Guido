/// @param [labelOn]
/// @param [labelOff]
/// @param [variableName]
/// @param [widgetName]

var _string_on    = ((argument_count > 0) && is_string(argument[0]))? argument[0] : "";
var _string_off   = ((argument_count > 1) && is_string(argument[1]))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _widget_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;


//Get widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    if (__guido_variable_exists(_variable)) _widget_array[@ __GUIDO_WIDGET.VALUE] = __guido_variable_get(_variable);
}

var _value     = _widget_array[__GUIDO_WIDGET.VALUE];
var _old_state = _widget_array[__GUIDO_WIDGET.STATE];
var _new_state = GUIDO_STATE.NULL;


//Position widget
var _widget_w = 24;
var _widget_h = 24;

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;


//Handle cursor interaction
if (point_in_rectangle(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(guido_cursor_over_widget))
    {
        guido_cursor_over_widget = _widget_name;
        
        _new_state = (_old_state == GUIDO_STATE.DOWN)? GUIDO_STATE.DOWN : GUIDO_STATE.OVER;
        if (__guido_cursor_released && (_old_state == GUIDO_STATE.DOWN)) _new_state = GUIDO_STATE.CLICK;
        if (__guido_cursor_pressed  && (_old_state == GUIDO_STATE.OVER)) _new_state = GUIDO_STATE.DOWN;
    }
}


//Draw
draw_rectangle(_l, _t, _r, _b, true);

if (_value)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    if (_new_state == GUIDO_STATE.OVER)
    {
        var _old_colour = draw_get_colour();
        draw_set_colour(GUIDO_INVERSE_COLOUR);
        draw_rectangle(_l+3, _t+3, _r-3, _b-3, true);
        draw_set_colour(_old_colour);
    }
}
else if (_new_state == GUIDO_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, true);
}

guido_x += GUIDO_WIDGET_SEPARATION + _widget_w;
__guido_line_height = max(__guido_line_height, _widget_h);

var _string = _value? _string_on : _string_off;
if (_string != "") guido_text(_string);


//Update IM state
if (_new_state == GUIDO_STATE.CLICK)
{
    _value = !_value;
    _widget_array[@ __GUIDO_WIDGET.VALUE] = _value;
    __guido_variable_set(_variable, _value);
}


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;