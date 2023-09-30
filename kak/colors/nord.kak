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
        face global module        ${nord7}
        face global function      ${nord8}
        face global string        ${nord14}
        face global keyword       ${nord9}+bi
        face global operator      ${nord9}
        face global attribute     ${nord12}+i
        face global comment       ${nord3_bright}+i
        face global documentation ${nord14}+i

        # Extra faces for kak-lsp
        face global meta                 ${nord10}
        face global builtin              ${nord8}+b
        face global regexp               ${nord13}
        face global label                ${nord9}
        face global variable_declaration ${nord4}+b
        face global parameter            variable_declaration
        face global function_declaration ${nord8}+b
        face global method               ${nord8}+i
        face global method_declaration   ${nord8}+ib
        face global property             ${nord4}+i
        face global property_declaration ${nord4}+i
        face global type_declaration     ${nord7}+b
        face global value_declaration    ${nord15}+b
        face global meta_member          ${nord2}+i
        face global type_parameter       ${nord7}+b
        face global concept              ${nord7}+i

        # Markdown highlighting
        face global title     ${nord14}+b
        face global header    ${nord8}
        face global mono      ${nord10}
        face global block     ${nord7}
        face global link      ${nord15}+u
        face global bullet    ${nord9}
        face global list      ${nord9}

        face global Default              ${nord6},${nord0}
        face global PrimarySelection     default,${nord2}+g
        face global SecondarySelection   default,${nord1}+g
        face global PrimaryCursor        ${nord1},${nord4}+fg
        face global SecondaryCursor      ${nord4},${nord3}+fg
        face global PrimaryCursorEol     ${nord0},${nord3}+fg
        face global SecondaryCursorEol   ${nord1},${nord2}+fg
        face global LineNumbers          ${nord3},${nord0}
        face global LineNumberCursor     ${nord4},${nord2}
        face global LineNumbersWrapped   ${nord2}
        face global MenuForeground       ${nord6},${nord2}
        face global MenuBackground       ${nord4},${nord1}
        face global MenuInfo             ${nord4},${nord1}
        face global Information          ${nord4},${nord1}
        face global Error                ${nord11}+b
        face global DiagnosticError      ,,${nord11}+cu
        face global DiagnosticWarning    ,,${nord14}+cu
        face global StatusLine           ${nord4},${nord1}
        face global StatusLineMode       ${nord8}+b
        face global StatusLineInfo       ${nord7}
        face global StatusLineValue      ${nord15}
        face global StatusCursor         ${nord1},${nord4}
        face global Prompt               ${nord8},${nord1}+b
        face global MatchingChar         default,${nord1}+b
        face global BufferPadding        ${nord3},${nord0}
        face global Whitespace           ${nord3}+f

        # # Extra faces for kak-lsp
        face global InfoDefault               Information
        face global InfoBlock                 block
        face global InfoBlockQuote            block
        face global InfoBullet                bullet
        face global InfoHeader                header
        face global InfoLink                  link
        face global InfoLinkMono              ${nord15}+u
        face global InfoMono                  builtin
        face global InfoRule                  comment
        face global InfoDiagnosticError       DiagnosticError
        face global InfoDiagnosticHint        DiagnosticWarning
        face global InfoDiagnosticInformation StatusLineInfo
        face global InfoDiagnosticWarning     DiagnosticWarning
        face global InlayHint		      ${nord2}
    "
}
