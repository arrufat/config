hook global ModuleLoaded python %{
    add-highlighter shared/python/code/function regex "[^@]\b([_a-z]\w*)\b\h*\h*\(" 1:function
    add-highlighter shared/python/code/type regex "[^@]\b([A-Z]\w*)\b\h*\h*[:\(]" 1:type
}

hook global ModuleLoaded javascript %{
    add-highlighter shared/javascript/code/function regex "[^@]\b([_a-z]\w*)\b\h*\h*\(" 1:function
    add-highlighter shared/javascript/code/type regex "[^@]\b([A-Z]\w*)\b\h*\h*[:\(]" 1:type
}
