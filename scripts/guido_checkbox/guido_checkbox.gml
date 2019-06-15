/// @param [labelOn]
/// @param [labelOff]
/// @param [variableName]
/// @param [widgetName]

var _string_on    = ((argument_count > 0) && is_string(argument[0]))? argument[0] : "";
var _string_off   = ((argument_count > 1) && is_string(argument[1]))? argument[1] : _string_on;
var _variable     = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;
var _widget_name = ((argument_count > 3) && is_string(argument[3]))? argument[3] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_checkbox - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_sprite_w = _format_array[__GUIDO_FORMAT.SPRITE_W];
var _format_sprite_h = _format_array[__GUIDO_FORMAT.SPRITE_H];


//Get widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", toggle, variable=\"" + string(_variable) + "\"";
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
var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _format_sprite_w;
var _b = guido_y + _format_sprite_h;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);


//Draw
draw_sprite(_format_sprite, (_value? GUIDO_STATE.RELEASED : _new_state) - GUIDO_STATE.NULL, _l, _t);


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + _format_sprite_w, _format_sprite_h);


var _string = _value? _string_on : _string_off;
if (_string != "") 
{
    if (_value)
    {
        guido_text(_string);
    }
    else
    {
        var _old_colour = draw_get_colour();
        draw_set_colour(__guido_negative_colour);
        guido_text(_string);
        draw_set_colour(_old_colour);
    }
}


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