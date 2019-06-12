/// @param [label]
/// @param [variableName]
/// @param [elementName]

var _old_colour = draw_get_colour();

var _string       = ((argument_count > 0) && is_string(argument[0]))? argument[0] : "";
var _element_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;

if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", button, label=\"" + string(_string) + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _old_state     = _element_array[__IM_ELEMENT.STATE  ];
var _handled       = _element_array[__IM_ELEMENT.HANDLED];
var _new_state     = _old_state;



var _element_w = 24;
var _element_h = 24;

var _l = __im_pos_x;
var _t = __im_pos_y;
var _r = __im_pos_x + _element_w;
var _b = __im_pos_y + _element_h;



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



draw_rectangle(_l, _t, _r, _b, true);

if (_new_state == IM_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
}

__im_pos_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);

if (_string != "") im_text(_string);
    
    
    
_element_array[@ __IM_ELEMENT.STATE  ] = _new_state;
_element_array[@ __IM_ELEMENT.HANDLED] = true;



draw_set_colour(_old_colour);

return _new_state;