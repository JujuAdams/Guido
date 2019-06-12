im_begin(10, 10, mouse_x, mouse_y, mouse_check_button(mb_left));

#region Header

draw_set_font(fHeader);
im_text("Immediate Mode v" + __IM_VERSION + "   " + __IM_DATE);
im_newline();
if (im_hyperlink("@jujuadams")) url_open("http://www.twitter.com/JujuAdams");
im_newline();
im_newline();
draw_set_font(fTab);
im_radio_text("Welcome", "tab");
im_spacer(20);
im_radio_text("Buttons", "tab");
im_spacer(20);
im_radio_text("Other Input", "tab");
im_divider(1000);
draw_set_font(-1);
im_newline();

#endregion

switch(tab)
{
    case 0:
        im_text_ext("\"Immediate mode\" is a GUI design pattern that's very simple to use for basic GUI layouts. This particular library is inspired by the venerable ImGUI, but heavily modified to suit the programming practices of GameMaker developers. This entire demo is written in a single block of code using straight-forward scripts.", -1, 1000);
        im_newline();
        im_newline();
        im_text_ext("This library is designed with debug tools in mind. Its various UI elements (also called \"widgets\") should cover the vast majority of backend tool use cases.", -1, 1000);
    break;
    
    case 1:
        #region Buttons
        
        im_text("This library offers lots of different kinds of buttons.");
        im_newline();
        im_newline();
        
        im_text("1) Momentary buttons");
        im_newline();
        im_spacer(40);
        im_button("Example button!");
        im_spacer(20);
        im_hyperlink("And hyperlinks too");
        im_newline();
        im_newline();
        
        im_text("2) Toggle buttons");
        im_newline();
        im_spacer(40);
        im_toggle("Toggle on :)", "Toggle off :(");
        im_spacer(20);
        im_toggle_text("Toggle on :)", "Toggle off :(");
        im_newline();
        im_newline();
        
        im_text("3) Radio buttons");
        im_newline();
        im_spacer(40);
        im_radio("Option 1", undefined, "radio group 0");
        im_newline();
        im_spacer(40);
        im_radio("Option 2", undefined, "radio group 0");
        im_newline();
        im_spacer(40);
        im_radio("Option 3", undefined, "radio group 0");
        im_newline();
        im_newline();
        im_spacer(40);
        im_radio_text("Option 1", undefined, "radio group 1");
        im_newline();
        im_spacer(40);
        im_radio_text("Option 2", undefined, "radio group 1");
        im_newline();
        im_spacer(40);
        im_radio_text("Option 3", undefined, "radio group 1");
        im_newline();
        im_newline();
        
        #endregion
    break;
    
    case 2:
        #region Other Input
        
        im_text("There are other GUI elements on offer too:");
        im_newline();
        im_newline();
        
        im_text("1) Sliders");
        im_newline();
        im_spacer(40);
        im_slider(0, 69, 0, 200);
        im_text("Slider value = ", im_prev_value);
        im_newline();
        im_spacer(40);
        im_slider(7, 42, 3, 200);
        im_text("Slider value = ", im_prev_value);
        im_newline();
        im_newline();
        
        im_text("2) Real-valued and string input fields");
        im_newline();
        im_spacer(40);
        im_real_field(20, 30, 0, 150);
        im_newline();
        im_spacer(40);
        im_string_field(150);
        im_newline();
        im_newline();
        
        im_text("3) Button grids");
        im_newline();
        im_spacer(40);
        im_button_grid(11, 9, 16, 12);
        
        #endregion
    break;
}

im_end();