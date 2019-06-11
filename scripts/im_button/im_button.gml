/// @param string
/// @param [elementName]

var _string        = argument[0];
var _element_array = (argument_count > 1)? argument[1] : undefined;

if (_element_array == undefined)
{
    _element_array = "AUTO " + string(__im_auto_element) + ", button, string=\"" + _string + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_array, false);
var _old_state = _element_array[__IM_ELEMENT.STATE];
var _new_state = IM_MOUSE.NULL;

var _string_w = string_width(_string);
var _string_h = string_height(_string);

var _l = __im_pos_x - 2;
var _t = __im_pos_y - 2;
var _r = __im_pos_x + _string_w + 2;
var _b = __im_pos_y + _string_h + 2;

if (point_in_rectangle(__im_mouse_x, __im_mouse_y, _l, _t, _r, _b))
{
    if (!im_mouse_over_any)
    {
        im_mouse_over_any = true;
        
        _new_state = (_old_state == IM_MOUSE.DOWN)? IM_MOUSE.DOWN : IM_MOUSE.OVER;
        if (__im_mouse_released && (_old_state == IM_MOUSE.DOWN)) _new_state = IM_MOUSE.CLICK;
        if (__im_mouse_pressed  && (_old_state == IM_MOUSE.OVER)) _new_state = IM_MOUSE.DOWN;
    }
}

if (_new_state == IM_MOUSE.OVER)
{
    draw_rectangle(_l, _t, _r, _b, false);
    
    var _old_colour = draw_get_colour();
    draw_set_colour(make_colour_rgb(255 - colour_get_red(_old_colour), 255 - colour_get_green(_old_colour), 255 - colour_get_blue(_old_colour)));
    draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
    draw_text(__im_pos_x, __im_pos_y, _string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(__im_pos_x, __im_pos_y, _string);
    draw_rectangle(_l, _t, _r, _b, true);
}

__im_pos_x += __im_sep_x + _string_w;
__im_line_height = max(__im_line_height, _string_h);

_element_array[@ __IM_ELEMENT.STATE] = _new_state;
return _new_state;