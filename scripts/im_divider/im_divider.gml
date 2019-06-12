/// @param [width]

var _width = ((argument_count > 0) && is_real(argument[0]))? argument[0] : (im_x - __im_start_pos_x);

im_newline();
draw_line(__im_start_pos_x, im_y + IM_LINE_MIN_HEIGHT-2, __im_start_pos_x + _width, im_y + IM_LINE_MIN_HEIGHT-2);
draw_line(__im_start_pos_x, im_y + IM_LINE_MIN_HEIGHT  , __im_start_pos_x + _width, im_y + IM_LINE_MIN_HEIGHT  );
im_newline();