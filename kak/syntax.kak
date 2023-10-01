hook global ModuleLoaded python %{
    add-highlighter shared/python/code/function regex "[^@]\b([_a-z]\w*)\b\h*\h*\(" 1:function
    add-highlighter shared/python/code/type regex "[^@]\b([A-Z]\w*)\b\h*\h*[:\(]" 1:type
}

hook global ModuleLoaded javascript %{
    add-highlighter shared/javascript/code/function regex "[^@]\b([_a-z]\w*)\b\h*\h*\(" 1:function
    add-highlighter shared/javascript/code/type regex "[^@]\b([A-Z]\w*)\b\h*\h*[:\(]" 1:type
}

hook global ModuleLoaded zig %{
    add-highlighter -override shared/zig/string region '"' (?<!\\)(\\\\)*" group
    add-highlighter -override shared/zig/string/ fill string
    add-highlighter -override shared/zig/string/ regex '(?:\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\}|\{(any|s|d|x):?(\d+?\.?\d+?)?\})' 0:escape

    add-highlighter -override shared/zig/character region "'" (?<!\\)(\\\\)*' group
    add-highlighter -override shared/zig/character/ fill string
    add-highlighter -override shared/zig/character/ regex '(?:\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\})' 0:escape

    }
