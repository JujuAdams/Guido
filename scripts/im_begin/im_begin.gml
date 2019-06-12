/// @param x
/// @param y
/// @param cursorX
/// @param cursorY
/// @param cursorState

//  Public variables:
//
//  im_x                   {real}    Current draw position
//  im_y                   {real}    
//  im_cursor_over_element {bool}    What element the cursor is over (<undefined> if over no element)
//  im_prev_name           {string}  Name of the last element created
//  im_prev_state          {real}    State of the last element created (see below)
//  im_prev_value          {real}    Value of the last element created
//
//  States stored in <im_prev_state> are as follows:
//  enum IM_STATE
//  {
//      NULL  = -2,   //The cursor is not over the element, not interacting with it
//      OVER  = -1,   //The cursor is over the element
//      DOWN  =  0,   //The user has clicked on the element (but the cursor is not necessarily over the element)
//      CLICK =  1    //The user has clicked and released on the element
//  }

#macro IM_DEBUG              false
#macro IM_INVERSE_COLOUR     c_black
#macro IM_LINE_MIN_HEIGHT    20
#macro IM_LINE_SEPARATION     4
#macro IM_ELEMENT_SEPARATION  8

#region Internal definitions

#macro __IM_VERSION  "0.0.0"
#macro __IM_DATE     "2019/06/11"

enum IM_STATE
{
    NULL  = -2,
    OVER  = -1,
    DOWN  =  0,
    CLICK =  1
}

enum __IM_ELEMENT
{
    NEW,
    NAME,
    STATE,
    NEW_STATE,
    VALUE,
    CLICK_X,
    CLICK_Y,
    FIELD_POS,
    FIELD_STRING,
    FIELD_FOCUS,
    __SIZE
}

enum __IM_RADIO
{
    NAME,
    COUNT,
    VALUE,
    __SIZE
}

#endregion

if (!variable_instance_exists(id, "__im_cursor_down"))
{
    if (IM_DEBUG) show_debug_message("IM: Initialising for " + string(id) + " (" + object_get_name(object_index) + ")    (v" + __IM_VERSION + ", " + __IM_DATE + ")");
    __im_cursor_down  = false;
    __im_focus        = undefined;
    __im_element_data = [];
    __im_radio_data   = [];
}

__im_prev_cursor_down = __im_cursor_down;

__im_start_pos_x = argument0;
__im_start_pos_y = argument1;
__im_cursor_x    = argument2;
__im_cursor_y    = argument3;
__im_cursor_down = argument4;

im_x = __im_start_pos_x;
im_y = __im_start_pos_y;
__im_line_height = 0;

im_cursor_over_element = undefined;
im_prev_name  = undefined;
im_prev_state = undefined;
im_prev_value = undefined;

__im_auto_element   = 0;
im_auto_radio_group = 0;

__im_string_format_total = -1;
__im_string_format_dec   = -1;

__im_cursor_pressed  = (!__im_prev_cursor_down &&  __im_cursor_down);
__im_cursor_released = ( __im_prev_cursor_down && !__im_cursor_down);



var _e = 0;
repeat(array_length_1d(__im_element_data))
{
    var _array = __im_element_data[_e];
    _array[@ __IM_ELEMENT.NEW      ] = false;
    _array[@ __IM_ELEMENT.STATE    ] = _array[__IM_ELEMENT.NEW_STATE];
    _array[@ __IM_ELEMENT.NEW_STATE] = IM_STATE.NULL;
    ++_e;
}

var _g = 0;
repeat(array_length_1d(__im_radio_data))
{
    var _group_array = __im_radio_data[_g];
    _group_array[@ __IM_RADIO.COUNT] = 0;
    ++_g;
}