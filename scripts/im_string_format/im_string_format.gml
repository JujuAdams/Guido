/// @param value

if ((__im_string_format_total >= 0) && (__im_string_format_dec >= 0))
{
    return string_format(argument0, __im_string_format_total, __im_string_format_dec);
}

return string(argument0);