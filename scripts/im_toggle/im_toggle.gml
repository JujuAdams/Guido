/// @param [variable{string}]
/// @param [ident{string}]

var _variable = ((argument_count > 0) && is_string(argument[0]))? argument[0] : undefined;
var _ident    = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;

if (!is_string(_ident)) _ident = _variable;
if (_ident == undefined)
{
    _ident = "AUTO " + string(__im_autoident) + ", toggle, variable=\"" + string(_variable) + "\"";
    ++__im_autoident;
}

var _ident_array = __im_ident_find(_ident, false);
var _value     = _ident_array[__IM_IDENT_DATA.VALUE  ];
var _old_state = _ident_array[__IM_IDENT_DATA.STATE  ];
var _handled   = _ident_array[__IM_IDENT_DATA.HANDLED];

if (_handled && !_ident_array[__IM_IDENT_DATA.ERRORED])
{
    show_debug_message("IM: WARNING! Ident \"" + _ident + "\" is being used by two or more elements.");
    _ident_array[@ __IM_IDENT_DATA.ERRORED] = true;
}

var _new_state = IM_MOUSE.NULL;



var _string_w = 24;
var _string_h = 24;

var _l = __im_pos_x;
var _t = __im_pos_y;
var _r = __im_pos_x + _string_w;
var _b = __im_pos_y + _string_h;



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



draw_rectangle(_l, _t, _r, _b, true);

if (_value)
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
    
    if (_new_state == IM_MOUSE.OVER)
    {
        var _old_colour = draw_get_colour();
        draw_set_colour(make_colour_rgb(255 - colour_get_red(_old_colour), 255 - colour_get_green(_old_colour), 255 - colour_get_blue(_old_colour)));
        draw_rectangle(_l+3, _t+3, _r-3, _b-3, true);
        draw_set_colour(_old_colour);
    }
}
else if (_new_state == IM_MOUSE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, true);
}

__im_pos_x += __im_sep_x + _string_w;
__im_line_height = max(__im_line_height, _string_h);

if (!_handled)
{
    if (_new_state == IM_MOUSE.CLICK)
    {
        _value = !_value;
        _ident_array[@ __IM_IDENT_DATA.VALUE] = _value;
    
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
    
    _ident_array[@ __IM_IDENT_DATA.STATE  ] = _new_state;
    _ident_array[@ __IM_IDENT_DATA.HANDLED] = true;
}

return _new_state;