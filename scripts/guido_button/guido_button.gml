/// @param string
/// @param [widgetName]

var _string       = argument[0];
var _widget_name = (argument_count > 1)? argument[1] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_button - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_sprite_w = _format_array[__GUIDO_FORMAT.SPRITE_W];
var _format_sprite_h = _format_array[__GUIDO_FORMAT.SPRITE_H];
var _format_centre_l = _format_array[__GUIDO_FORMAT.CENTRE_L];
var _format_centre_t = _format_array[__GUIDO_FORMAT.CENTRE_T];
var _format_centre_r = _format_array[__GUIDO_FORMAT.CENTRE_R];
var _format_centre_b = _format_array[__GUIDO_FORMAT.CENTRE_B];


//Get widget data
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", button, string=\"" + _string + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
var _old_state     = _widget_array[__GUIDO_WIDGET.STATE];


//Position widget
var _widget_w = _format_centre_l + _format_sprite_w - _format_centre_r + string_width(_string);
var _widget_h = _format_centre_t + _format_sprite_h - _format_centre_b + string_height(_string);

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);


//Draw
guido_draw_9slice(_format_sprite, _new_state - GUIDO_STATE.NULL,
                  _format_centre_l, _format_centre_t,
                  _format_centre_r, _format_centre_b,
                  _l, _t, _r, _b, true, c_white, 1.0);

if (_new_state == GUIDO_STATE.OVER)
{
    var _old_colour = draw_get_colour();
    draw_set_colour(__guido_negative_colour);
    draw_text(_l + _format_centre_l + 1, _t + _format_centre_t, _string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(_l + _format_centre_l + 1, _t + _format_centre_t, _string);
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