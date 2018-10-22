#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

if [ "$#" -lt 1 ]; then
    echo "No project type defined (either typo3, neos or git)"
    exit 1
fi

#if app dir exists then backup it with timestamp
[ ! -d "$CODE_DIR" ] || mv "$CODE_DIR" "$CODE_DIR".$(date +%Y%m%d%H%M%S);

mkdir -p -- "$CODE_DIR/"
chmod 777 "$CODE_DIR/"

case "$1" in
    ###################################
    ## TYPO3 CMS
    ###################################
    "typo3")
        execInDir "$CODE_DIR" "docker run --rm --env COMPOSER_CACHE_DIR=/tmp --user $(id -u):$(id -g) -v \$(pwd):/app composer:latest create-project typo3/cms-base-distribution /app"
        execInDir "$CODE_DIR" "touch web/FIRST_INSTALL"
        ;;

    ###################################
    ## TYPO3 NEOS
    ###################################
    "neos")
        execInDir "$CODE_DIR" "docker run --rm --env COMPOSER_CACHE_DIR=/tmp --user $(id -u):$(id -g) -v \$(pwd):/app composer:latest create-project neos/neos-base-distribution /app"
        echo "\nNOTE: You probably want to change the WEB_DOCUMENT_ROOT env in your etc/base.env to '/app/Web/' and run 'docker-composer up -d app' to populate the change."
        ;;

    ###################################
    ## GIT
    ###################################
    "git")
        if [ "$#" -lt 2 ]; then
            echo "Missing git url"
            exit 1
        fi
        git clone --recursive "$2" "$CODE_DIR"
        ;;
esac

touch -- "$CODE_DIR/.gitkeep"
