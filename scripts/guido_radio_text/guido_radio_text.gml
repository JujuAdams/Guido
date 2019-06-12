/// @param text
/// @param [variableName]
/// @param [elementName]

var _string       = argument[0];
var _variable     = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;
var _element_name = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;


//Find element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    show_error("Radio buttons must be given either a variable or an element name.\n ", false);
    guido_prev_name  = undefined;
    guido_prev_state = undefined;
    guido_prev_value = undefined;
    return GUIDO_STATE.NULL;
}

var _element_array = __guido_element_find(_element_name, false);
if (_element_array[__GUIDO_ELEMENT.NEW])
{
    if (__guido_variable_exists(_variable)) _element_array[@ __GUIDO_ELEMENT.VALUE] = __guido_variable_get(_variable);
}

var _value       = _element_array[__GUIDO_ELEMENT.VALUE];
var _old_state   = _element_array[__GUIDO_ELEMENT.STATE];
var _group_count = _element_array[__GUIDO_ELEMENT.COUNT];
var _new_state   = GUIDO_STATE.NULL;


//Position element
var _element_w = string_width(_string);
var _element_h = string_height(_string);

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _element_w + 4;
var _b = guido_y + _element_h + 4;


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
guido_x += GUIDO_ELEMENT_SEPARATION + _element_w;
__guido_line_height = max(__guido_line_height, _element_h);


//Update element and group
if (_new_state == GUIDO_STATE.CLICK)
{
    _element_array[@ __GUIDO_ELEMENT.VALUE] = _group_count;
    __guido_variable_set(_variable, _group_count);
}


//Update element state
if (_element_array[__GUIDO_ELEMENT.NEW_STATE] == GUIDO_STATE.NULL) _element_array[@ __GUIDO_ELEMENT.NEW_STATE] = _new_state;
_element_array[@ __GUIDO_ELEMENT.COUNT]++;


//Reset draw state
guido_prev_name  = _element_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;