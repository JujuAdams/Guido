/// @param string
/// @param [elementName]

var _old_colour = draw_get_colour();

var _string       = argument[0];
var _element_name = (argument_count > 1)? argument[1] : undefined;


//Get element data
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", button, string=\"" + _string + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _old_state     = _element_array[__IM_ELEMENT.STATE];
var _new_state     = _old_state;


//Position element
var _element_w = string_width(_string);
var _element_h = string_height(_string);

var _l = __im_pos_x;
var _t = __im_pos_y;
var _r = __im_pos_x + _element_w + 4;
var _b = __im_pos_y + _element_h + 4;


//Handle mouse interaction
if (point_in_rectangle(__im_mouse_x, __im_mouse_y, _l, _t, _r, _b))
{
    if (!im_mouse_over_any)
    {
        im_mouse_over_any = true;
        _element_array[@ __IM_ELEMENT.OVER] = true;
        
        _new_state = (_old_state == IM_STATE.DOWN)? IM_STATE.DOWN : IM_STATE.OVER;
        if (__im_mouse_released && (_old_state == IM_STATE.DOWN)) _new_state = IM_STATE.CLICK;
        if (__im_mouse_pressed  && (_old_state == IM_STATE.OVER)) _new_state = IM_STATE.DOWN;
    }
}


//Draw
if (_new_state == IM_STATE.OVER)
{
    draw_rectangle(_l, _t, _r, _b, false);
    
    draw_set_colour(IM_INVERSE_COLOUR);
    draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
    draw_text(__im_pos_x + 2, __im_pos_y + 2, _string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(__im_pos_x + 2, __im_pos_y + 2, _string);
    draw_rectangle(_l, _t, _r, _b, true);
}


//Update IM state
__im_pos_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);


//Update element
_element_array[@ __IM_ELEMENT.STATE  ] = _new_state;
_element_array[@ __IM_ELEMENT.HANDLED] = true;


//Reset draw state
draw_set_colour(_old_colour);

return _new_state;