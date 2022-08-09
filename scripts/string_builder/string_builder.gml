/// @description Creates a StringBuilder struct, which you can use to append text much more quickly than with ordinary string concatenation; this is MUCH faster than ordinary GameMaker string concatenation
/// @param text {string}
function StringBuilder(text = "") constructor {
    self.buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(self.buffer, buffer_text, text);
    
    /// @description Append text onto a StringBuilder; returns itself
    /// @param strings... {string}
    /// @return {StringBuilder}
    self.Append = function() {
        for (var i = 0; i < argument_count; i++) {
            buffer_write(self.buffer, buffer_text, string(argument[i]));
        }
        return self;
    };
    
    /// @description Erase the contents of the StringBuilder; returns itself
    /// @return {StringBuilder}
    self.Clear = function() {
        buffer_seek(self.buffer, buffer_seek_start, 0);
        return self;
    };
    
    /// @description Returns the final built string; implicitly called when you `string()` an instance of StringBuilder
    /// @return {string}
    self.toString = function() {
        buffer_write(self.buffer, buffer_u8, 0);
        var output = buffer_peek(self.buffer, 0, buffer_text);
        buffer_seek(self.buffer, buffer_seek_relative, -1);
        return output;
    };
    
    var ref = weak_ref_create(self);
    ref.buffer = self.buffer;
    ds_list_add(global.__builder_refs, ref);
}

global.__builder_refs = ds_list_create();

call_later(10, time_source_units_seconds, function() {
    for (var i = ds_list_size(global.__builder_refs) - 1; i >= 0; i--) {
        if (!weak_ref_alive(global.__builder_refs[| i])) {
            buffer_delete(global.__builder_refs[| i].buffer);
            ds_list_delete(global.__builder_refs, i);
        }
    }
}, true);