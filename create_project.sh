#!/bin/bash

# Function to check if folder exists
function folder_exists() {
  local folder_path="$1"
  if [[ -d "$folder_path" ]]; then
    return 0  # Folder exists
  else
    return 1  # Folder doesn't exist
  fi
}

# Get user input for project name
read -p "Enter project name: " project_name

# Validate project name (avoid empty or special characters)
if [[ -z "$project_name" || "$project_name" =~ [^[:alnum:]_-] ]]; then
  echo "Invalid project name. Please use letters, numbers, underscores, or hyphens."
  exit 1
fi

# Create project folder path
project_folder="F:/Project/$project_name"

# Loop to handle existing project or create new
while true; do
  # Check if folder exists
  if folder_exists "$project_folder"; then
    # Project exists, offer options
    read -p "Project '$project_name' already exists. Open (o) or Create New (n)? (o/n): " choice

    case "$choice" in
      o|O)
        # Open existing project
        code "$project_folder"
        echo "Opened project '$project_name' in VSCode."
        break  # Exit the loop
        ;;
      n|N)
        # Create new project (prompt for new name again)
        read -p "Enter a new project name: " project_name
        # ... (reset project_folder based on new name)
        project_folder="F:/Project/$project_name"
        ;;
      *)
        echo "Invalid choice. Please enter 'o' or 'n'."
        ;;
    esac  # End of inner case statement
  else
    # Project doesn't exist, create it
    mkdir -p "$project_folder"
    code "$project_folder"
    echo "Project '$project_name' created and opened in VSCode."
    break  # Exit the loop
  fi
done
