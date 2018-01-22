// from Mastering Bitcoin, 2nd Edition, p. 69
// slightly modified to work with latest version of libbitcoin

#include <iostream>
#include <bitcoin/bitcoin.hpp>

int main() {
    // Private secret key
    bc::ec_secret secret;
    bool decode_secret_success = bc::decode_base16(
            secret,
            "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
    );
    assert(decode_secret_success);

    // Get public key
    bc::ec_compressed public_key;
    bool public_key_success = bc::secret_to_public(public_key, secret);
    assert(public_key_success);
    std::cout << "Public key: " << bc::encode_base16(public_key) << std::endl;

    const bc::short_hash hash = bc::bitcoin_short_hash(public_key);

    bc::data_chunk unencoded_address;
    // Reserve 25 bytes
    //   [ version:1  ]
    //   [ hash:20    ]
    //   [ checksum:4 ]
    unencoded_address.reserve(25);
    // Version byte, 0 is normal BTC address (P2PKH)
    unencoded_address.push_back(0);
    // Hash data
    bc::extend_data(unencoded_address, hash);
    // Checksum is computed by hashing data, and adding 4 bytes from hash
    bc::append_checksum(unencoded_address);
    // Finally we must encode the result in Bitcoin's base58 encoding
    assert(unencoded_address.size() == 25);
    const std::string address = bc::encode_base58(unencoded_address);

    std::cout << "Address: " << address << std::endl;

    return 0;
}