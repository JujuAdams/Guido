/// @param label
/// @param [variableName]
/// @param [elementName]

var _string       = argument[0];
var _variable     = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;
var _element_name = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;


//Find element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", radio, variable=\"" + string(_variable) + "\"";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _value       = _element_array[__IM_ELEMENT.VALUE];
var _old_state   = _element_array[__IM_ELEMENT.STATE];
var _group_count = _element_array[__IM_ELEMENT.COUNT];
var _new_state   = IM_STATE.NULL;


//Position element
var _element_w = 24;
var _element_h = 24;

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
var _xc     = mean(_l, _r);
var _yc     = mean(_t, _b);
var _radius = 0.5*(_r - _l);
draw_circle(_xc, _yc, _radius, true);

if (_group_count == _value)
{
    draw_circle(_xc, _yc, _radius-2, false);
    
    if (_new_state == IM_STATE.OVER)
    {
        var _old_colour = draw_get_colour();
        draw_set_colour(IM_INVERSE_COLOUR);
        draw_circle(_xc, _yc, _radius-4, true);
        draw_set_colour(_old_colour);
    }
}
else if (_new_state == IM_STATE.OVER) 
{
    draw_circle(_xc, _yc, _radius-2, true);
}


//Update IM state
im_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);


//Draw label
if (_string != "") im_text(_string);


//Update element and group
if (_new_state == IM_STATE.CLICK)
{
    _element_array[@ __IM_ELEMENT.VALUE] = _group_count;
    __im_variable_set(_variable, _group_count);
}


//Update element state
if (_element_array[__IM_ELEMENT.NEW_STATE] == IM_STATE.NULL) _element_array[@ __IM_ELEMENT.NEW_STATE] = _new_state;
_element_array[@ __IM_ELEMENT.COUNT]++;


//Reset draw state
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = _value;

return _new_state;