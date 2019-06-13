/// @param sprite
/// @param index
/// @param spriteCentreL
/// @param spriteCentreT
/// @param spriteCentreR
/// @param spriteCentreB
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param stretch{bool}

var _sprite   = argument0;
var _index    = argument1;
var _centre_l = argument2;
var _centre_t = argument3;
var _centre_r = argument4;
var _centre_b = argument5;
var _in_x1    = argument6;
var _in_y1    = argument7;
var _in_x2    = argument8;
var _in_y2    = argument9;
var _stretch  = argument10;

var _colour = c_white;
var _alpha  = 1.0;

var _sprite_w = sprite_get_width( _sprite);
var _sprite_h = sprite_get_height(_sprite);

var _centre_w = 1 + _centre_r - _centre_l;
var _centre_h = 1 + _centre_b - _centre_t;

var _in_w = 1 + _in_x2 - _in_x1;
var _in_h = 1 + _in_y2 - _in_y1;

var _border_l = _centre_l;
var _border_t = _centre_t;
var _border_r = _sprite_w - _centre_r - 1;
var _border_b = _sprite_h - _centre_b - 1;

var _in_centre_w = _in_w - (_border_l + _border_r);
var _in_centre_h = _in_h - (_border_t + _border_b);
var _xscale      = _in_centre_w / _centre_w;
var _yscale      = _in_centre_h / _centre_h;

if (!_stretch)
{
    var _xscale = ceil(_xscale);
    var _yscale = ceil(_yscale);
    
    _in_centre_w = _xscale*_centre_w;
    _in_centre_h = _yscale*_centre_h;
    
    _in_w = _in_centre_w + (_border_l+1 + _border_r+1);
    _in_h = _in_centre_h + (_border_t+1 + _border_b+1);
}

var _sprite_slice_l1 = _centre_l;
var _sprite_slice_l2 = _centre_l + _centre_w;
var _sprite_slice_t1 = _centre_t;
var _sprite_slice_t2 = _centre_t + _centre_h;

var _slice_x0 = _in_x1;
var _slice_x1 = _slice_x0 + _border_l;
var _slice_x2 = _slice_x1 + _in_centre_w;

var _slice_y0 = _in_y1;
var _slice_y1 = _slice_y0 + _border_t;
var _slice_y2 = _slice_y1 + _in_centre_h;

if (_stretch)
{
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1, _sprite_slice_t1, _centre_w, _centre_h,  _slice_x1, _slice_y1,   _xscale, _yscale,   _colour, _alpha); //Centre
    
    draw_sprite_part_ext(_sprite, _index,                  0, _sprite_slice_t1, _border_l, _centre_h,  _slice_x0, _slice_y1,         1, _yscale,   _colour, _alpha); //L edge
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1,                0, _centre_w, _border_t,  _slice_x1, _slice_y0,   _xscale,       1,   _colour, _alpha); //T edge
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2, _sprite_slice_t1, _border_r, _centre_h,  _slice_x2, _slice_y1,         1, _yscale,   _colour, _alpha); //R edge
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1, _sprite_slice_t2, _centre_w, _border_b,  _slice_x1, _slice_y2,   _xscale,       1,   _colour, _alpha); //B edge
    
    draw_sprite_part_ext(_sprite, _index,                  0,                0, _border_l, _border_t,  _slice_x0, _slice_y0,         1,       1,   _colour, _alpha); //LT corner
    draw_sprite_part_ext(_sprite, _index,                  0, _sprite_slice_t2, _border_l, _border_b,  _slice_x0, _slice_y2,         1,       1,   _colour, _alpha); //LB corner
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2,                0, _border_r, _border_t,  _slice_x2, _slice_y0,         1,       1,   _colour, _alpha); //RT corner
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2, _sprite_slice_t2, _border_r, _border_b,  _slice_x2, _slice_y2,         1,       1,   _colour, _alpha); //RB corner
}
else
{
    var _y = 0;
    repeat(_yscale)
    {
        var _x = 0;
        repeat(_xscale)
        {
            draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1, _sprite_slice_t1, _centre_w, _centre_h,  _slice_x1 + _x*_centre_w, _slice_y1 + _y*_centre_h,   1, 1,   _colour, _alpha); //Centre
            ++_x;
        }
        ++_y;
    }
    
    var _x = 0;
    repeat(_xscale)
    {
        draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1,                0, _centre_w, _border_t,  _slice_x1 + _x*_centre_w, _slice_y0,   1, 1,   _colour, _alpha); //T edge
        draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l1, _sprite_slice_t2, _centre_w, _border_b,  _slice_x1 + _x*_centre_w, _slice_y2,   1, 1,   _colour, _alpha); //B edge
        ++_x;
    }
    
    var _y = 0;
    repeat(_yscale)
    {
        draw_sprite_part_ext(_sprite, _index,                  0, _sprite_slice_t1, _border_l, _centre_h,  _slice_x0, _slice_y1 + _y*_centre_h,   1, 1,   _colour, _alpha); //L edge
        draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2, _sprite_slice_t1, _border_r, _centre_h,  _slice_x2, _slice_y1 + _y*_centre_h,   1, 1,   _colour, _alpha); //R edge
        ++_y;
    }
    
    draw_sprite_part_ext(_sprite, _index,                  0,                0, _border_l, _border_t,  _slice_x0, _slice_y0,   1, 1,   _colour, _alpha); //LT corner
    draw_sprite_part_ext(_sprite, _index,                  0, _sprite_slice_t2, _border_l, _border_b,  _slice_x0, _slice_y2,   1, 1,   _colour, _alpha); //LB corner
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2,                0, _border_r, _border_t,  _slice_x2, _slice_y0,   1, 1,   _colour, _alpha); //RT corner
    draw_sprite_part_ext(_sprite, _index,   _sprite_slice_l2, _sprite_slice_t2, _border_r, _border_b,  _slice_x2, _slice_y2,   1, 1,   _colour, _alpha); //RB corner
}