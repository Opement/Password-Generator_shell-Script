#!/bin/bash

# Author_Opement

check_password_strength() {
    local password=$1
    local length=${#password}
    
    if [[ $length -lt 12 ]]; then
        echo "Password must be at least 12 characters long."
        return 1
    fi
    
    if ! [[ $password =~ [A-Z] ]]; then
        echo "Password must include at least one(1) uppercase letter."
        return 1
    fi
    
    if ! [[ $password =~ [a-z] ]]; then
        echo "Password must include at least one(1) lowercase letter."
        return 1
    fi
    
    if ! [[ $password =~ [0-9] ]]; then
        echo "Password must include at least one(1) number."
        return 1
    fi
    
    if ! [[ $password =~ [[:punct:]] ]]; then
        echo "Password must include at least one(1) special character."
        return 1
    fi
    
    return 0
}
while true; do
    read -s -p "Enter your password: " password
    echo
    check_password_strength "$password"
    if [ $? -eq 0 ]; then
        break
    else
        echo "Please try again."
    fi
done

# Generate the SHA-512 hash
hashed_password=$(echo $password | mkpasswd -m sha-512 -s)
echo "SHA-512 Hash: $hashed_password"
