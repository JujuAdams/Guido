/// @param textOn
/// @param textOff
/// @param [variableName]
/// @param [widgetName]

var _string_on    = argument[0];
var _string_off   = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2])    )? argument[2] : undefined;
var _widget_name = ((argument_count > 3) && is_string(argument[3])    )? argument[3] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_toggle - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_sprite_w = _format_array[__GUIDO_FORMAT.SPRITE_W];
var _format_sprite_h = _format_array[__GUIDO_FORMAT.SPRITE_H];
var _format_centre_l = _format_array[__GUIDO_FORMAT.CENTRE_L];
var _format_centre_t = _format_array[__GUIDO_FORMAT.CENTRE_T];
var _format_centre_r = _format_array[__GUIDO_FORMAT.CENTRE_R];
var _format_centre_b = _format_array[__GUIDO_FORMAT.CENTRE_B];


//Get widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", text toggle, on=\"" + _string_on + "\", off=\"" + _string_off + "\", variable=\"" + string(_variable) + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    if (__guido_variable_exists(_variable)) _widget_array[@ __GUIDO_WIDGET.VALUE] = __guido_variable_get(_variable);
}

var _value     = _widget_array[__GUIDO_WIDGET.VALUE];
var _old_state = _widget_array[__GUIDO_WIDGET.STATE];


//Position widget
var _string = _value? _string_on : _string_off;
var _widget_w = _format_centre_l + _format_sprite_w - _format_centre_r + max(string_width( _string_on), string_width( _string_off));
var _widget_h = _format_centre_t + _format_sprite_h - _format_centre_b + max(string_height(_string_on), string_height(_string_off));

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);


//Draw
var _on = _value;
if ((_new_state == GUIDO_STATE.DOWN) || (_new_state == GUIDO_STATE.RELEASED)) _on = !_on;

guido_draw_9slice(_format_sprite, (_on? GUIDO_STATE.DOWN : GUIDO_STATE.NULL) - GUIDO_STATE.NULL,
                  _format_centre_l, _format_centre_t,
                  _format_centre_r, _format_centre_b,
                  _l, _t, _r, _b, true, c_white, 1.0);

if (_value)
{
    draw_text(_l + _format_centre_l + 1,
              _t + _format_centre_t,
              _string);
}
else
{
    var _old_colour = draw_get_colour();
    draw_set_colour(__guido_negative_colour);
    draw_text(_l + _format_centre_l + 1,
              _t + _format_centre_t,
              _string);
    draw_set_colour(_old_colour);
}


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + _widget_w, _widget_h);


//Update variable
if (_new_state == GUIDO_STATE.RELEASED)
{
    _value = !_value;
    _widget_array[@ __GUIDO_WIDGET.VALUE] = _value;
    __guido_variable_set(_variable, _value);
}


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;