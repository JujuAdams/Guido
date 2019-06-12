/// @param [labelOn]
/// @param [labelOff]
/// @param [variableName]
/// @param [elementName]

var _string_on    = ((argument_count > 0) && is_string(argument[0]))? argument[0] : "";
var _string_off   = ((argument_count > 1) && is_string(argument[1]))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _element_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;


//Get element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__guido_auto_element) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__guido_auto_element;
}

var _element_array = __guido_element_find(_element_name, false);
if (_element_array[__GUIDO_ELEMENT.NEW])
{
    if (__guido_variable_exists(_variable)) _element_array[@ __GUIDO_ELEMENT.VALUE] = __guido_variable_get(_variable);
}

var _value     = _element_array[__GUIDO_ELEMENT.VALUE];
var _old_state = _element_array[__GUIDO_ELEMENT.STATE];
var _new_state = GUIDO_STATE.NULL;


//Position element
var _element_w = 24;
var _element_h = 24;

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _element_w;
var _b = guido_y + _element_h;


//Handle cursor interaction
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

guido_x += GUIDO_ELEMENT_SEPARATION + _element_w;
__guido_line_height = max(__guido_line_height, _element_h);

var _string = _value? _string_on : _string_off;
if (_string != "") guido_text(_string);


//Update IM state
if (_new_state == GUIDO_STATE.CLICK)
{
    _value = !_value;
    _element_array[@ __GUIDO_ELEMENT.VALUE] = _value;
    __guido_variable_set(_variable, _value);
}


//Update element state
if (_element_array[__GUIDO_ELEMENT.NEW_STATE] == GUIDO_STATE.NULL) _element_array[@ __GUIDO_ELEMENT.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _element_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;