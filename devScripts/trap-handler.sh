#!/usr/bin/env bash 

trap 'ctrlC' INT
trap 'theEnd $?' EXIT

ctrlC() {
    ./print.sh "You canceled beleyenv!  This may leave you in a weird state.\n\
Since belyenv is idempotent, you can most likely just re-run beleyenv"

    exit 1
}

theEnd() {
    if [[ "$1" != "0" ]]; then
        ./print.sh 'Beleyenv install failed!'

        if command -v notify-send &> /dev/null; then
            notify-send -a 'beleyenv' 'beleyenv install failed!' 'You are probally now very sad.'
        fi
    else
        ./print.sh 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'

        if command -v notify-send &> /dev/null; then
            notify-send -a 'beleyenv' 'beleyenv install finished!' 'Have fun!'
        fi
    fi
}