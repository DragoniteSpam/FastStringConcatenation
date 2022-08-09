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
}