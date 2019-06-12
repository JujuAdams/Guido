/// @param [extraYSpacing]
/// @param [xIndent]

var _spacing = ((argument_count > 0) && is_real(argument[0]))? argument[0] : 0;
var _indent  = ((argument_count > 1) && is_real(argument[1]))? argument[1] : 0;

im_x  = __im_start_pos_x + _indent;
im_y += IM_LINE_SEPARATION + _spacing + max(IM_LINE_MIN_HEIGHT, __im_line_height);

__im_line_height = 0;