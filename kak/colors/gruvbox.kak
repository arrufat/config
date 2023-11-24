# gruvbox-dark theme

evaluate-commands %sh{
    gray="rgb:928374"
    red="rgb:fb4934"
    green="rgb:b8bb26"
    yellow="rgb:fabd2f"
    blue="rgb:83a598"
    purple="rgb:d3869b"
    aqua="rgb:8ec07c"
    orange="rgb:fe8019"

    bg="rgb:282828"
    bg1="rgb:3c3836"
    bg2="rgb:504945"
    bg3="rgb:665c54"
    bg4="rgb:7c6f64"

    fg="rgb:ebdbb2"
    fg0="rgb:fbf1c7"
    fg2="rgb:d5c4a1"
    fg3="rgb:bdae93"
    fg4="rgb:a89984"

    echo "
        # Code highlighting
        face global value         ${purple}
        face global type          ${yellow}
        face global variable      ${fg}
        face global module        ${green}+i
        face global function      ${blue}
        face global string        ${green}
        face global keyword       ${red}+i
        face global operator      ${fg3}
        face global attribute     ${orange}
        face global comment       ${gray}+i
        face global documentation ${green}+i
        face global meta          ${aqua}
        face global builtin       ${aqua}

        # Extra faces for kak-lsp
        face global variable_declaration ${fg}+b
        face global parameter            ${fg}+b
        face global function_declaration ${blue}+b
        face global method               ${blue}+i
        face global method_declaration   ${blue}+ib
        face global property             ${fg}+i
        face global property_declaration ${fg}+ib
        face global type_declaration     ${yellow}+b
        face global value_declaration    ${purple}+b
        face global meta_member          ${aqua}+i
        face global type_parameter       ${yellow}+b
        face global concept              ${yellow}+i
        face global escape               ${yellow}
        face global regexp               ${yellow}+i
        face global label                ${aqua}

        # Markdown highlighting
        face global title     ${green}+b
        face global header    ${orange}
        face global mono      ${fg4}
        face global block     ${aqua}
        face global link      ${blue}+u
        face global bullet    ${yellow}
        face global list      ${fg}

        face global Default            ${fg},${bg}
        face global PrimarySelection   default,${bg3}+g
        face global SecondarySelection default,${bg2}+g
        face global PrimaryCursor      ${bg},${fg}+fg
        face global SecondaryCursor    ${fg4},${bg4}+fg
        face global PrimaryCursorEol   ${bg},${fg4}+fg
        face global SecondaryCursorEol ${fg4},${bg3}+fg
        face global LineNumbers        ${bg4}
        face global LineNumberCursor   ${yellow},${bg1}
        face global LineNumbersWrapped ${bg1}
        face global MenuForeground     ${fg0},${bg1}
        face global MenuBackground     ${fg4},${bg1}
        face global MenuInfo           ${fg4},${bg1}
        face global Information        ${fg},${bg1}
        face global Error              ${red}+b
        face global DiagnosticError    ,,${red}+uc
        face global DiagnosticWarning  ,,${yellow}+uc
        face global StatusLine         ${fg},${bg1}
        face global StatusLineMode     ${yellow}+b
        face global StatusLineInfo     ${aqua}
        face global StatusLineValue    ${purple}
        face global StatusCursor       ${bg},${fg}
        face global Prompt             ${yellow}+b
        face global MatchingChar       ${fg},${bg1}+b
        face global BufferPadding      ${bg2},${bg}
        face global Whitespace         ${bg2}+f

        # Extra faces for kak-lsp
        face global InfoDefault               Information
        face global InfoBlock                 block
        face global InfoBlockQuote            block
        face global InfoBullet                bullet
        face global InfoHeader                header
        face global InfoLink                  link
        face global InfoLinkMono              ${fg}+u
        face global InfoMono                  builtin
        face global InfoRule                  comment
        face global InfoDiagnosticError       DiagnosticError
        face global InfoDiagnosticHint        DiagnosticWarning
        face global InfoDiagnosticInformation StatusLineInfo
        face global InfoDiagnosticWarning     DiagnosticWarning
        face global InlayHint		      ${gray}
    "
}
