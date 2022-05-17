#!/bin/bash

PUBLIC_KEY=F392B1234F028594D92B2EEFFF9BC62FEBB9B68E

if [[ ! -f ~/.vault-password.gpg ]]; then
    # Import public key from repository if not yet imported
    if [[ ! $(gpg -k ${PUBLIC_KEY}) ]]; then
        gpg --keyserver keys.openpgp.org --recv-keys ${PUBLIC_KEY}
        echo "gpg key has been imported"
    fi

    # Enter vault password and encrypt using gpg if not already present
    read -rsp "Please enter the vault-password:" VAULT_PASS < /dev/tty
    echo -e "\n"

     echo -n "${VAULT_PASS}" | gpg --batch --encrypt -o ~/.vault-password.gpg -r ${PUBLIC_KEY}
    chmod 600 ~/.vault-password.gpg
fi

