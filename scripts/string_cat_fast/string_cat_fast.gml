function string_cat_fast(str1, str2) {
    static buffer = buffer_create(4096, buffer_grow, 1);
    buffer_seek(buffer, buffer_seek_start, 0);
    
    buffer_write(buffer, buffer_text, str1);
    buffer_write(buffer, buffer_text, str2);
    buffer_write(buffer, buffer_u8, 0);
    
    return buffer_peek(buffer, 0, buffer_text);
}