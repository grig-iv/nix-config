## Xtal

1. Disko and nixos-install
```
> curl -L https://raw.githubusercontent.com/grig-iv/nix-config/refs/heads/main/scripts/xtal-install.sh -o /tpm/xtal-install.sh
> chmod +x /tpm/xtal-install.sh
> bash /tpm/xtal-install.sh
```

2. Secrets install
```
> mkdir /mnt/var/lib/sops/
> vi /mnt/var/lib/sops/key
> nixos-install -flake /mnt/etc/nixos#xtal
```
