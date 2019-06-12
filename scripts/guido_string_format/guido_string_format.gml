/// @param value

if ((__guido_string_format_total >= 0) && (__guido_string_format_dec >= 0))
{
    return string_format(argument0, __guido_string_format_total, __guido_string_format_dec);
}

return string(argument0);