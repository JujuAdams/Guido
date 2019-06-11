/// @param string

var _string = argument0;

if (font_exists(IM_HEADING_FONT))
{
    var _old_font = draw_get_font();
    draw_set_font(IM_HEADING_FONT);
    draw_text(__im_pos_x, __im_pos_y, _string);
    
    __im_pos_x += IM_ELEMENT_SEPARATION + string_width(_string);
    __im_line_height = max(__im_line_height, string_height(_string));
    draw_set_font(_old_font);
}
else
{
    draw_text_transformed(__im_pos_x, __im_pos_y, _string, 2, 2, 0);
    
    __im_pos_x += IM_ELEMENT_SEPARATION + 2*string_width(_string);
    __im_line_height = max(__im_line_height, 2*string_height(_string));
}