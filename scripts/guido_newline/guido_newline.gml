/// @param [extraYSpacing]
/// @param [xIndent]

var _spacing = ((argument_count > 0) && is_real(argument[0]))? argument[0] : 0;
var _indent  = ((argument_count > 1) && is_real(argument[1]))? argument[1] : 0;

guido_x  = __guido_start_pos_x + _indent;
guido_y += GUIDO_LINE_SEPARATION + _spacing + max(GUIDO_LINE_MIN_HEIGHT, __guido_line_height);

__guido_line_height = 0;