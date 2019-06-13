/// @param x
/// @param y
/// @param cursorX
/// @param cursorY
/// @param cursorState

//  Public variables:
//
//  guido_x                   {real}    Current draw position
//  guido_y                   {real}    
//  guido_cursor_over_widget  {bool}    What widget the cursor is over (<undefined> if over no widget)
//  guido_prev_name           {string}  Name of the last widget processed
//  guido_prev_state          {real}    State of the last widget processed (see below)
//  guido_prev_value          {real}    Value of the last widget processed
//
//  States stored in <guido_prev_state> are as follows:
//  enum GUIDO_STATE
//  {
//      NULL  = -2,   //The cursor is not over the widget, not interacting with it
//      OVER  = -1,   //The cursor is over the widget
//      DOWN  =  0,   //The user has clicked on the widget (but the cursor is not necessarily over the widget)
//      CLICK =  1    //The user has clicked and released on the widget
//  }

#macro GUIDO_DEBUG              false
#macro GUIDO_INVERSE_COLOUR     c_black
#macro GUIDO_LINE_MIN_HEIGHT    20
#macro GUIDO_LINE_SEPARATION    8
#macro GUIDO_WIDGET_SEPARATION  8

#region Internal definitions

#macro __GUIDO_VERSION  "1.1.0"
#macro __GUIDO_DATE     "2019/06/13"

enum GUIDO_STATE
{
    NULL     = -3,
    OVER     = -2,
    PRESSED  = -1,
    DOWN     =  0,
    RELEASED =  1,
}

enum __GUIDO_WIDGET
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

if (!variable_instance_exists(id, "__guido_initialised"))
{
    if (GUIDO_DEBUG) show_debug_message("IM: Initialising for " + string(id) + " (" + object_get_name(object_index) + ")    (v" + __GUIDO_VERSION + ", " + __GUIDO_DATE + ")");
    
    __guido_initialised  = true;
    
    __guido_cursor_down  = false;
    __guido_focus        = undefined;
    __guido_widget_data = [];
    
    #region Formatting values
    
    __guido_format_button_sprite   = spr_guido_button;
    __guido_format_button_centre_l =  4;
    __guido_format_button_centre_t =  4;
    __guido_format_button_centre_r = 59;
    __guido_format_button_centre_b = 59;
    
    __guido_format_checkbox_sprite = spr_guido_checkbox;
    
    __guido_format_toggle_sprite   = spr_guido_toggle;
    __guido_format_toggle_centre_l =  4;
    __guido_format_toggle_centre_t =  4;
    __guido_format_toggle_centre_r = 59;
    __guido_format_toggle_centre_b = 59;
    
    __guido_format_radio_sprite = spr_guido_radio;
    
    __guido_format_tab_sprite   = spr_guido_radio;
    __guido_format_tab_centre_l =  4;
    __guido_format_tab_centre_t =  4;
    __guido_format_tab_centre_r = 59;
    __guido_format_tab_centre_b = 59;
    
    __guido_format_slider_sprite = spr_guido_slider;
    
    __guido_format_real_field_sprite   = spr_guido_field;
    __guido_format_real_field_centre_l =  4;
    __guido_format_real_field_centre_t =  4;
    __guido_format_real_field_centre_r = 59;
    __guido_format_real_field_centre_b = 59;
    
    __guido_format_string_field_sprite   = spr_guido_field;
    __guido_format_string_field_centre_l =  4;
    __guido_format_string_field_centre_t =  4;
    __guido_format_string_field_centre_r = 59;
    __guido_format_string_field_centre_b = 59;
    
    __guido_format_grid_button_centre_l =  4;
    __guido_format_grid_button_centre_t =  4;
    __guido_format_grid_button_centre_r = 59;
    __guido_format_grid_button_centre_b = 59;
    
    #endregion
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

guido_cursor_over_widget = undefined;
guido_prev_name  = undefined;
guido_prev_state = undefined;
guido_prev_value = undefined;

__guido_auto_widget = 0;

__guido_string_format_total = -1;
__guido_string_format_dec   = -1;

__guido_cursor_pressed  = (!__guido_prev_cursor_down &&  __guido_cursor_down);
__guido_cursor_released = ( __guido_prev_cursor_down && !__guido_cursor_down);



var _e = 0;
repeat(array_length_1d(__guido_widget_data))
{
    var _array = __guido_widget_data[_e];
    _array[@ __GUIDO_WIDGET.NEW      ] = false;
    _array[@ __GUIDO_WIDGET.STATE    ] = _array[__GUIDO_WIDGET.NEW_STATE];
    _array[@ __GUIDO_WIDGET.NEW_STATE] = GUIDO_STATE.NULL;
    _array[@ __GUIDO_WIDGET.COUNT    ] = 0;
    ++_e;
}