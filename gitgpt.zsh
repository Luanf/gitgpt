gitgpt() {
  OPENAI_API_KEY=$OPENAI_API_KEY

  QUERY="$@"
  PROMPT="Tell me exactly what GIT command I can copy and paste to run in my terminal that will achieve ${QUERY}. Answer a valid GIT command and nothing else."

  RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
      \"model\": \"gpt-3.5-turbo\",
      \"messages\": [{\"role\": \"user\", \"content\": \"$PROMPT\"}],
      \"temperature\": 0.5,
      \"max_tokens\": 50
  }")

  ERROR_MESSAGE=$(echo "$RESPONSE" | jq -r '.error.message // ""')
  COMMAND=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // ""')

  if [ -n "$ERROR_MESSAGE" ]; then
    echo "Error: $ERROR_MESSAGE"
  elif [ -n "$COMMAND" ]; then
		echo "-> $COMMAND"
  	read -q "REPLY?Do you want to run this command? (y/n)"
  	echo
  	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    	eval "$COMMAND"
			eval "zsh"
			eval "clear"
		else
			echo "Command not executed."
			eval "zsh"
			eval "clear"
		fi
  else
    echo "Error: Couldn't generate a command."
  fi
}

