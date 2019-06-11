im_begin(10, 10, mouse_x, mouse_y, mouse_check_button(mb_left));
im_text("Hello!");
if (im_button("Button")) show_debug_message("!");
im_newline();
im_text("World!");
im_end();