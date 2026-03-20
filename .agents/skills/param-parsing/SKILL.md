# Param Parsing Skill

Use this pattern when creating bash scripts that accept flag-based command line arguments.

## When to Use

Apply this skill whenever creating a script that takes flag-based parameters (e.g., `-f`, `--filenames-only`, `-h`, `--help`).

## Template

```bash
#!/usr/bin/env bash

# Help message displayed when -h or --help is passed
HELP_MESSAGE="Usage: scriptname -o/--output <path> [-f/--flag] [-h/--help]

Options:
  -o, --output <path> Output file path (required) 
  -f, --flag          Enable flag mode
  -h, --help          Show this help message
"

# Default values for flags
flag_variable=false
output_file=""

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -f | --flag)
    flag_variable=true
    shift 1
    ;;
  -o | --output)
    output_file="$2"
    shift 2
    ;;
  -h | --help)
    echo "$HELP_MESSAGE"
    exit 0
    ;;
  *)
    echo "Unknown param provided: $1"
    echo "$HELP_MESSAGE"
    exit 1
    ;;
  esac
done

# Script logic using parsed flags
if $flag_variable; then
  # do something
else
  # do something else
fi
```

## Key Elements

1. **HELP_MESSAGE**: Define at the top with usage instructions
2. **Default values**: Set defaults before the loop
3. **while loop**: Iterate over all arguments with `[[ "$#" -gt 0 ]]`
4. **case statement**: Match flags with short and long forms
5. **shift 1**: Move to next argument after processing
6. **exit 0**: For help flag (success)
7. **exit 1**: For unknown flags (error)
8. **Flag variables**: Use `true`/`false` for booleans

## Flag Conventions

### -h, --help
Display the help message and exit successfully. Should always be supported and listed first in the help message.

### -f, --flag
Boolean flags use `-s` short form and `--long-form`. Set the variable to `true` and shift by 1.

### -o, --output <value>
Flags that take a value use the same short/long pattern but capture `$2` (the next argument) and shift by 2.

## Example: Boolean Flag

```bash
verbose=false
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -v | --verbose)
    verbose=true
    shift 1
    ;;
  # ... other flags
  esac
done
```

## Example: Flag with Value

```bash
output_file=""
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -o | --output)
    output_file="$2"
    shift 2
    ;;
  # ... other flags
  esac
done
```
