/// @param cursorX
/// @param cursorY
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param oldState
/// @param widgetName

var _cursor_x    = argument0;
var _cursor_y    = argument1;
var _l           = argument2;
var _t           = argument3;
var _r           = argument4;
var _b           = argument5;
var _old_state   = argument6;
var _widget_name = argument7;

var _new_state = GUIDO_STATE.NULL;

if (point_in_rectangle(_cursor_x, _cursor_y, _l, _t, _r, _b))
{
    if (!is_string(guido_cursor_over_widget))
    {
        guido_cursor_over_widget = _widget_name;
        
        _new_state = ((_old_state == GUIDO_STATE.PRESSED) || (_old_state == GUIDO_STATE.DOWN))? GUIDO_STATE.DOWN : GUIDO_STATE.OVER;
        if (__guido_cursor_released && (_old_state == GUIDO_STATE.DOWN)) _new_state = GUIDO_STATE.RELEASED;
        if (__guido_cursor_pressed  && (_old_state == GUIDO_STATE.OVER)) _new_state = GUIDO_STATE.PRESSED;
    }
}

return _new_state;