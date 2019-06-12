/// @param string
/// @param [elementName]

var _string       = argument[0];
var _element_name = (argument_count > 1)? argument[1] : undefined;

if (_string == "")
{
    im_prev_name  = undefined;
    im_prev_state = undefined;
    im_prev_value = undefined;
    return undefined;
}


//Get element data
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", hyperlink, string=\"" + _string + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _old_state     = _element_array[__IM_ELEMENT.STATE];
var _new_state     = IM_STATE.NULL;


//Position element
var _element_w = 24;
var _element_h = 24;
if (_string != "")
{
    var _element_w = string_width(_string);
    var _element_h = string_height(_string);
}

var _l = im_x;
var _t = im_y;
var _r = im_x + _element_w;
var _b = im_y + _element_h;


//Handle cursor interaction
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


//Draw
if (_new_state == IM_STATE.OVER)
{
    draw_rectangle(_l-1, _t, _r+2, _b, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(IM_INVERSE_COLOUR);
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
im_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);


//Update element state
if (_element_array[__IM_ELEMENT.NEW_STATE] == IM_STATE.NULL) _element_array[@ __IM_ELEMENT.NEW_STATE] = _new_state;


//Pass on values to local variables
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = undefined;

return _new_state;