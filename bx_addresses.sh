#!/usr/bin/env bash

# Some examples of libbitcoin-explorer
# Inspired by Mastering Bitcoin, 2nd Edition, p. 71-72

# Pass in a seed, or let bx generate one
SEED=${1:-$(bx seed)}
echo "seed:" $SEED

# Generate new private key
PRIVATE_KEY=$(bx ec-new $SEED)
echo "private key:" $PRIVATE_KEY

# Convert private key to WIF, compressed and uncompressed
PRIVATE_KEY_WIF=$(bx ec-to-wif --uncompressed $PRIVATE_KEY)
PRIVATE_KEY_WIF_COMPRESSED=$(bx ec-to-wif $PRIVATE_KEY)
echo "private key WIF:" $PRIVATE_KEY_WIF
echo "private key WIF-compressed:" $PRIVATE_KEY_WIF_COMPRESSED

# Derive public key, compressed and uncompressed
PUBLIC_KEY=$(bx ec-to-public --uncompressed $PRIVATE_KEY)
PUBLIC_KEY_COMPRESSED=$(bx ec-to-public $PRIVATE_KEY)
echo "public key:" $PUBLIC_KEY
echo "public key (compressed):" $PUBLIC_KEY_COMPRESSED

# Derive address from public keys, compressed and uncompressed
ADDRESS=$(bx ec-to-address $PUBLIC_KEY)
ADDRESS_COMPRESSED=$(bx ec-to-address $PUBLIC_KEY_COMPRESSED)
echo "address:" $ADDRESS
echo "address (compressed):" $ADDRESS_COMPRESSED

# Convert WIF private keys back to base 16
echo "wif-to-ec:" $(bx wif-to-ec $PRIVATE_KEY_WIF)
echo "wif-to-ec (compressed):" $(bx wif-to-ec $PRIVATE_KEY_WIF_COMPRESSED)

# Encode private key in Base58Check
# Should be same as uncompressed WIF
PRIVATE_KEY_BASE58CHECK=$(bx base58check-encode --version 128 $PRIVATE_KEY)
echo "base58check-encode:" $PRIVATE_KEY_BASE58CHECK

# Decode Base58Check private key
echo "base58check-decode:"
bx base58check-decode $PRIVATE_KEY_BASE58CHECK

# Encode private key in Base58Check compressed
# Should be same as compressed WIF
PRIVATE_KEY_BASE58CHECK_COMPRESSED=$(bx base58check-encode --version 128 ${PRIVATE_KEY}01)
echo "base58check-encode (compressed):" $PRIVATE_KEY_BASE58CHECK_COMPRESSED

# Decode Base58Check compressed private key
echo "base58check-decode (compressed):"
bx base58check-decode $PRIVATE_KEY_BASE58CHECK_COMPRESSED
