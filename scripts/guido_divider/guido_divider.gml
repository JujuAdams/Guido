/// @param [width]

var _width = ((argument_count > 0) && is_real(argument[0]))? argument[0] : (guido_x - guido_xstart);

guido_newline();
draw_line(guido_xstart, guido_y + (GUIDO_LINE_MIN_HEIGHT div 2)-1, guido_xstart + _width, guido_y + (GUIDO_LINE_MIN_HEIGHT div 2)-1);
draw_line(guido_xstart, guido_y + (GUIDO_LINE_MIN_HEIGHT div 2)  , guido_xstart + _width, guido_y + (GUIDO_LINE_MIN_HEIGHT div 2)  );
guido_newline();