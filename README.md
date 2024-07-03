# Ollama Functions Script | BASH

This repository contains a Bash script (`ollama.sh`) that provides functions to manage and run models using the Ollama server.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Functions](#functions)
  - [Alias](#alias)

## Installation

1. Clone this repository or download the `ollama.sh` script to your home directory:

   ```bash
   curl -o ~/scripts/ollama.sh https://raw.githubusercontent.com/xcvrys/ollama-bash-starter/main/ollama.sh
   ```

2. Add this line to your ~/.bashrc

```bash
    if [ -f ~/scripts/ollama.sh ]; then
        source ~/scripts/ollama.sh
    fi
```

3. Reload your `~/.bashrc` file to apply the changes:

```bash
source ~/.bashrc
```

# Usage

## Functions

`get_ollama_models`
Retrieves a list of available models from the Ollama server.

`check_in_models`
Checks if a specified model exists in the list of available models.

    Arguments:
        $1 - List of available models
        $2 - Name of the model to check

`connect_to_ollama`
Connects to the Ollama server and runs a specified model, optionally pulling the model if it is not available locally.

    Arguments:
        $1 - Name of the model to run

`run_ollama`
Checks if the Ollama server is running and starts it if necessary, then calls `connect_to_ollama` to run a specified model.

    Arguments:
        $1 - Name of the model to run (optional, defaults to xcvrys-dsv2:latest)

## Alias

The script defines an alias ai for the run_ollama function to simplify running models.

```bash
    # Usage
    ai model_name
    # or for default model
    ai
```

If no model name is provided, it defaults to `xcvrys-dsv2:latest`.
