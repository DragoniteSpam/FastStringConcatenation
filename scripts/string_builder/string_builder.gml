function StringBuilder(text = "") constructor {
    self.buffer = buffer_create(1024, buffer_grow, 1);
    buffer_write(self.buffer, buffer_text, text);
    
    self.Append = function(appendage) {
        buffer_write(self.buffer, buffer_text, appendage);
        return self;
    };
    
    self.Clear = function() {
        buffer_seek(self.buffer, buffer_seek_start, 0);
        return self;
    };
    
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