/// @param x
/// @param y
/// @param mouseX
/// @param mouseY
/// @param mouseState

#macro IM_DEBUG              true
#macro IM_HEADING_FONT       fHeader
#macro IM_LINE_MIN_HEIGHT    20
#macro IM_LINE_SEPARATION     4
#macro IM_ELEMENT_SEPARATION  8

#macro IM_INVERSE_COLOUR     c_black
#macro IM_INACTIVE_COLOUR    c_gray

#region Internal definitions

#macro __IM_VERSION  "0.0.0"
#macro __IM_DATE     "2019/06/11"

enum IM_MOUSE
{
    NULL  = -2,
    OVER  = -1,
    DOWN  =  0,
    CLICK =  1
}

enum __IM_ELEMENT
{
    NAME,
    STATE,
    VALUE,
    HANDLED,
    ERRORED,
    CLICK_X,
    CLICK_Y,
    __SIZE
}

#endregion

if (!variable_instance_exists(id, "__im_mouse_down"))
{
    if (IM_DEBUG) show_debug_message("IM: Initialising for " + string(id) + " (" + object_get_name(object_index) + ")    (v" + __IM_VERSION + ", " + __IM_DATE + ")");
    __im_mouse_down = false;
    __im_element_data = [];
}

__im_prev_mouse_down = __im_mouse_down;

__im_start_pos_x = argument0;
__im_start_pos_y = argument1;
__im_mouse_x     = argument2;
__im_mouse_y     = argument3;
__im_mouse_down  = argument4;

__im_auto_element = 0;

__im_mouse_pressed  = (!__im_prev_mouse_down &&  __im_mouse_down);
__im_mouse_released = ( __im_prev_mouse_down && !__im_mouse_down);

im_mouse_over_any = false;

__im_pos_x = __im_start_pos_x;
__im_pos_y = __im_start_pos_y;
__im_line_height = 0;

var _e = 0;
repeat(array_length_1d(__im_element_data))
{
    var _array = __im_element_data[_e];
    _array[@ __IM_ELEMENT.HANDLED] = false;
    ++_e;
}