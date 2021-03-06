/// @param width{cells}
/// @param height{cells}
/// @param cellWidth{px}
/// @param cellHeight{px}
/// @param [drawGrid]
/// @param [variableName]
/// @param [widgetName]

var _width       = argument[0];
var _height      = argument[1];
var _cell_width  = argument[2];
var _cell_height = argument[3];
var _draw_grid   = ((argument_count > 4) && (is_real(argument[4]) || is_bool(argument[4])))? argument[4] : true;
var _variable    = ((argument_count > 5) && is_string(argument[5]))? argument[5] : undefined;
var _widget_name = ((argument_count > 6) && is_string(argument[6]))? argument[6] : undefined;


//Get formatting data
var _format_array    = __guido_format[guido_grid - __guido_format_min_script];
var _format_sprite   = _format_array[__GUIDO_FORMAT.SPRITE  ];
var _format_centre_l = _format_array[__GUIDO_FORMAT.CENTRE_L];
var _format_centre_t = _format_array[__GUIDO_FORMAT.CENTRE_T];
var _format_centre_r = _format_array[__GUIDO_FORMAT.CENTRE_R];
var _format_centre_b = _format_array[__GUIDO_FORMAT.CENTRE_B];


//Get widget data
if (!is_string(_widget_name)) _widget_name = _variable;
if (_widget_name == undefined)
{
    _widget_name = "AUTO " + string(__guido_auto_widget) + ", button grid";
    ++__guido_auto_widget;
}

var _widget_array = __guido_widget_find(_widget_name, false);
var _old_state = _widget_array[__GUIDO_WIDGET.STATE];
var _new_state = GUIDO_STATE.NULL;
var _value     = [undefined, undefined];


//Position widget
var _widget_w = _width*_cell_width;
var _widget_h = _height*_cell_height;

var _l = guido_x;
var _t = guido_y;
var _r = guido_x + _widget_w;
var _b = guido_y + _widget_h;


//Handle cursor interaction
if (point_in_rectangle(__guido_cursor_x, __guido_cursor_y, _l, _t, _r, _b))
{
    if (!is_string(guido_cursor_over_widget))
    {
        guido_cursor_over_widget = _widget_name;
        
        _new_state = ((_old_state == GUIDO_STATE.PRESSED) || (_old_state == GUIDO_STATE.DOWN))? GUIDO_STATE.DOWN : GUIDO_STATE.OVER;
        if (__guido_cursor_released && (_old_state == GUIDO_STATE.DOWN)) _new_state = GUIDO_STATE.RELEASED;
        if (__guido_cursor_pressed  && (_old_state == GUIDO_STATE.OVER)) _new_state = GUIDO_STATE.PRESSED;
    }
    
    var _value = [(__guido_cursor_x - _l) div _cell_width, (__guido_cursor_y - _t) div _cell_height];
}


//Draw
if (_draw_grid)
{
    var _y = _t;
    var _j =  0;
    repeat(_height)
    {
        var _x = _l;
        var _i =  0;
        repeat(_width)
        {
            var _index = 0;
            if ((_value[0] != undefined) && (_value[1] != undefined) && (_i == _value[0]) && (_j == _value[1])) _index = _new_state - GUIDO_STATE.NULL;
            
            guido_draw_9slice(_format_sprite, _index,
                              _format_centre_l, _format_centre_t,
                              _format_centre_r, _format_centre_b,
                              _x, _y, _x + _cell_width, _y + _cell_height, true, c_white, 1.0);
            
            _x += _cell_width;
            ++_i;
        }
        
        _y += _cell_height;
        ++_j;
    }
}


//Update Guido position
guido_spacer(GUIDO_WIDGET_SEPARATION + _widget_w, _widget_h);


//Update widget state
if (_widget_array[__GUIDO_WIDGET.NEW_STATE] == GUIDO_STATE.NULL) _widget_array[@ __GUIDO_WIDGET.NEW_STATE] = _new_state;


//Pass on values to local variables
guido_prev_name  = _widget_name;
guido_prev_state = _new_state;
guido_prev_value = _value;


return _new_state;