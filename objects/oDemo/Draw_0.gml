guido_begin(10, 10, mouse_x, mouse_y, mouse_check_button(mb_left));

#region Header

draw_set_font(fHeader);
guido_text("Immediate Mode v" + __GUIDO_VERSION + "   " + __GUIDO_DATE);
guido_newline();
if (guido_hyperlink("@jujuadams")) url_open("http://www.twitter.com/JujuAdams");
guido_newline();
guido_newline();
draw_set_font(fTab);
guido_tab("Welcome", "tab");
guido_spacer(20);
guido_tab("Buttons", "tab");
guido_spacer(20);
guido_tab("Other Input", "tab");
guido_divider(1000);
draw_set_font(-1);
guido_newline();

#endregion

switch(tab)
{
    case 0:
        guido_text_ext(-1, 1000, "\"Immediate mode\" is a GUI design pattern that's very simple to use for basic GUI layouts. This particular library is inspired by the venerable ImGUI, but heavily modified to suit the programming practices of GameMaker developers. This entire demo is written in a single block of code using straight-forward scripts.");
        guido_newline();
        guido_newline();
        guido_text_ext(-1, 1000, "This library is designed with debug tools in mind. Its various UI widgets should cover the vast majority of backend tool use cases.");
    break;
    
    case 1:
        #region Buttons
        
        guido_text("This library offers lots of different kinds of buttons.");
        guido_newline();
        guido_newline();
        
        guido_text("1) Momentary buttons");
        guido_newline();
        guido_spacer(40);
        guido_button("Example button!");
        guido_spacer(20);
        guido_hyperlink("And hyperlinks too");
        guido_newline();
        guido_newline();
        
        guido_text("2) Toggle buttons");
        guido_newline();
        guido_spacer(40);
        guido_checkbox("Toggle on :)", "Toggle off :(");
        guido_spacer(20);
        guido_toggle("Toggle on :)", "Toggle off :(");
        guido_newline();
        guido_newline();
        
        guido_text("3) Multiple choice buttons");
        guido_newline();
        guido_spacer(40);
        guido_radio("Option 1", undefined, "radio group 0");
        guido_newline();
        guido_spacer(40);
        guido_radio("Option 2", undefined, "radio group 0");
        guido_newline();
        guido_spacer(40);
        guido_radio("Option 3", undefined, "radio group 0");
        guido_newline();
        guido_newline();
        guido_spacer(40);
        guido_tab("Option 1", undefined, "radio group 1");
        guido_newline();
        guido_spacer(40);
        guido_tab("Option 2", undefined, "radio group 1");
        guido_newline();
        guido_spacer(40);
        guido_tab("Option 3", undefined, "radio group 1");
        guido_newline();
        guido_newline();
        
        #endregion
    break;
    
    case 2:
        #region Other Input
        
        guido_text("There are other GUI widgets on offer too:");
        guido_newline();
        guido_newline();
        
        guido_text("1) Sliders");
        guido_newline();
        guido_spacer(40);
        guido_slider(0, 69, 0, 200);
        guido_text("Slider value = ", guido_prev_value);
        guido_newline();
        guido_spacer(40);
        guido_slider(7, 42, 3, 200);
        guido_text("Slider value = ", guido_prev_value, " (7 -> 42, steps of 3)");
        guido_newline();
        guido_newline();
        
        guido_text("2) Real-valued and string input fields");
        guido_newline();
        guido_spacer(40);
        guido_real_field(20, 30, 0, 150);
        guido_text("(20 -> 30)");
        guido_newline();
        guido_spacer(40);
        guido_string_field(150);
        guido_newline();
        guido_newline();
        
        guido_text("3) Button grids");
        guido_newline();
        guido_spacer(40);
        guido_grid(11, 9, 16, 12);
        guido_newline();
        guido_spacer(132);
        draw_set_halign(fa_center);
        guido_text(guido_prev_value);
        draw_set_halign(fa_left);
        
        #endregion
    break;
}

guido_end();