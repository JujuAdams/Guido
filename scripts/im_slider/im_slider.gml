/// @param min
/// @param max
/// @param unit
/// @param length
/// @param [label]
/// @param [variableName]
/// @param [elementName]

var _old_colour = draw_get_colour();
var _colour     = draw_get_colour();

var _min          = argument[0];
var _max          = argument[1];
var _unit         = argument[2];
var _length       = argument[3];
var _label        = ((argument_count > 4) && is_string(argument[4]))? argument[4] : undefined;
var _variable     = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;
var _element_name = ((argument_count > 6) && is_string(argument[6]))? argument[6] : undefined;

if (!is_string(_label)) _label = _variable;
if (!is_string(_label)) _label = "";

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

if (_handled)
{
    if (!_element_array[__IM_ELEMENT.ERRORED])
    {
        show_debug_message("IM: WARNING! Name \"" + _element_name + "\" is being used by two or more elements.");
        _element_array[@ __IM_ELEMENT.ERRORED] = true;
    }
    
    draw_set_colour(IM_INACTIVE_COLOUR);
    _colour = c_gray;
}

var _new_state = IM_STATE.NULL;



var _element_w = 24;
var _element_h = 24;

var _min_x = __im_pos_x;
var _max_x = __im_pos_x + _length - _element_w;

var _pc = clamp((_value - _min) / (_max - _min), 0, 1);
var _l = lerp(_min_x, _max_x, _pc);
var _t = __im_pos_y;
var _r = _l + _element_w;
var _b = _t + _element_h;



if (!_handled)
{
    if (point_in_rectangle(__im_mouse_x, __im_mouse_y, _l, _t, _r, _b))
    {
        if (!im_mouse_over_any)
        {
            im_mouse_over_any = true;
        
            _new_state = (_old_state == IM_STATE.DOWN)? IM_STATE.DOWN : IM_STATE.OVER;
            if (__im_mouse_released && (_old_state == IM_STATE.DOWN)) _new_state = IM_STATE.CLICK;
            if (__im_mouse_pressed  && (_old_state == IM_STATE.OVER))
            {
                _element_array[@ __IM_ELEMENT.CLICK_X] = __im_mouse_x - _l;
                _element_array[@ __IM_ELEMENT.CLICK_Y] = __im_mouse_y - _t;
                _new_state = IM_STATE.DOWN;
            }
        }
    }
    
    if (__im_mouse_down && (_old_state == IM_STATE.DOWN))
    {
        _new_state = IM_STATE.DOWN;
        
        _l = clamp(__im_mouse_x - _element_array[__IM_ELEMENT.CLICK_X], _min_x, _max_x);
        _pc = clamp((_l - _min_x) / (_max_x - _min_x), 0, 1);
        
        if (_pc <= 0.0)
        {
            _value = _min;
        }
        else if (_pc >= 1.0)
        {
            _value = _max;
        }
        else
        {
            _value = lerp(_min, _max, _pc);
            if (_unit > 0) _value = _unit*round(_value / _unit);
            _value = clamp(_value, _min, _max);
        }
        
        _pc = clamp((_value - _min) / (_max - _min), 0, 1);
        _l = lerp(_min_x, _max_x, _pc);
        _r = _l + _element_w;
    }
}

_l = floor(_l);
_r = floor(_r);



_max_x += _element_w;
draw_line(_min_x, _t, _min_x, _b);
draw_line(_min_x, 0.5*(_t + _b), _max_x, 0.5*(_t + _b));
draw_line(_max_x, _t, _max_x, _b);

draw_set_colour(IM_INVERSE_COLOUR);
draw_rectangle(_l, _t, _r, _b, false);
draw_set_colour(_colour);
draw_rectangle(_l, _t, _r, _b, true);

if (_new_state == IM_STATE.OVER) 
{
    draw_rectangle(_l+2, _t+2, _r-2, _b-2, false);
}

__im_pos_x = _max_x + IM_ELEMENT_SEPARATION;
__im_line_height = max(__im_line_height, _element_h);

if ((__im_string_format_total >= 0) && (__im_string_format_dec >= 0))
{
    var _string_value = string_format(_value, __im_string_format_total, __im_string_format_dec);
}
else
{
    var _string_value = string(_value);
}

im_text((_label != "")? (_label + ": " + _string_value) : _string_value);


if (!_handled)
{
    if (_new_state == IM_STATE.DOWN)
    {
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
}

draw_set_colour(_old_colour);

return _new_state;