/// @param label
/// @param [variableName]
/// @param [widgetName]

var _string       = argument[0];
var _variable     = ((argument_count > 1) && is_string(argument[1]))? argument[1] : undefined;
var _widget_name = ((argument_count > 2) && is_string(argument[2]))? argument[2] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_radio - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_sprite_w = _format_array[__GUIDO_FORMAT.SPRITE_W];
var _format_sprite_h = _format_array[__GUIDO_FORMAT.SPRITE_H];


//Find widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    show_error("Radio buttons must be given either a variable or a widget name.\n ", false);
    guido_prev_name  = undefined;
    guido_prev_state = undefined;
    guido_prev_value = undefined;
    return GUIDO_STATE.NULL;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    if (__guido_variable_exists(_variable)) _widget_array[@ __GUIDO_WIDGET.VALUE] = __guido_variable_get(_variable);
}

var _value       = _widget_array[__GUIDO_WIDGET.VALUE];
var _old_state   = _widget_array[__GUIDO_WIDGET.STATE];
var _group_count = _widget_array[__GUIDO_WIDGET.COUNT];


//Position widget
var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _format_sprite_w;
var _b = guido_y + _format_sprite_h;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);


//Draw
draw_sprite(_format_sprite, ((_group_count == _value)? GUIDO_STATE.RELEASED : _new_state) - GUIDO_STATE.NULL, _l, _t);


//Update Guido position
guido_spacer(GUIDO_WIDGET_SEPARATION + _format_sprite_w, _format_sprite_h);


//Draw label
if (_string != "") 
{
    if (_value == _group_count)
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
    _widget_array[@ __GUIDO_WIDGET.VALUE] = _group_count;
    __guido_variable_set(_variable, _group_count);
}


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;
_widget_array[@ __GUIDO_WIDGET.COUNT]++;


//Reset draw state
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;

return _new_state;