hook global ModuleLoaded python %{
    add-highlighter shared/python/code/function regex "[^@]\b([_a-z]\w*)\b\h*\(" 1:function
    add-highlighter shared/python/code/type regex "[^@]\b([A-Z]\w*)\b\h*[:\(]" 1:type
    # string interpolation
    add-highlighter -override shared/python/f_triple_string region -match-capture [fF]("""|''') (?<!\\)(?:\\\\)*("""|''') group
    add-highlighter -override shared/python/f_triple_string/ fill string
    add-highlighter -override shared/python/f_triple_string/ regex \{.*?\} 0:escape
    add-highlighter -override shared/python/f_double_string region '[fF]"'   (?<!\\)(\\\\)*" group
    add-highlighter -override shared/python/f_double_string/ fill string
    add-highlighter -override shared/python/f_double_string/ regex \{.*?\} 0:escape
    add-highlighter -override shared/python/f_single_string region "[fF]'"   (?<!\\)(\\\\)*' group
    add-highlighter -override shared/python/f_single_string/ fill string
    add-highlighter -override shared/python/f_single_string/ regex \{.*?\} 0:escape
}

hook global ModuleLoaded go %{
    add-highlighter -override shared/go/double_string region '"' (?<!\\)(\\\\)*" group
    add-highlighter -override shared/go/double_string/ fill string
    add-highlighter -override shared/go/double_string/ regex '\\([abfnrtv\\"]|[0-7]{1,3}|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|U[0-9a-fA-F]{8})' 0:escape
}

hook global ModuleLoaded javascript %{
    add-highlighter shared/javascript/code/function regex "[^@]\b([_a-z]\w*)\b\h*\h*\(" 1:function
    add-highlighter shared/javascript/code/type regex "[^@]\b([A-Z]\w*)\b\h*\h*[:\(]" 1:type
}

hook global ModuleLoaded makefile %{
    add-highlighter -override shared/makefile/content/ regex ^\S.*?(::|:|!)\s 0:function
}

hook global ModuleLoaded zig %{
    # string interpolation
    add-highlighter -override shared/zig/string region '"' (?<!\\)(\\\\)*" group
    add-highlighter -override shared/zig/string/ fill string
    add-highlighter -override shared/zig/string/ regex \
    '\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\}' 0:escape
    # Zig format string: an odd number of opening and closing curly braces enclosing the format string
    add-highlighter -override shared/zig/string/ regex \
    '(?<!\{)(?:\{\{)*(\{([^\{\}]*)(\[[_a-zA-Z]\w*\])?(\d+)?(((\?|!)?(x|X|s|e|d|b|o|c|u|\?|!|\*|any)?)(:(.|\\n|\\t|\\|\\"|\\'')?([<^>])?\d*\.?\d+?)?)?\})(?:\}\})*(?!\})' 1:escape

    add-highlighter -override shared/zig/multiline_string region '\\\\' '$' group
    add-highlighter -override shared/zig/multiline_string/ fill string
    # Zig format string: an odd number of opening and closing curly braces enclosing the format string
    add-highlighter -override shared/zig/multiline_string/ regex \
    '(?<!\{)(?:\{\{)*(\{([^\{\}]*)(\[[_a-zA-Z]\w*\])?(\d+)?(((\?|!)?(x|X|s|e|d|b|o|c|u|\?|!|\*|any)?)(:(.|\\n|\\t|\\|\\"|\\'')?([<^>])?\d*\.?\d+?)?)?\})(?:\}\})*(?!\})' 1:escape

    add-highlighter -override shared/zig/character region "'" (?<!\\)(\\\\)*' group
    add-highlighter -override shared/zig/character/ fill string
    add-highlighter -override shared/zig/character/ regex \
    '\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\}' 0:escape
}
