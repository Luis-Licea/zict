#!/usr/bin/env bash

_zict() {
    local -r current="${COMP_WORDS[COMP_CWORD]}"
    local -a options
    if ((COMP_CWORD == 1)); then
        if [[ "$current" = -* ]]; then
            options=(
                --help
                --download
                --search
                --en
                --ru
            )
        else
            options=(
                download
                en
                help
                ru
                search
            )
        fi
        mapfile -t COMPREPLY < <(compgen -W "${options[*]}" -- "$current")
    else
        local -a dictionaries=(
            en
            ru
        )
        local -r option="${COMP_WORDS[1]}"
        case "$option" in
        -d | --download | download)
            # Do not make more suggestions: a suggestion has been selected.
            ((COMP_CWORD >= 3)) && return 0
            mapfile -t COMPREPLY < <(compgen -W "${dictionaries[*]}" -- "$current")
            ;;
        -s | --search | search)
            ((COMP_CWORD >= 3)) && return 0
            mapfile -t COMPREPLY < <(compgen -W "${dictionaries[*]}" -- "$current")
            ;;
        --ru | ru | --en | en)
            # Convert result into an array.
            mapfile -t words < <(zict --search "${option#--}" "${COMP_WORDS[@]:2}")
            # Replace every space with a backslash and a space.
            # For example: "a short string" becomes "a\ short\ string".
            mapfile -t COMPREPLY < <(compgen -W "${words[*]// /\\ }" -- "$current")
            ;;
        esac
    fi
}

complete -o nospace -F _zict zict
