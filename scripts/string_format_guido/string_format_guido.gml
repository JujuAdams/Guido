/// @param value

if ((__string_format_guido_total >= 0) && (__string_format_guido_dec >= 0))
{
    return string_format(argument0, __string_format_guido_total, __string_format_guido_dec);
}

return string(argument0);