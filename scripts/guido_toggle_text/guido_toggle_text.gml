/// @param textOn
/// @param textOff
/// @param [variableName]
/// @param [elementName]

var _string_on    = argument[0];
var _string_off   = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2])    )? argument[2] : undefined;
var _element_name = ((argument_count > 3) && is_string(argument[3])    )? argument[3] : undefined;

if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__guido_auto_element) + ", text toggle, on=\"" + _string_on + "\", off=\"" + _string_off + "\", variable=\"" + string(_variable) + "\"";
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



var _string = _value? _string_on : _string_off;
var _element_w = string_width(_string);
var _element_h = string_height(_string);

var _l = guido_x - 2;
var _t = guido_y - 2;
var _r = guido_x + _element_w + 2;
var _b = guido_y + _element_h + 2;



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

if (_new_state == GUIDO_STATE.OVER)
{
    draw_rectangle(_l, _t, _r, _b, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
    draw_text(guido_x, guido_y, _string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(guido_x, guido_y, _string);
    draw_rectangle(_l, _t, _r, _b, true);
}

guido_x += GUIDO_ELEMENT_SEPARATION + _element_w;
__guido_line_height = max(__guido_line_height, _element_h);



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