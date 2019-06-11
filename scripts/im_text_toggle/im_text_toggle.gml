/// @param stringOn
/// @param stringOff
/// @param [variable{string}]
/// @param [ident{string}]

var _string_on  = argument[0];
var _string_off = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : _string_on;
var _variable   = ((argument_count > 2) && is_string(argument[2])    )? argument[2] : undefined;
var _ident      = ((argument_count > 3) && is_string(argument[3])    )? argument[3] : undefined;

if (!is_string(_ident)) _ident = _variable;
if (_ident == undefined)
{
    _ident = "AUTO " + string(__im_autoident) + ", text toggle, on=\"" + _string_on + "\", off=\"" + _string_off + "\", variable=\"" + string(_variable) + "\"";
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



var _string = _value? _string_on : _string_off;

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
return _new_state;