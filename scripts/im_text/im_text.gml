/// @param string
/// @param [xScale]
/// @param [yScale]
/// @param [font]

var _string = argument[0];
var _xscale = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 1;
var _yscale = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 1;
var _font   = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : undefined;

if (_font != undefined)
{
    var _old_font = draw_get_font();
    draw_set_font(_font);
}

draw_text_transformed(__im_pos_x, __im_pos_y, _string, _xscale, _yscale, 0);

__im_pos_x += IM_ELEMENT_SEPARATION + _xscale*string_width(_string);
__im_line_height = max(__im_line_height, _yscale*string_height(_string));

if (_font != undefined) draw_set_font(_old_font);