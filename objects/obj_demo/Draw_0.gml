draw_set_colour($CCEBFF);
draw_set_font(fnt_body);
guido_set_negative_colour($12123D);

guido_begin(10, 10, mouse_x, mouse_y, mouse_check_button(mb_left));

#region Header

draw_set_font(fnt_header);
guido_text("Immediate Mode v" + __GUIDO_VERSION + "   " + __GUIDO_DATE);
guido_newline();
if (guido_hyperlink("@jujuadams")) url_open("http://www.twitter.com/JujuAdams");
guido_newline();
guido_newline();
draw_set_font(fnt_tab);
guido_spacer(10);
guido_tab(" Intro ", "tab");
guido_spacer(20);
guido_tab(" Buttons ", "tab");
guido_spacer(20);
guido_tab(" More Input ", "tab");

guido_draw_9slice(spr_window_background, 0,   4, 4,   59, 59,
                  guido_xstart, guido_y + guido_line_height, room_width - guido_xstart, room_height - guido_ystart,
                  true, c_white, 0.4);

draw_set_font(fnt_body);
guido_newline();

#endregion

switch(tab)
{
    case 0:
        #region Intro
        
        guido_text_ext(-1, 1000, "\"Immediate mode\" is a GUI design pattern that's very simple to use for basic GUI layouts. This particular library is inspired by the venerable ImGUI, but heavily modified to suit the programming practices of GameMaker developers. This entire demo is written in a single block of code using straight-forward scripts.");
        guido_newline(20);
        guido_text_ext(-1, 1000, "This library is designed with debug tools in mind. Its various UI widgets should cover the vast majority of backend tool use cases.");
        guido_divider(1000);
        guido_text_ext(-1, 1000, "Guido's structure allows you to lay out UI components as you would text on a page. Each component is a single script call, and each script call returns a \"state\" that can be used to check for user interaction.");
        guido_newline();
        if (guido_button("Click me!")) counter++;
        guido_spacer(10);
        guido_text("counter = ", counter, "   (state = ", guido_prev_state, ")");
        guido_newline(20);
        guido_text_ext(-1, 1000, "Many widgets can directly adjust variables which allows for Guido to work with code that you've already written.");
        guido_newline(0, 10);
        guido_slider(0, 69, 0, 200, "slider");
        guido_spacer(10);
        guido_text("slider = ", slider);
        if (slider == 69) guido_text("   nice.");
        guido_newline(20);
        guido_text_ext(-1, 1000, "You can also use the \"guido_prev_value\" variable to access the previous widget's internally held value. This can be useful for more complicated code.");
        guido_newline();
        guido_string_field(300, false, "string_field");
        guido_newline();
        guido_text("\"", guido_prev_value, "\"");
        
        #endregion
    break;
    
    case 1:
        #region Buttons
        
        guido_text("This library offers lots of different kinds of buttons.");
        guido_newline();
        guido_newline();
        
        guido_text("1) Momentary buttons");
        guido_newline(0, 40);
        guido_button("Example button!");
        guido_spacer(20);
        guido_hyperlink("And hyperlinks too");
        guido_newline();
        guido_newline();
        
        guido_text("2) Toggle buttons");
        guido_newline(0, 40);
        guido_checkbox("Toggle on :)", "Toggle off :(");
        guido_spacer(20);
        guido_toggle("Toggle on :)", "Toggle off :(");
        guido_newline();
        guido_newline();
        
        guido_text("3) Multiple choice buttons");
        guido_newline(0, 40);
        guido_radio("Option 1", undefined, "radio group 0");
        guido_newline(0, 40);
        guido_radio("Option 2", undefined, "radio group 0");
        guido_newline(0, 40);
        guido_radio("Option 3", undefined, "radio group 0");
        guido_newline();
        guido_newline(0, 40);
        guido_tab("Option 1", undefined, "radio group 1");
        guido_tab("Option 2", undefined, "radio group 1");
        guido_tab("Option 3", undefined, "radio group 1");
        guido_newline(0, 40);
        guido_tab("Option 4", undefined, "radio group 1");
        guido_tab("Option 5", undefined, "radio group 1");
        guido_tab("Option 6", undefined, "radio group 1");
        guido_newline();
        guido_newline();
        
        #endregion
    break;
    
    case 2:
        #region More Input
        
        guido_text("There are other GUI widgets on offer too:");
        guido_newline(15);
        
        guido_text("1) Sliders");
        guido_newline(0, 40);
        guido_slider(0, 69, 0, 200, slider);
        guido_text("Slider value = ", guido_prev_value);
        guido_newline(0, 40);
        guido_slider(7, 42, 3, 200);
        guido_text("Slider value = ", guido_prev_value, " (7 -> 42, steps of 3)");
        guido_newline();
        guido_newline();
        
        guido_text("2) Real-valued and string input fields");
        guido_newline(0, 40);
        guido_real_field(20, 30, 0, 150);
        guido_text("(20 -> 30)");
        guido_newline(0, 40);
        guido_string_field(150);
        guido_newline();
        guido_newline();
        
        guido_text("3) Button grids");
        guido_newline(0, 40);
        guido_grid(7, 5, 32, 24);
        guido_newline(0, 132);
        draw_set_halign(fa_center);
        guido_text(guido_prev_value);
        draw_set_halign(fa_left);
        
        #endregion
    break;
}

guido_end();