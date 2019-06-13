/// @param string
/// @param [widgetName]

var _string       = argument[0];
var _widget_name = (argument_count > 1)? argument[1] : undefined;


//Get widget data
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", button, string=\"" + _string + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
var _old_state     = _widget_array[__GUIDO_WIDGET.STATE];


//Position widget
var _widget_w = __guido_format_tab_centre_l + sprite_get_width( spr_guido_toggle) - __guido_format_tab_centre_r + string_width(_string);
var _widget_h = __guido_format_tab_centre_t + sprite_get_height(spr_guido_toggle) - __guido_format_tab_centre_b + string_height(_string);

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);


//Draw
__guido_9slice(spr_guido_button, _new_state - GUIDO_STATE.NULL,
               __guido_format_button_centre_l,
               __guido_format_button_centre_t,
               __guido_format_button_centre_r,
               __guido_format_button_centre_b,
               _l, _t, _r, _b, true);

if (_new_state == GUIDO_STATE.OVER)
{
    var _old_colour = draw_get_colour();
    draw_set_colour(GUIDO_INVERSE_COLOUR);
    draw_text(_l + __guido_format_tab_centre_l + 1, _t + __guido_format_tab_centre_t, _string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(_l + __guido_format_tab_centre_l + 1, _t + __guido_format_tab_centre_t, _string);
}


//Update Guido position
guido_spacer(GUIDO_WIDGET_SEPARATION + _widget_w, _widget_h);


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = undefined;

return _new_state;