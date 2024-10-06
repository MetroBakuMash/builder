#!/bin/bash

# Record the start time of the script
start_time=$(date +%s)

# Get the current date
current_date=$(date +%d-%m-%Y)

# Error handling with trap command
trap 'echo "An error occurred. Time taken: $(( $(date +%s) - start_time )) seconds."; exit 1' ERR

echo 'MetroBakuMash builder'

echo "Please select a branch:"
echo "1. green STATUS: WIP"
echo "2. purple STATUS: WIP"
echo "3. light-green STATUS: OK"

read -p "Your choice (1/2/3): " branch_choice

case $branch_choice in
    1)
        branch_name="green"
        ;;
    2)
        branch_name="purple"
        ;;
    3)
        branch_name="light-green"
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

echo "$branch_name branch selected."

# Create necessary directories
mkdir -p out/railway out/train

# Cloning process
echo 'Cloning Route...'
git clone https://github.com/MetroBakuMash/route -b "$branch_name" out/railway/route

echo 'Cloning Objects...'
git clone https://github.com/MetroBakuMash/object -b "$branch_name" out/railway/object

echo 'Cloning Sounds...'
git clone https://github.com/MetroBakuMash/sound -b "$branch_name" out/railway/sound

echo 'Cloning Trains...'
git clone https://github.com/MetroBakuMash/train -b "$branch_name" out/train

echo "All cloning operations completed."

# Add routes for the green branch
if [[ "$branch_name" == "green" ]]; then
    green_routes=(
        "Hazi Aslanov - Darnagul 81-765B.csv"
        "Darnagul - Hazi Aslanov 81-765B.csv"
        "Hazi Aslanov - Darnagul 81-717M 1.csv"
        "Darnagul - Hazi Aslanov 81-717M 1.csv"
        "Hazi Aslanov - Darnagul 81-717M 2.csv"
        "Darnagul - Hazi Aslanov 81-717M 2.csv"
        "Hazi Aslanov - Darnagul 81-717M 3.csv"
        "Darnagul - Hazi Aslanov 81-717M 3.csv"
        "Hazi Aslanov - Darnagul 81-717 1.csv"
        "Darnagul - Hazi Aslanov 81-717 1.csv"
        "Hazi Aslanov - Darnagul 81-717 2.csv"
        "Darnagul - Hazi Aslanov 81-717 2.csv"
        "Hazi Aslanov - Darnagul 81-717 2-2-2.csv"
        "Darnagul - Hazi Aslanov 81-717 2-2-2.csv"
    )

    for route in "${green_routes[@]}"
    do
        echo "$route" >> routes.txt
    done

    echo 'Additional routes for green branch added to routes.txt'

# Add routes for the light-green branch
elif [[ "$branch_name" == "light-green" ]]; then
    routes_txt=(
        "Jafar Jabbarli - Khatai 81-717 1.csv"
        "Khatai - Jafar Jabbarli 81-717 1.csv"
        "Jafar Jabbarli - Khatai 81-717 2.csv"
        "Khatai - Jafar Jabbarli 81-717 2.csv"
        "Jafar Jabbarli - Khatai 81-717M 1.csv"
        "Khatai - Jafar Jabbarli 81-717M 1.csv"
        "Jafar Jabbarli - Khatai 81-717M 2.csv"
        "Khatai - Jafar Jabbarli 81-717M 2.csv"
        "Jafar Jabbarli - Khatai 81-717M 3.csv"
        "Khatai - Jafar Jabbarli 81-717M 3.csv"
    )

    for route in "${routes_txt[@]}"
    do
        echo "$route" >> routes.txt
    done

    echo 'Routes for light-green branch added to routes.txt'
fi

# Create the zip file
zip_file="MetroBakuMash-${branch_name}-${current_date}.zip"
echo "Zipping the directory: $zip_file"
zip -r "$zip_file" out/

echo "Zipping completed: $zip_file"

# Display completion message
runtime=$(( $(date +%s) - start_time ))
echo "#### $zip_file created. Time taken: $runtime seconds. ######"
