/// @param string
/// @param [elementName]

var _old_colour = draw_get_colour();
var _colour     = draw_get_colour();

var _string       = argument[0];
var _element_name = (argument_count > 1)? argument[1] : undefined;

if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", button, string=\"" + _string + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _old_state = _element_array[__IM_ELEMENT.STATE  ];
var _handled   = _element_array[__IM_ELEMENT.HANDLED];

if (_handled)
{
    if (!_element_array[__IM_ELEMENT.ERRORED])
    {
        show_debug_message("IM: WARNING! Name \"" + _element_name + "\" is being used by two or more elements.");
        _element_array[@ __IM_ELEMENT.ERRORED] = true;
    }
    
    draw_set_colour(IM_INACTIVE_COLOUR);
    _colour = IM_INACTIVE_COLOUR;
}

var _new_state = IM_MOUSE.NULL;

var _element_w = string_width(_string);
var _element_h = string_height(_string);

var _l = __im_pos_x - 2;
var _t = __im_pos_y - 2;
var _r = __im_pos_x + _element_w + 2;
var _b = __im_pos_y + _element_h + 2;

if (!_handled)
{
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
}

if (_new_state == IM_MOUSE.OVER)
{
    draw_rectangle(_l, _t, _r, _b, false);
    
    draw_set_colour(IM_INVERSE_COLOUR);
    draw_rectangle(_l+1, _t+1, _r-1, _b-1, true);
    draw_text(__im_pos_x, __im_pos_y, _string);
    draw_set_colour(_colour);
}
else
{
    draw_text(__im_pos_x, __im_pos_y, _string);
    draw_rectangle(_l, _t, _r, _b, true);
}

__im_pos_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);

if (!_handled)
{
    _element_array[@ __IM_ELEMENT.STATE  ] = _new_state;
    _element_array[@ __IM_ELEMENT.HANDLED] = true;
}

draw_set_colour(_old_colour);

return _new_state;