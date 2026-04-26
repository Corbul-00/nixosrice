{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "hashdating";

  # Dependências em tempo de execução que o script precisa
  runtimeInputs = [ pkgs.openssl pkgs.coreutils ];

  # O conteúdo do seu script bash
  text = ''
    # Function to display the menu
    show_menu() {
        echo "Select the hash algorithm:"
        echo "1) SHA-256"
        echo "2) SHA-512"
        echo "3) SHA-1"
        echo "4) SHA-384"
        echo "5) SHA-224"
        echo "6) SHA-512/224"
        echo "7) SHA-512-256"
        echo "8) MD5"
    }

    # Function to hash the text
    hash_text() {
        local text=$1
        local algorithm=$2
        case $algorithm in
            1) echo -n "$text" | openssl dgst -sha256 ;;
            2) echo -n "$text" | openssl dgst -sha512 ;;
            3) echo -n "$text" | openssl dgst -sha1 ;;
            4) echo -n "$text" | openssl dgst -sha384 ;;
            5) echo -n "$text" | openssl dgst -sha224 ;;
            6) echo -n "$text" | openssl dgst -sha512-224 ;;
            7) echo -n "$text" | openssl dgst -sha512-256 ;;
            8) echo -n "$text" | openssl dgst -md5 ;;
            *) echo "Invalid choice"; exit 1 ;;
        esac
    }

    # Main script
    echo "Enter the text to hash:"
    read -r text
    show_menu
    read -r -p "Enter your choice (1-8): " choice
    hash_text "$text" "$choice"
  '';
}
