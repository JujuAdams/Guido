/// @param width{cells}
/// @param height{cells}
/// @param cellWidth{px}
/// @param cellHeight{px}
/// @param [drawGrid]
/// @param [variableName]
/// @param [elementName]

var _width        = argument[0];
var _height       = argument[1];
var _cell_width   = argument[2];
var _cell_height  = argument[3];
var _draw_grid    = ((argument_count > 4) && is_string(argument[4]))? argument[4] : true;
var _variable     = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;
var _element_name = ((argument_count > 6) && is_string(argument[6]))? argument[6] : undefined;


//Get element data
if (!is_string(_element_name)) _element_name = _variable;
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", button grid";
    ++__im_auto_element;
}

var _element_array = __im_element_find(_element_name, false);
var _old_state = _element_array[__IM_ELEMENT.STATE];
var _new_state = IM_STATE.NULL;
var _value     = [undefined, undefined];


//Position element
var _element_w = _width*_cell_width;
var _element_h = _height*_cell_height;

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
    
    var _value = [(__im_cursor_x - _l) div _cell_width, (__im_cursor_y - _t) div _cell_height];
}


//Draw
if ((_value[0] != undefined) && (_value[1] != undefined))
{
    draw_rectangle(_l + _value[0]*_cell_width, _t + _value[1]*_cell_height, _l + (_value[0]+1)*_cell_width - 1, _t + (_value[1]+1)*_cell_height - 1, false);
}

if (_draw_grid)
{
    var _x = _l;
    repeat(_width+1)
    {
        draw_line(_x, _t, _x, _b);
        _x += _cell_width;
    }
    
    var _y = _t;
    repeat(_height+1)
    {
        draw_line(_l, _y, _r, _y);
        _y += _cell_height;
    }
}


//Update IM state
im_x += IM_ELEMENT_SEPARATION + _width*_cell_width;
__im_line_height = max(__im_line_height, _height*_cell_height);


//Update element state
if (_element_array[__IM_ELEMENT.NEW_STATE] == IM_STATE.NULL) _element_array[@ __IM_ELEMENT.NEW_STATE] = _new_state;


//Pass on values to local variables
im_prev_name  = _element_name;
im_prev_state = _new_state;
im_prev_value = _value;

return _new_state;