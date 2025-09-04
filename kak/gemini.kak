# Gemini AI integration
# ─────────────────────

define-command gemini -params .. -docstring "Query Gemini AI with optional prompt" %{
    evaluate-commands -draft %{
        # If nothing selected (single char), select from current line upwards
        try %{
            execute-keys '<a-k>..<ret>'  # Check if selection is more than 1 char
        } catch %{
            execute-keys 'x<a-h>Gg'  # Select from current line to beginning
        }
        # Save selection to register for context
        execute-keys '"gy'
    }
    evaluate-commands %sh{
        # Check API key
        if [ -z "$GEMINI_API_KEY" ]; then
            echo "fail 'GEMINI_API_KEY not set'"
            exit
        fi

        # Get context from register
        context="$kak_reg_g"

        # Build the query
        if [ $# -gt 0 ]; then
            # Parameters provided - use them as query with context prepended
            query="$@"
            # Combine context and query
            full_query="$context

$query"
        else
            # No parameters - use context as the entire query
            full_query="$context"
        fi

        # Escape for JSON using jq
        json_query=$(printf '%s' "$full_query" | jq -Rs .)

        # Call API and get response
        response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" \
            -H "x-goog-api-key: $GEMINI_API_KEY" \
            -H 'Content-Type: application/json' \
            -d "{\"contents\":[{\"parts\":[{\"text\":$json_query}]}]}" | \
            jq -r '.candidates[0].content.parts[0].text // empty')

        # Insert response
        if [ -n "$response" ]; then
            temp=$(mktemp)
            printf '%s' "$response" > "$temp"
            echo "execute-keys 'o<esc>!cat $temp<ret>'"
            echo "nop %sh{ rm $temp }"
        else
            echo "fail 'No response from Gemini'"
        fi
    }
}
