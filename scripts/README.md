## Xtal

1. Disko and nixos-install
```
> curl -L https://raw.githubusercontent.com/grig-iv/nix-config/refs/heads/main/scripts/xtal-install.sh -o /tpm/xtal-install.sh
> chmod +x /tpm/xtal-install.sh
> bash /tpm/xtal-install.sh
```

2. Install secrets
```
> mkdir /mnt/var/lib/sops/
> vi /mnt/var/lib/sops/key
> nixos-install --flake /mnt/etc/nixos#xtal
```

3. In brand new nixos
```
> sudo passwd grig

> sudo chown -R grig /etc/nixos
> cd /etc/nixos
> git remote set-url git@github.com:grig-iv/nix-config.git

> git clone https://github.com/grig-iv/nvim.git ~/.config/nvim
> cd ~/.config/nvim
> git remote set-url git@github.com:grig-iv/nvim.git
```
