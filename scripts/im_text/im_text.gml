/// @param value
/// @param [value...]

var _string = "";

var _i = 0;
repeat(argument_count)
{
    if (is_real(argument[_i]))
    {
        _string += im_string_format(argument[_i]);
    }
    else
    {
        _string += string(argument[_i]);
    }
    
    ++_i;
}

draw_text(im_x, im_y, _string);

im_x += IM_ELEMENT_SEPARATION + string_width(_string);
__im_line_height = max(__im_line_height, string_height(_string));