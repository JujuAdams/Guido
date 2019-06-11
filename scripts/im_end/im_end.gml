var _e = 0;
repeat(array_length_1d(__im_element_data))
{
    var _array = __im_element_data[_e];
    if (!_array[__IM_ELEMENT.OVER]) _array[@ __IM_ELEMENT.STATE] = IM_STATE.NULL;
    ++_e;
}