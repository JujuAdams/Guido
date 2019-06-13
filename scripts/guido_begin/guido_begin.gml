/// @param x
/// @param y
/// @param cursorX
/// @param cursorY
/// @param cursorState

//  Public variables:
//
//  guido_x                   {real}    Current draw position
//  guido_y                   {real}    
//  guido_xstart              {real}    Starting position
//  guido_ystart              {real}    
//  guido_line_height         {real}    Current height of this line of GUI elements
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
#macro GUIDO_LINE_MIN_HEIGHT    20
#macro GUIDO_LINE_SEPARATION    8
#macro GUIDO_WIDGET_SEPARATION  8

#region Internal definitions

#macro __GUIDO_VERSION  "2.0.0"
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

enum __GUIDO_FORMAT
{
    SPRITE,
    SPRITE_W,
    SPRITE_H,
    CENTRE_L,
    CENTRE_T,
    CENTRE_R,
    CENTRE_B,
    __SIZE
}

#endregion

//Check if we've initialised Guido for this instance
if (!variable_instance_exists(id, "__guido_initialised") || !__guido_initialised)
{
    if (GUIDO_DEBUG) show_debug_message("IM: Initialising for " + string(id) + " (" + object_get_name(object_index) + ")    (v" + __GUIDO_VERSION + ", " + __GUIDO_DATE + ")");
    
    __guido_initialised = true;
    
    __guido_cursor_down = false;
    __guido_focus       = undefined;
    __guido_widget_data = [];
    
    #region Formatting values
    
    //Scan over
    var _script_array = [guido_button, guido_hyperlink, guido_checkbox, guido_toggle, guido_radio, guido_tab, guido_slider, guido_real_field, guido_string_field, guido_grid, guido_divider];
    __guido_format_min_script = _script_array[0];
    __guido_format_max_script = _script_array[0];
    var _i = 1;
    repeat(array_length_1d(_script_array)-1)
    {
        __guido_format_min_script = min(_script_array[_i], __guido_format_min_script);
        __guido_format_max_script = max(_script_array[_i], __guido_format_max_script);
        ++_i;
    }
    __guido_format = array_create(1 + __guido_format_max_script - __guido_format_min_script);
    
    #endregion
    
    //Set default values for each widget script
    guido_set_skin(guido_button      ,   spr_guido_button  ,   4, 4,   59, 59);
    guido_set_skin(guido_checkbox    ,   spr_guido_checkbox                  ); //Not 9-sliced, doesn't use centre LTRB
    guido_set_skin(guido_toggle      ,   spr_guido_toggle  ,   4, 4,   59, 59);
    guido_set_skin(guido_radio       ,   spr_guido_radio                     ); //Not 9-sliced, doesn't use centre LTRB
    guido_set_skin(guido_tab         ,   spr_guido_tab     ,   4, 4,   59, 59);
    guido_set_skin(guido_slider      ,   spr_guido_slider                    ); //Not 9-sliced, doesn't use centre LTRB
    guido_set_skin(guido_real_field  ,   spr_guido_field   ,   4, 4,   59, 59);
    guido_set_skin(guido_string_field,   spr_guido_field   ,   4, 4,   59, 59);
    guido_set_skin(guido_grid        ,   spr_guido_grid    ,   2, 2,   61, 61);
    
    guido_set_string_format(-1, -1);
    
    if (!variable_instance_exists(id, "__guido_negative_colour"))
    {
        var _colour = draw_get_colour();
        guido_set_negative_colour(make_colour_rgb(255 - colour_get_red(_colour), 255 - colour_get_green(_colour), 255 - colour_get_blue(_colour)));
    }
}

guido_xstart     = argument0;
guido_ystart     = argument1;
__guido_cursor_x = argument2;
__guido_cursor_y = argument3;

guido_x = guido_xstart;
guido_y = guido_ystart;

//Update the cursor's state
__guido_prev_cursor_down = __guido_cursor_down;
__guido_cursor_down      = argument4;
__guido_cursor_pressed   = (!__guido_prev_cursor_down &&  __guido_cursor_down);
__guido_cursor_released  = ( __guido_prev_cursor_down && !__guido_cursor_down);

//Clear public state variables
guido_line_height        = 0;
guido_cursor_over_widget = undefined;
guido_prev_name          = undefined;
guido_prev_state         = undefined;
guido_prev_value         = undefined;

//Clear some internal variables too
__guido_auto_widget = 0;




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