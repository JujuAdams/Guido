/// @param value
/// @param [value...]

var _string = "";

var _i = 0;
repeat(argument_count)
{
    if (is_real(argument[_i]))
    {
        _string += guido_string_format(argument[_i]);
    }
    else
    {
        _string += string(argument[_i]);
    }
    
    ++_i;
}


//Draw
draw_text(guido_x, guido_y, _string);


//Update Guido position
guido_spacer(GUIDO_WIDGET_SEPARATION + string_width(_string), string_height(_string));