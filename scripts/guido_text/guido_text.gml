/// @param value
/// @param [value...]

//Build a string from our arguments
var _string = "";
var _i = 0;
repeat(argument_count)
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
draw_text(guido_x, guido_y, _string);


//Update draw position
guido_spacer(GUIDO_WIDGET_SEPARATION + string_width(_string), string_height(_string));


//Return a NULL state because this element is non-interactive
return GUIDO_STATE.NULL;