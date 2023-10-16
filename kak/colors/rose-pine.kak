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

    # base="rgb:232136"
    # surface="rgb:2a273f"
    # overlay="rgb:393552"
    # muted="rgb:6e6a86"
    # subtle="rgb:908caa"
    # text="rgb:e0def4"
    # love="rgb:eb6f92"
    # gold="rgb:f6c177"
    # rose="rgb:ebbcba"
    # pine="rgb:31748f"
    # foam="rgb:9ccfd8"
    # iris="rgb:c4a7e7"
    # highlight_low="rgb:2a283e"
    # highlight_med="rgb:44415a"
    # highlight_high="rgb:56526e"

    # base="rgb:faf4ed"
    # surface="rgb:fffaf3"
    # overlay="rgb:f2e9e1"
    # muted="rgb:9893a5"
    # subtle="rgb:797593"
    # text="rgb:575279"
    # love="rgb:b4637a"
    # gold="rgb:ea9d34"
    # rose="rgb:d7827e"
    # pine="rgb:286983"
    # foam="rgb:56949f"
    # iris="rgb:907aa9"
    # highlight_low="rgb:f4ede8"
    # highlight_med="rgb:dfdad9"
    # highlight_high="rgb:cecacd"

    echo "
        # Code highlighting
        face global value         ${gold}
        face global type          ${foam}
        face global variable      ${text}
        face global module        ${foam}
        face global function      ${rose}
        face global string        ${gold}
        face global keyword       ${pine}+bi
        face global operator      ${subtle}
        face global attribute     ${love}+i
        face global comment       ${muted}+i
        face global documentation ${gold}+i
        face global meta          ${subtle}
        face global builtin       ${rose}

        # Extra code highlighting faces for kak-lsp
        face global value_declaration    ${gold}+b
        face global type_declaration     ${foam}+b
        face global variable_declaration ${text}+b
        face global property             ${text}+i
        face global property_declaration ${text}+i
        face global function_declaration ${rose}+b
        face global method               ${iris}+i
        face global method_declaration   ${iris}+ib
        face global meta_member          ${subtle}+i
        face global concept              ${foam}+i
        face global escape               ${foam}
        face global regexp               ${foam}
        face global label                ${subtle}

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
        face global SecondaryCursor      ${surface},${subtle}+fg
        face global PrimaryCursorEol     ${base},${subtle}+fg
        face global SecondaryCursorEol   ${surface},${muted}+fg
        face global LineNumbers          ${subtle},${surface}
        face global LineNumberCursor     ${gold},${surface}
        face global LineNumbersWrapped   ${muted},${surface}
        face global MenuForeground       ${text},${overlay}
        face global MenuBackground       ${subtle},${overlay}
        face global MenuInfo             ${muted},${overlay}
        face global Information          ${text},${overlay}
        face global InlineInformation    ${text},${overlay}
        face global Error                ${love}+b
        face global DiagnosticError      ,,${love}+cu
        face global DiagnosticWarning    ,,${gold}+cu
        face global StatusLine           ${text},${overlay}
        face global StatusLineMode       ${rose}+b
        face global StatusLineInfo       ${foam}
        face global StatusLineValue      ${gold}
        face global StatusCursor         ${base},${text}
        face global Prompt               ${foam},${overlay}+b
        face global MatchingChar         default,${highlight_low}+b
        face global BufferPadding        ${muted},${base}
        face global Whitespace           ${subtle}+f

        # # Extra faces for kak-lsp
        face global InfoDefault               Information
        face global InfoBlock                 block
        face global InfoBlockQuote            ${foam}+i
        face global InfoBullet                bullet
        face global InfoHeader                header
        face global InfoLink                  link
        face global InfoLinkMono              ${iris}+u
        face global InfoMono                  builtin
        face global InfoRule                  comment
        face global InfoDiagnosticError       ${love}
        face global InfoDiagnosticHint        ${iris}
        face global InfoDiagnosticInformation StatusLineInfo
        face global InfoDiagnosticWarning     DiagnosticWarning
        face global InlayHint                 ${subtle}
    "
}
