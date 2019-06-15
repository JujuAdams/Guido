/// @param lineSeparation
/// @param maxWisth
/// @param value
/// @param [value...]

var _sep = argument[0];
var _w   = argument[1];


//Build a string from our arguments
var _string = "";
var _i = 2;
repeat(argument_count - 2)
{
    if (is_real(argument[_i]))
    {
        _string += string_format_guido(argument[_i]);
    }
    else
    {
        _string += string(argument[_i]);
    }
    
    ++_i;
}


//Draw
draw_text_ext(guido_x, guido_y, _string, _sep, _w);


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + string_width_ext(_string, _sep, _w),
             string_height_ext(_string, _sep, _w));


//Return a NULL state because this element is non-interactive
return GUIDO_STATE.NULL;