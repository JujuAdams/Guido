var _layer = 0;
repeat(array_length_1d(__guido_layer_array))
{
    var _queue_array = __guido_layer_array[_layer];
    
    var _q = 0;
    repeat(array_length_1d(_queue_array))
    {
        var _array = _queue_array[_q];
        var _script = _array[0];
        
        if (is_string(_script))
        {
            if (asset_get_type(_script) == asset_script) _script = asset_get_index(_script);
        }
        
        if (is_real(_script) && script_exists(_script))
        {
            switch(array_length_1d(_array))
            {
                case 1: script_execute(_script); break;
            }
        }
        else if (is_string(_script))
        {
            switch(_script)
            {
                case "draw_line": draw_line(_array[1], _array[2], _array[3], _array[4]); break;
                
            }
        }
        
        ++_q;
    }
    
    ++_layer;
}