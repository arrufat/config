# Rosé Pine theme

evaluate-commands %sh{
    base="rgb:191724"
    surface="rgb:1f1d2e"
    overlay="rgb:26233a"
    muted="rgb:6e6a86"
    subtle="rgb:908caa"
    text="rgb:e0def4"
    love="rgb:eb6f92"
    gold="rgb:f6c177"
    rose="rgb:ebbcba"
    pine="rgb:31748f"
    foam="rgb:9ccfd8"
    iris="rgb:c4a7e7"
    highlight_low="rgb:21202e"
    highlight_med="rgb:403d52"
    highlight_high="rgb:524f67"

    echo "
        # Code highlighting
        face global value         ${iris}
        face global type          ${foam}
        face global variable      ${text}
        face global module        ${foam}
        face global function      ${rose}
        face global string        ${gold}
        face global keyword       ${pine}+bi
        face global operator      ${subtle}
        face global attribute     ${love}
        face global comment       ${muted}+i
        face global documentation ${gold}+i
        face global meta          ${subtle}
        face global builtin       ${love}+b

        # Extra faces for kak-lsp
        face global parameter            ${text}+b
        face global function_declaration ${rose}+b
        face global method               ${rose}+i
        face global method_declaration   ${rose}+ib
        face global property             ${text}+i
        face global property_declaration ${text}+i
        face global type_declaration     ${foam}+b
        face global value_declaration    ${foam}+b
        face global meta_member          ${subtle}+i
        face global type_parameter       ${foam}+b
        face global concept              ${foam}+i

        # Markdown highlighting
        face global title     ${gold}+b
        face global header    ${rose}
        face global mono      ${subtle}
        face global block     ${foam}
        face global link      ${iris}+u
        face global bullet    ${subtle}
        face global list      ${text}

        face global Default              ${text},${base}
        face global PrimarySelection     default,${highlight_high}+g
        face global SecondarySelection   default,${highlight_med}+g
        face global PrimaryCursor        ${base},${text}+fg
        face global SecondaryCursor      ${base},${muted}+fg
        face global PrimaryCursorEol     ${base},${subtle}+fg
        face global SecondaryCursorEol   ${base},${muted}+fg
        face global LineNumbers          ${subtle},${base}
        face global LineNumberCursor     ${gold},${base}
        face global LineNumbersWrapped   ${subtle}
        face global MenuForeground       ${text},${overlay}
        face global MenuBackground       ${subtle},${surface}
        face global MenuInfo             ${text},${surface}
        face global Information          ${text},${overlay}
        face global Error                ${love}+b
        face global StatusLine           ${text},${surface}
        face global StatusLineMode       ${gold}+b
        face global StatusLineInfo       ${foam}
        face global StatusLineValue      ${iris}
        face global StatusCursor         ${base},${text}
        face global Prompt               ${foam},${surface}+b
        face global MatchingChar         ,,${text}+cu
        face global BufferPadding        ${muted},${base}
        face global Whitespace           ${subtle}+f

        # # Extra faces for kak-lsp
        face global DiagnosticError           ${love}
        face global DiagnosticWarning         ${gold}
        face global InfoDefault               Information
        face global InfoBlock                 block
        face global InfoBlockQuote            block
        face global InfoBullet                bullet
        face global InfoHeader                header
        face global InfoLink                  link
        face global InfoLinkMono              ${iris}+u
        face global InfoMono                  builtin
        face global InfoRule                  comment
        face global InfoDiagnosticError       DiagnosticError
        face global InfoDiagnosticHint        DiagnosticWarning
        face global InfoDiagnosticInformation StatusLineInfo
        face global InfoDiagnosticWarning     DiagnosticWarning
        face global InlayHint		      ${subtle}
    "
}
