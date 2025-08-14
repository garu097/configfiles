#!/bin/bash

# Default values
DEFAULT_NAME="Your Name"
DEFAULT_EMAIL="your@example.com"

if [ "$#" -eq 2 ]; then
  NAME="$1"
  EMAIL="$2"
elif [ "$#" -eq 0 ]; then
  NAME="$DEFAULT_NAME"
  EMAIL="$DEFAULT_EMAIL"
else
  echo "Usage: $0 [<name> <email>]"
  exit 1
fi

# Set global Git config
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

echo "✅ Git config updated:"
echo "   user.name  = $(git config --global user.name)"
echo "   user.email = $(git config --global user.email)"