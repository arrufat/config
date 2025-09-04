# Gemini AI integration
# ─────────────────────

define-command gemini -params .. -docstring "Query Gemini AI with optional prompt" %{
    evaluate-commands -draft %{
        try %{
            execute-keys '<a-k>..<ret>'
        } catch %{
            execute-keys 'x<a-h>Gg'
        }
        execute-keys '"gy'
    }
    evaluate-commands %sh{
        if [ -z "$GEMINI_API_KEY" ]; then
            echo "fail 'GEMINI_API_KEY not set'"
            exit
        fi

        if [ $# -gt 0 ]; then
            full_query=$(printf '%s\n\n%s' "$kak_reg_g" "$@")
        else
            full_query="$kak_reg_g"
        fi

        json_query=$(printf '%s' "$full_query" | jq -Rs .)
        response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" \
            -H "x-goog-api-key: $GEMINI_API_KEY" \
            -H 'Content-Type: application/json' \
            -d "{\"contents\":[{\"parts\":[{\"text\":$json_query}]}]}" | \
            jq -r '.candidates[0].content.parts[0].text // empty')

        if [ -n "$response" ]; then
            echo "execute-keys 'o<esc>'"
            printf 'set-register z %s%s%s\n' '%§' "$response" '§'
            echo "execute-keys '\"zP'"
        else
            echo "fail 'No response from Gemini'"
        fi
    }
}

