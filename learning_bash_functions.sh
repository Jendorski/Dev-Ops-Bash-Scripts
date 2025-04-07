#Article for all: https://medium.com/devsecops-community/day-6-automating-tasks-with-bash-scripts-part-2-ae38ae7b055a

#1. Conditionals & error handling
#! /bin/bash

set -x #Helps with debugging to print each command before execution

filename="data.txt"
if [[ -f $filename ]]; then
    echo "Reading $filename"
    cat "$filename"
else
    echo "Error: $filename not found"
    exit 1
fi
#1. Conditionals & error handling

#2. Loop & Iterate over data
#! /bin/bash
set -x #Helps with debugging to print each command before execution

count=0
while IFS= read -r line; do
    echo "Line $count: $line"
    ((count++))
done < "input.txt"

#2. Loop & Iterate over data

#3. Schedule scripts with cron

crontab -e

#Example cron
0 2 * * * /path/to/your/script.sh

#3. Schedule scripts with cron

#4. Error handling and exit codes
#! /bin/bash
trap 'echo "An error occurred... Exiting: "; exit 1;' ERR
#Example function that may fail
function risky_operation(){
    #Simulating an error
    false
}  
risky_operation

#4. Error handling and exit codes

#5. Input validation
#! /bin/bash

set -x

if [[ $# -ne 1 ]]; then  
    echo "Usage: $0 <filename>"
    exit 1
fi
filename=$1
if [[ ! -f $filename ]]; then
    echo "Error: $filename does not exist"
    exit 1
fi
echo "Processing $filename..."

#5. Input validation

#6. Process Management
#! /bin/bash

set -x

function long_runnng_process() {
    sleep 5
    echo "Process finished"
}

long_runnng_process & 
pid=$!
echo "Waiting for process $pid to complete..."
wait $pid
echo "Done!"

#6. Process Management

#7. Regular Expressions (Regex) & String Manipulation
#! /bin/bash
input= "User: Alice, Email: alice@example.com"
if [[ $input =~ User:\ ([^,]+),\ Email:\ ([^ ]+) ]]; then
    user=${BASH_REMATCH[1]}
    email=${BASH_REMATCH[2]}
    echo "Extracted user: $user, Email: $email"
else
    echo "No match found."
fi

#7. Regular Expressions (Regex) & String Manipulation

#8. Associative Arrays
#! /bin/bash

set -x

declare -A colors
colors[red]="#FF0000"
colors[green]="#00FF00"
colors[blue]="#0000FF"
for color in "${!colors[@]}"; do
    echo "$color: ${colors[$color]}"
done

#8. Associative Arrays

#9. Using External tools
#! /bin/bash

set -x
set -e #Another debugging technique, you can also use shellcheck


json='{"name": "Alice", "age": 30}'
name=$(echo "$json" | jq -r '.name')
age=$(echo "json" | jq -r '.age')
echo "Name: $name, Age: $age"

#9. Using External tools

#10. Creating Modular Scripts

#helper.sh
function greet() {
    echo "Hello, $1!"
}

#main.sh
#! /bin/bash
source ./helper..sh
greet "Alice"

#10. Creating Modular Scripts