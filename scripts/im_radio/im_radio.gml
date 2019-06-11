/// @param label
/// @param [radioGroupName]
/// @param [variableName]
/// @param [elementName]

var _old_colour = draw_get_colour();
var _colour     = draw_get_colour();

var _string       = argument[0];
var _group_name   = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;
var _variable     = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _element_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;


//Find radio group data
if (_group_name == undefined)
{
    ++im_auto_radio_group;
    _group_name = "AUTO radiogroup " + string(im_auto_radio_group);
}

var _length = array_length_1d(__im_radio_data);
var _g = 0;
repeat(_length)
{
    var _group_array = __im_radio_data[_g];
    if (_group_array[__IM_ELEMENT.NAME] == _group_name) break;
    ++_g;
}

if (_g >= _length)
{
    if (IM_DEBUG) show_debug_message("IM: Making new radio group \"" + string(_group_name) + "\"");
    
    var _group_array = array_create(__IM_ELEMENT.__SIZE);
    _group_array[@ __IM_RADIO.NAME ] = _group_name;
    _group_array[@ __IM_RADIO.COUNT] = 1;
    _group_array[@ __IM_RADIO.VALUE] = 0;
    
    __im_radio_data[_length] = _group_array;
}
else
{
    _group_array[@ __IM_RADIO.COUNT]++;
}

var _group_count = _group_array[__IM_RADIO.COUNT];
var _group_value = _group_array[__IM_RADIO.VALUE];


//Find element data
if (_element_name == undefined)
{
    _element_name = "AUTO " + string(__im_auto_element) + ", radio, variable=\"" + string(_variable) + "\"";
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
    _colour = IM_INACTIVE_COLOUR;
}

var _new_state = _old_state;


//Position element
var _element_w = 24;
var _element_h = 24;

var _l = __im_pos_x;
var _t = __im_pos_y;
var _r = __im_pos_x + _element_w;
var _b = __im_pos_y + _element_h;


//Handle mouse interaction
if (!_handled)
{
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
}


//Draw
draw_rectangle(_l, _t, _r, _b, true);

if (_group_count-1 == _group_value)
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


//Update IM state
__im_pos_x += IM_ELEMENT_SEPARATION + _element_w;
__im_line_height = max(__im_line_height, _element_h);


//Draw label
if (_string != "") im_text(_string);


//Update element and group
if (!_handled)
{
    if (_new_state == IM_STATE.CLICK)
    {
        _group_array[@ __IM_RADIO.VALUE] = _group_count-1;
    
        if (is_string(_variable))
        {
            if (string_copy(_variable, 1, 7) == "global.")
            {
                variable_global_set(string_delete(_variable, 1, 7), _group_count-1);
            }
            else
            {
                variable_instance_set(id, _variable, _group_count-1);
            }
        }
    }
    
    _element_array[@ __IM_ELEMENT.STATE  ] = _new_state;
    _element_array[@ __IM_ELEMENT.HANDLED] = true;
}


//Reset draw state
draw_set_colour(_old_colour);

return _new_state;