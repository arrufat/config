# Nord theme

evaluate-commands %sh{

    nord0="rgb:2e3440"
    nord1="rgb:3b4252"
    nord2="rgb:434c5e"
    nord3="rgb:4c566a"
    # see: https://github.com/nordtheme/nord/issues/94
    nord3_bright="rgb:616e88"
    nord4="rgb:d8dee9"
    nord5="rgb:e5e9f0"
    nord6="rgb:eceff4"
    nord7="rgb:8fbcbb"
    nord8="rgb:88c0d0"
    nord9="rgb:81a1c1"
    nord10="rgb:5e81ac"
    nord11="rgb:bf616a"
    nord12="rgb:d08770"
    nord13="rgb:ebcb8b"
    nord14="rgb:a3be8c"
    nord15="rgb:b48ead"

    echo "
        # Code highlighting
        face global value         ${nord15}
        face global type          ${nord7}
        face global variable      ${nord4}
        face global module        ${nord7}+i
        face global function      ${nord8}
        face global string        ${nord14}
        face global keyword       ${nord9}
        face global operator      ${nord9}
        face global attribute     ${nord12}+i
        face global comment       ${nord3_bright}+i
        face global documentation ${nord14}+i
        face global meta          ${nord10}
        face global builtin       ${nord8}

        # Extra code highlighting faces for kak-lsp
        face global value_declaration    ${nord15}+b
        face global type_declaration     ${nord7}+b
        face global variable_declaration ${nord4}+b
        face global module_declaration   ${nord7}+ib
        face global property             ${nord4}+i
        face global property_declaration ${nord4}+ib
        face global function_declaration ${nord8}+b
        face global method               ${nord8}+i
        face global method_declaration   ${nord8}+ib
        face global meta_member          ${nord2}+i
        face global concept              ${nord7}+i
        face global escape               ${nord13}
        face global regexp               ${nord13}+i
        face global label                ${nord12}
        face global errortag             ${nord15}+i
        face global deprecated           ,,+s

        # Markdown highlighting
        face global title     ${nord8}+b
        face global header    ${nord8}
        face global mono      ${nord9}
        face global block     ${nord7}
        face global link      ${nord9}+u
        face global bullet    ${nord8}
        face global list      ${nord4}

        face global Default              ${nord6},${nord0}
        face global PrimarySelection     default,${nord2}+g
        face global SecondarySelection   default,${nord1}+g
        face global PrimaryCursor        ${nord1},${nord4}+fg
        face global SecondaryCursor      ${nord4},${nord3}+fg
        face global PrimaryCursorEol     ${nord0},${nord3}+fg
        face global SecondaryCursorEol   ${nord1},${nord2}+fg
        face global LineNumbers          ${nord3},${nord0}
        face global LineNumberCursor     ${nord4},${nord0}
        face global LineNumbersWrapped   ${nord2}
        face global MenuForeground       ${nord6},${nord3}+b
        face global MenuBackground       ${nord4},${nord1}
        face global MenuInfo             ${nord4},${nord1}
        face global Information          ${nord6},${nord1}+i
        face global InlineInformation    ${nord4},${nord1}
        face global Error                ${nord11}+b
        face global DiagnosticError      ${nord11}
        face global DiagnosticWarning    ${nord13}
        face global StatusLine           ${nord5},${nord1}
        face global StatusLineMode       ${nord8}+b
        face global StatusLineInfo       ${nord7}
        face global StatusLineValue      ${nord15}
        face global StatusCursor         ${nord1},${nord5}
        face global Prompt               ${nord8},${nord2}+b
        face global MatchingChar         ${nord8},${nord3}+b
        face global BufferPadding        ${nord3},${nord0}
        face global Whitespace           ${nord3}+f
        face global WrapMarker           ${nord3}+f

        # Extra faces for kak-lsp
        face global Reference                 default,${nord1}+b
        face global InfoDefault               Information
        face global InfoBlock                 block
        face global InfoBlockQuote            ${nord7}+i
        face global InfoBullet                bullet
        face global InfoHeader                header
        face global InfoLink                  link
        face global InfoLinkMono              ${nord15}+u
        face global InfoMono                  builtin
        face global InfoRule                  comment
        face global InfoDiagnosticError       ${nord11}+i
        face global InfoDiagnosticHint        ${nord15}+i
        face global InfoDiagnosticInformation StatusLineInfo
        face global InfoDiagnosticWarning     ${nord13}+i
        face global DiagnosticTagDeprecated   ${nord13}+i
        face global DiagnosticTagUnnecessary  ${nord13}+i
        face global InlayHint                 ${nord3}+i
"
}
