# My NixOS Configuration

## Notes

To update flake inputs:
```
cd /etc/nixos
sudo nix flake update
```

To rebuild system:
```
sudo nixos-rebuild switch
```

To rebuild system and update packages:
```
sudo nixos-rebuild switch --upgrade
```

To remove all old system generations:
```
nix-collect-garbage
nix-collect-garbage -d
sudo nix-collect-garbage
sudo nix-collect-garbage -d
```

