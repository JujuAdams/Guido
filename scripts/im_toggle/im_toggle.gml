/// @param [labelOn]
/// @param [labelOff]
/// @param [variableName]
/// @param [elementName]

var _old_colour = draw_get_colour();
var _colour     = draw_get_colour();

var _string_on    = ((argument_count > 0) && is_string(argument[0]))? argument[0] : "";
var _string_off   = ((argument_count > 1) && is_string(argument[1]))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _element_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;

if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _value         = _element_array[__IM_ELEMENT.VALUE  ];
var _old_state     = _element_array[__IM_ELEMENT.STATE  ];
var _handled       = _element_array[__IM_ELEMENT.HANDLED];
var _new_state     = _old_state;



var _element_w = 24;
var _element_h = 24;

var _l = im_x;
var _t = im_y;
var _r = im_x + _element_w;
var _b = im_y + _element_h;



if (point_in_rectangle(__im_cursor_x, __im_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(im_cursor_over_element))
    {
        im_cursor_over_element = _element_name;
        _element_array[@ __IM_ELEMENT.OVER] = true;
        
        _new_state = (_old_state == IM_STATE.DOWN)? IM_STATE.DOWN : IM_STATE.OVER;
        if (__im_cursor_released && (_old_state == IM_STATE.DOWN)) _new_state = IM_STATE.CLICK;
        if (__im_cursor_pressed  && (_old_state == IM_STATE.OVER)) _new_state = IM_STATE.DOWN;
    }
}



draw_rectangle(_l, _t, _r, _b, true);

if (_value)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    if (_new_state == IM_STATE.OVER)
    {
        draw_set_colour(IM_INVERSE_COLOUR);
        draw_rectangle(_l+3, _t+3, _r-3, _b-3, true);
        draw_set_colour(_colour);
    }
}
else if (_new_state == IM_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, true);
}

im_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);

var _string = _value? _string_on : _string_off;
if (_string != "") im_text(_string);



if (_new_state == IM_STATE.CLICK)
{
    _value = !_value;
    _element_array[@ __IM_ELEMENT.VALUE] = _value;
    
    if (is_string(_variable))
    {
        if (string_copy(_variable, 1, 7) == "global.")
        {
            variable_global_set(string_delete(_variable, 1, 7), _value);
        }
        else
        {
            variable_instance_set(id, _variable, _value);
        }
    }
}
    
    
    
_element_array[@ __IM_ELEMENT.STATE  ] = _new_state;
_element_array[@ __IM_ELEMENT.HANDLED] = true;



draw_set_colour(_old_colour);
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = _value;

return _new_state;