/// @param string
/// @param [elementName]

var _string       = argument[0];
var _element_name = (argument_count > 1)? argument[1] : undefined;

if (_string == "")
{
    guido_prev_name  = undefined;
    guido_prev_state = undefined;
    guido_prev_value = undefined;
    return undefined;
}


//Get element data
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__guido_auto_element) + ", hyperlink, string=\"" + _string + "\"";
    ++__guido_auto_element;
}

var _element_array = __guido_element_find(_element_name, false);
var _old_state     = _element_array[__GUIDO_ELEMENT.STATE];
var _new_state     = GUIDO_STATE.NULL;


//Position element
var _element_w = 24;
var _element_h = 24;
if (_string != "")
{
    var _element_w = string_width(_string);
    var _element_h = string_height(_string);
}

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
if (_new_state == GUIDO_STATE.OVER)
{
    draw_rectangle(_l-1, _t, _r+2, _b, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_text(_l, _t, _string);
    draw_line_width(_l, _b, _r, _b, 2);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(_l, _t, _string);
    draw_line_width(_l, _b, _r, _b, 2);
}


//Update IM state
guido_x += GUIDO_ELEMENT_SEPARATION + _element_w;
__guido_line_height = max(__guido_line_height, _element_h);


//Update element state
if (_element_array[__GUIDO_ELEMENT.NEW_STATE] == GUIDO_STATE.NULL) _element_array[@ __GUIDO_ELEMENT.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _element_name;
guido_prev_state = _new_state;
guido_prev_value = undefined;

return _new_state;