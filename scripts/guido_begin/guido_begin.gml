/// @param x
/// @param y
/// @param cursorX
/// @param cursorY
/// @param cursorState

//  Public variables:
//
//  guido_x                   {real}    Current draw position
//  guido_y                   {real}    
//  guido_cursor_over_element {bool}    What element the cursor is over (<undefined> if over no element)
//  guido_prev_name           {string}  Name of the last element created
//  guido_prev_state          {real}    State of the last element created (see below)
//  guido_prev_value          {real}    Value of the last element created
//
//  States stored in <guido_prev_state> are as follows:
//  enum GUIDO_STATE
//  {
//      NULL  = -2,   //The cursor is not over the element, not interacting with it
//      OVER  = -1,   //The cursor is over the element
//      DOWN  =  0,   //The user has clicked on the element (but the cursor is not necessarily over the element)
//      CLICK =  1    //The user has clicked and released on the element
//  }

#macro GUIDO_DEBUG              false
#macro GUIDO_INVERSE_COLOUR     c_black
#macro GUIDO_LINE_MIN_HEIGHT    20
#macro GUIDO_LINE_SEPARATION     4
#macro GUIDO_ELEMENT_SEPARATION  8

#region Internal definitions

#macro __GUIDO_VERSION  "1.0.0"
#macro __GUIDO_DATE     "2019/06/12"

enum GUIDO_STATE
{
    NULL  = -2,
    OVER  = -1,
    DOWN  =  0,
    CLICK =  1
}

enum __GUIDO_ELEMENT
{
    NEW,
    NAME,
    STATE,
    NEW_STATE,
    VALUE,
    COUNT,
    CLICK_X,
    CLICK_Y,
    FIELD_POS,
    FIELD_STRING,
    FIELD_FOCUS,
    __SIZE
}

#endregion

if (!variable_instance_exists(id, "__guido_cursor_down"))
{
    if (GUIDO_DEBUG) show_debug_message("IM: Initialising for " + string(id) + " (" + object_get_name(object_index) + ")    (v" + __GUIDO_VERSION + ", " + __GUIDO_DATE + ")");
    __guido_cursor_down  = false;
    __guido_focus        = undefined;
    __guido_element_data = [];
}

__guido_prev_cursor_down = __guido_cursor_down;

__guido_start_pos_x = argument0;
__guido_start_pos_y = argument1;
__guido_cursor_x    = argument2;
__guido_cursor_y    = argument3;
__guido_cursor_down = argument4;

guido_x = __guido_start_pos_x;
guido_y = __guido_start_pos_y;
__guido_line_height = 0;

guido_cursor_over_element = undefined;
guido_prev_name  = undefined;
guido_prev_state = undefined;
guido_prev_value = undefined;

__guido_auto_element = 0;

__guido_string_format_total = -1;
__guido_string_format_dec   = -1;

__guido_cursor_pressed  = (!__guido_prev_cursor_down &&  __guido_cursor_down);
__guido_cursor_released = ( __guido_prev_cursor_down && !__guido_cursor_down);



var _e = 0;
repeat(array_length_1d(__guido_element_data))
{
    var _array = __guido_element_data[_e];
    _array[@ __GUIDO_ELEMENT.NEW      ] = false;
    _array[@ __GUIDO_ELEMENT.STATE    ] = _array[__GUIDO_ELEMENT.NEW_STATE];
    _array[@ __GUIDO_ELEMENT.NEW_STATE] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_ELEMENT.COUNT    ] = 0;
    ++_e;
}