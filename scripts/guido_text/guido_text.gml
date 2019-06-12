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

draw_text(guido_x, guido_y, _string);

guido_x += GUIDO_ELEMENT_SEPARATION + string_width(_string);
__guido_line_height = max(__guido_line_height, string_height(_string));