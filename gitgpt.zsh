gitgpt() {
	if ! command -v jq >/dev/null; then
    echo "Error: jq is not installed. Please install jq and try again."
    return 1
  fi

  if [ -z "$OPENAI_API_KEY" ]; then
    echo "Error: OPENAI_API_KEY is not set. Please set your API key and try again."
    return 1
  fi


  QUERY="$@"
  PRMPT="Tell me exactly what GIT command I can copy and paste to run in my terminal that will achieve ${QUERY}. Answer a valid GIT command and nothing else."

  RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
      \"model\": \"gpt-3.5-turbo\",
      \"messages\": [{\"role\": \"user\", \"content\": \"$PRMPT\"}],
      \"temperature\": 0.5,
      \"max_tokens\": 100
  }")

  ERROR_MESSAGE=$(echo "$RESPONSE" | jq -r '.error.message // ""')
  COMMAND=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // ""')

	if [ -n "$ERROR_MESSAGE" ]; then
		echo "Error: $ERROR_MESSAGE"
	elif [ -n "$COMMAND" ]; then
		if [[ "$COMMAND" =~ ^git ]]; then
			echo "-> $COMMAND"
			read -q "REPLY?Do you want to run this command? (y/n)"
			if [[ "$REPLY" =~ ^[Yy]$ ]]; then
				echo
				eval "$COMMAND"
			else
				echo
				echo "Command not executed."
			fi
		else
			echo "Output does not start with 'git' and won't be executed."
			echo "Generated output: $COMMAND"
		fi
	else
		echo "Error: Couldn't generate a command."
	fi
}