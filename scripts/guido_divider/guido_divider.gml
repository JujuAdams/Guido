/// @param [width]

var _width = ((argument_count > 0) && is_real(argument[0]))? argument[0] : (guido_x - __guido_start_pos_x);

guido_newline();
draw_line(__guido_start_pos_x, guido_y + GUIDO_LINE_MIN_HEIGHT-2, __guido_start_pos_x + _width, guido_y + GUIDO_LINE_MIN_HEIGHT-2);
draw_line(__guido_start_pos_x, guido_y + GUIDO_LINE_MIN_HEIGHT  , __guido_start_pos_x + _width, guido_y + GUIDO_LINE_MIN_HEIGHT  );
guido_newline();