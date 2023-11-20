#!/bin/zsh
# Encrypt and Descrypt a file using KMS
source ./variables.zsh

# delete the tmp files
rm -f ExampleSecretFile.base64
rm -f ExampleSecretFileEncrypted
rm -f ExampleFileDecrypted.base64
rm -f ExampleFileDecrypted.txt

# Encrypt a file using the key
aws kms encrypt --key-id ${KMS_KEY_ALIAS} --plaintext fileb://ExampleSecretFile.txt --output text --query CiphertextBlob --region ${AWS_REGION} >> ExampleSecretFile.base64

# base64 decode for Linux or Mac OS
cat ExampleSecretFile.base64 | base64 --decode > ExampleSecretFileEncrypted


# Decrypt a file using the key
aws kms decrypt  --ciphertext-blob fileb://ExampleSecretFileEncrypted --region ${AWS_REGION}  --output text --query Plaintext > ExampleFileDecrypted.base64 

# base64 decode for Linux or Mac OS
# this is the original encrypted file
cat ExampleFileDecrypted.base64 | base64 --decode > ExampleFileDecrypted.txt

if [[ $(sha256sum ExampleSecretFile.txt | awk '{print $1}') == $(sha256sum ExampleFileDecrypted.txt | awk '{print $1}') ]]; then
    echo "Success! Encrypted and Decrypted Files are the same."
else
    echo "Fail! Encrypted and Decrypted Files are different."
fi
