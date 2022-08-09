/// @param args... {string}
/// @return {string}
function string_cat_fast() {
    gml_pragma("forceinline");
    static buffer = buffer_create(4096, buffer_grow, 1);
    buffer_seek(buffer, buffer_seek_start, 0);
    
    for (var i = 0; i < argument_count; i++) {
        buffer_write(buffer, buffer_text, string(argument[i]));
    }
    buffer_write(buffer, buffer_u8, 0);
    
    return buffer_peek(buffer, 0, buffer_text);
}