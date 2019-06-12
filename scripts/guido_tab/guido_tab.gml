/// @param text
/// @param [variableName]
/// @param [widgetName]

var _string       = argument[0];
var _variable     = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;
var _widget_name = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;


//Find widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    show_error("Radio buttons must be given either a variable or an widget name.\n ", false);
    guido_prev_name  = undefined;
    guido_prev_state = undefined;
    guido_prev_value = undefined;
    return GUIDO_STATE.NULL;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    if (__guido_variable_exists(_variable)) _widget_array[@ __GUIDO_WIDGET.VALUE] = __guido_variable_get(_variable);
}

var _value       = _widget_array[__GUIDO_WIDGET.VALUE];
var _old_state   = _widget_array[__GUIDO_WIDGET.STATE];
var _group_count = _widget_array[__GUIDO_WIDGET.COUNT];
var _new_state   = GUIDO_STATE.NULL;


//Position widget
var _widget_w = string_width(_string);
var _widget_h = string_height(_string);

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w + 4;
var _b = guido_y + _widget_h + 4;


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
if (_group_count == _value)
{
    draw_rectangle(_l, _t, _r, _b, false);
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, true);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
    if (_string != "") draw_text(_l + 3, _t + 3, _string);
    draw_set_colour(_old_colour);
}
else
{
    if (_new_state == GUIDO_STATE.OVER)
    {
        draw_rectangle(_l, _t, _r, _b, false);
    
        var _old_colour = draw_get_colour();
        draw_set_colour(GUIDO_INVERSE_COLOUR);
        draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
        if (_string != "") draw_text(_l + 3, _t + 3, _string);
        draw_set_colour(_old_colour);
    }
    else
    {
        if (_string != "") draw_text(_l + 3, _t + 3, _string);
        draw_rectangle(_l, _t, _r, _b, true);
    }
}


//Update IM state
guido_x += GUIDO_WIDGET_SEPARATION + _widget_w;
__guido_line_height = max(__guido_line_height, _widget_h);


//Update widget and group
if (_new_state == GUIDO_STATE.CLICK)
{
    _widget_array[@ __GUIDO_WIDGET.VALUE] = _group_count;
    __guido_variable_set(_variable, _group_count);
}


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;
_widget_array[@ __GUIDO_WIDGET.COUNT]++;


//Reset draw state
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;