RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;32m'
CLEAR="\033[0m"

get_ollama_models() {
    ollama list
}

check_in_models(){
    local models_list=$1
    local model_name=$2

    if echo -e "$models_list" | grep -q "$model_name"; then
        return 0
    else
        return 1
    fi
}

connect_to_ollama() {
    echo -e "${BLUE}Connecting to Ollama server...${CLEAR}"
    local model_name=$1

    local models=$(get_ollama_models)

    if check_in_models "$models" "$model_name"; then
        echo -e "${BLUE}Running model $model_name${CLEAR}"
        ollama run $model_name
    else
        echo -e "${RED}Model $model_name not found. Do you want to try to pull it? (y/N)${CLEAR}"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Pulling model $model_name...${CLEAR}"
            ollama pull $model_name
            models=$(get_ollama_models)
            if check_in_models "$models" "$model_name"; then
                echo -e "${BLUE}Model $model_name pulled successfully. Running it now.${CLEAR}"
                ollama run $model_name
            else
                echo -e "${RED}Failed to pull model $model_name.${CLEAR}"
            fi
        else
            echo -e "${RED}Model $model_name not pulled. Exiting.${CLEAR}"
        fi
    fi
}

run_ollama() {
    SERVER_IP="localhost"
    PORT="11434"
    MODEL_NAME=${1:-"xcvrys-dsv2:latest"}

    if nc -z $SERVER_IP $PORT; then
        echo -e "${BLUE}Ollama server is running.${CLEAR}"
        connect_to_ollama $MODEL_NAME
    else
        echo -e "${RED}Ollama server is not running.${CLEAR}"
        echo -e "${YELLOW}Starting Ollama server...${CLEAR}"
        ollama serve > /dev/null 2>&1 &

        # Wait for the server to start
        while ! nc -z $SERVER_IP $PORT; do
            echo -e "${BLUE}Waiting for Ollama server to start...${CLEAR}"
            sleep 1
        done

        echo -e "${YELLOW}Ollama server started.${CLEAR}"
        connect_to_ollama $MODEL_NAME
    fi
}

alias ai="run_ollama"
