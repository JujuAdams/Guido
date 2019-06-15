/// @param min
/// @param max
/// @param unit
/// @param length
/// @param [variableName]
/// @param [widgetName]

var _min         = argument[0];
var _max         = argument[1];
var _unit        = argument[2];
var _length      = argument[3];
var _variable    = ((argument_count > 4) && is_string(argument[4]))? argument[4] : undefined;
var _widget_name = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_real_field - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_sprite_w = _format_array[__GUIDO_FORMAT.SPRITE_W];
var _format_sprite_h = _format_array[__GUIDO_FORMAT.SPRITE_H];
var _format_centre_l = _format_array[__GUIDO_FORMAT.CENTRE_L];
var _format_centre_t = _format_array[__GUIDO_FORMAT.CENTRE_T];
var _format_centre_r = _format_array[__GUIDO_FORMAT.CENTRE_R];
var _format_centre_b = _format_array[__GUIDO_FORMAT.CENTRE_B];


//Find widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", real field, variable=\"" + string(_variable) + "\"";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
if (_widget_array[__GUIDO_WIDGET.NEW])
{
    var _value = _min;
    if (__guido_variable_exists(_variable)) _value = __guido_limit_real(__guido_variable_get(_variable), _min, _max, _unit);
    
    _widget_array[@ __GUIDO_WIDGET.VALUE       ] = _value;
    _widget_array[@ __GUIDO_WIDGET.FIELD_STRING] = string_format_guido(_value);
    __guido_variable_set(_variable, _value);
}

var _value        = _widget_array[__GUIDO_WIDGET.VALUE       ];
var _old_state    = _widget_array[__GUIDO_WIDGET.STATE       ];
var _field_string = _widget_array[__GUIDO_WIDGET.FIELD_STRING];


//Position widget
var _widget_w = max(_length, _format_centre_l + (_format_sprite_w - _format_centre_r));
var _widget_h = _format_centre_t + (_format_sprite_h - _format_centre_b) + string_height(_field_string + " ");

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;
var _text_l = _l + _format_centre_l;
var _text_t = _t + _format_centre_t;


//Handle cursor interaction
var _new_state = __guido_cursor_over(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b, _old_state, _widget_name);
if (_new_state == GUIDO_STATE.RELEASED) _widget_array[@ __GUIDO_WIDGET.FIELD_POS] = 0;


//Handle keyboard input
if (__guido_focus == _widget_name)
{
    _widget_array[@ __GUIDO_WIDGET.FIELD_FOCUS] = true;
    var _field_pos = string_length(_field_string) - _widget_array[__GUIDO_WIDGET.FIELD_POS];
    
    if (keyboard_check_pressed(vk_anykey) && (ord(keyboard_lastchar) >= 32))
    {
        _field_string = string_insert(keyboard_lastchar, _field_string, _field_pos+1);
        keyboard_lastchar = "";
        _widget_array[@ __GUIDO_WIDGET.FIELD_STRING] = _field_string;
    }
    
    if (keyboard_check_pressed(vk_backspace))
    {
        _field_string = string_delete(_field_string, _field_pos, 1);
        _widget_array[@ __GUIDO_WIDGET.FIELD_STRING] = _field_string;
    }
    
    if (keyboard_check_pressed(vk_delete))
    {
        _field_string = string_delete(_field_string, _field_pos+1, 1);
        _widget_array[@ __GUIDO_WIDGET.FIELD_STRING] = _field_string;
        
        _field_pos = min(_field_pos, string_length(_field_string));
        _widget_array[@ __GUIDO_WIDGET.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_right))
    {
        _field_pos = min(_field_pos + 1, string_length(_field_string));
        _widget_array[@ __GUIDO_WIDGET.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_pressed(vk_left))
    {
        _field_pos = max(_field_pos - 1, 0);
        _widget_array[@ __GUIDO_WIDGET.FIELD_POS] = string_length(_field_string) - _field_pos;
    }
    
    if (keyboard_check_released(vk_enter)) __guido_focus = undefined;
}

if ((__guido_focus != _widget_name) && _widget_array[__GUIDO_WIDGET.FIELD_FOCUS])
{
    _widget_array[@ __GUIDO_WIDGET.FIELD_FOCUS] = false;
    _value = real(_field_string);
    _value = __guido_limit_real(_value, _min, _max, _unit);
    _field_string = string_format_guido(_value);
    __guido_variable_set(_variable, _value);
    
    _widget_array[@ __GUIDO_WIDGET.VALUE       ] = _value;
    _widget_array[@ __GUIDO_WIDGET.FIELD_STRING] = _field_string;
}


//Draw field background
var _force_over = ((_new_state == GUIDO_STATE.NULL) && (__guido_focus == _widget_name));
guido_draw_9slice(_format_sprite, (_force_over? GUIDO_STATE.RELEASED : _new_state) - GUIDO_STATE.NULL,
                  _format_centre_l, _format_centre_t,
                  _format_centre_r, _format_centre_b,
                  _l, _t, _r, _b, true, c_white, 1.0);


//Draw text and cursor
if (__guido_focus == _widget_name && (_new_state <= GUIDO_STATE.OVER))
{
    var _old_colour = draw_get_colour();
    draw_set_colour(__guido_negative_colour);
    
    var _string_part = string_copy(_field_string, 1, _field_pos);
    var _string_part_width = string_width(_string_part);
    draw_text(_text_l, _text_t, _string_part);
    if ((current_time mod 800) < 400)
    {
        draw_rectangle(_text_l + _string_part_width,
                       _text_t + 1,
                       _text_l + _string_part_width + 1,
                       _b - (_format_sprite_h - _format_centre_b),
                       false);
    }
    draw_text(_text_l + _string_part_width, _text_t, string_delete(_field_string, 1, _field_pos));
    
    draw_set_colour(_old_colour);
}
else if (_new_state == GUIDO_STATE.OVER)
{
    var _old_colour = draw_get_colour();
    draw_set_colour(__guido_negative_colour);
    draw_text(_text_l, _text_t, _field_string);
    draw_set_colour(_old_colour);
}
else
{
    draw_text(_text_l, _text_t, _field_string);
}


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + _widget_w, _widget_h);


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Reset public state
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;


//Return state
return _new_state;