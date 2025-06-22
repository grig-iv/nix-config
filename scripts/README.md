## Xtal

```
# 1. add user to sudoers
su -
vi /etc/sudoers

# 2. install nix (then restart shell)
sudo apt install curl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
exit

# 3. add flakes feature
echo "experimental-features = nix-command flakes" >> sudo /etc/nix/nix.conf

# 4. add key.age
sudo vi /var/lib/key.age

# 5. install home-manager
nix run home-manager/master -- switch --flake github:grig-iv/nix-config#$(whoami)@$(hostname)
```
