#!/bin/bash

apply () {
    cd vpc
    terraform apply -auto-approve
    cd ../subnet
    terraform apply -auto-approve
   
} 

destroy () {
    cd subnet
    terraform destroy -auto-approve
    cd ../vpc
    terraform destroy -auto-approve
   
}

init () {
    cd vpc
    terraform init
    cd ../subnet
    terraform init
}

case $1 in
    apply)
        apply
        ;;
    destroy)
        destroy
        ;;
    init)
        init
        ;;
        
    *)
        echo "Usage: $0 {apply|destroy}"
        exit 1
        ;;
esac