/// @description "Fast" string concatenation; I've found that this isn't actually faster unless you concatenate a LOT of strings together but ymmv
/// @param strings... {string}
/// @return {string}
function string_cat_fast() {
    gml_pragma("forceinline");
    static builder = new StringBuilder();
    builder.Clear();
    
    for (var i = 0; i < argument_count; i++) {
        builder.Append(argument[i]);
    }
    
    return builder.toString();
}