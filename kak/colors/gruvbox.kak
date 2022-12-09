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
    bg_alpha="rgba:282828a0"
    bg1="rgb:3c3836"
    bg2="rgb:504945"
    bg3="rgb:665c54"
    bg4="rgb:7c6f64"

    fg="rgb:ebdbb2"
    fg_alpha="rgba:ebdbb2a0"
    fg0="rgb:fbf1c7"
    fg2="rgb:d5c4a1"
    fg3="rgb:bdae93"
    fg4="rgb:a89984"

    echo "
        # Code highlighting
        face global value         ${purple}
        face global type          ${yellow}
        face global variable      ${blue}
        face global module        ${green}
        face global function      ${fg}
        face global string        ${green}
        face global keyword       ${red}
        face global operator      ${fg}
        face global attribute     ${orange}
        face global comment       ${gray}+i
        face global documentation ${gray}
        face global meta          ${aqua}
        face global builtin       ${fg}+b

        # Extra faces for kak-lsp
        face global parameter            ${blue}+b
        face global function_declaration ${fg}+b
        face global method               ${fg}+i
        face global method_declaration   ${fg}+ib
        face global property             ${blue}+i
        face global property_declaration ${blue}+i
        face global type_declaration     ${yellow}+b
        face global value_declaration    ${purple}+b
        face global meta_member          ${aqua}+i
        face global type_parameter       ${yellow}+b
        face global concept              ${yellow}+i

        # Markdown highlighting
        face global title     ${green}+b
        face global header    ${orange}
        face global mono      ${fg4}
        face global block     ${aqua}
        face global link      ${blue}+u
        face global bullet    ${yellow}
        face global list      ${fg}

        face global Default            ${fg},${bg}
        face global PrimarySelection   ${fg_alpha},${blue}+g
        face global SecondarySelection ${bg_alpha},${blue}+g
        face global PrimaryCursor      ${bg},${fg}+fg
        face global SecondaryCursor    ${bg},${bg4}+fg
        face global PrimaryCursorEol   ${bg},${fg4}+fg
        face global SecondaryCursorEol ${bg},${bg2}+fg
        face global LineNumbers        ${bg4}
        face global LineNumberCursor   ${yellow},${bg1}
        face global LineNumbersWrapped ${bg1}
        face global MenuForeground     ${bg2},${blue}
        face global MenuBackground     ${fg},${bg2}
        face global MenuInfo           ${fg4},${bg2}
        face global Information        ${fg1},${bg1}
        face global Error              ${bg},${red}
        face global DiagnosticError    ${red}
        face global DiagnosticWarning  ${yellow}
        face global StatusLine         ${fg},${bg1}
        face global StatusLineMode     ${yellow}+b
        face global StatusLineInfo     ${aqua}
        face global StatusLineValue    ${purple}
        face global StatusCursor       ${bg},${fg}
        face global Prompt             ${yellow}
        face global MatchingChar       ${fg},${bg3}+b
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
    "
}
