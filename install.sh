#!/bin/bash

# Append the gitgpt definition to the user's .zshrc file
cat gitgpt.zsh >> ~/.zshrc

echo "Installed. Reload your shell to use gitgpt, and make sure you have the OPENAI_API_KEY environment variable set."
