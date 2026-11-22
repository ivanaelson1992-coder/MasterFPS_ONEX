# MasterFPS Gaming OS

ISO bootável otimizada para jogos no Linux, construída com **mkosi** e **GitHub Actions**.

## 🎮 O que inclui

| Componente | Versão/Configuração |
|------------|---------------------|
| **Kernel** | CachyOS (BORE scheduler, LTO, -O3, x86-64-v3/v4) |
| **Init** | systemd (boot paralelo) |
| **GPU Drivers** | AMD RADV, Intel ANV, NVIDIA 550+ DKMS |
| **Gaming** | Steam (Flatpak), Proton-GE, Wine-GE, Gamescope, MangoHud, Gamemode, DXVK/VKD3D |
| **Navegadores** | Firefox, Chrome, Edge (Flatpak) |
| **Apps** | Discord, OBS, Lutris, Heroic, Bottles |
| **Otimizações** | zram (zstd), ananicy-cpp, tuned, transparent_hugepage=always, mitigations=off |
| **Boot** | systemd-boot (UEFI) + GRUB (BIOS) |

## 🚀 Build Automático (GitHub Actions)

O build roda **na nuvem** (GitHub Actions) — você não precisa de hardware potente.

### 1. Crie o repositório no GitHub
- Acesse [github.com/new](https://github.com/new)
- Nome: `MasterFPS`
- **Público** (para Actions grátis ilimitado)
- **NÃO** inicialize com README/License/gitignore

### 2. Suba este projeto
```bash
git init
git add .
git commit -m "MasterFPS: mkosi config + GitHub Actions build"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/MasterFPS.git
git push -u origin main
```

### 3. Dispare o build (escolha uma opção)

**Opção A: Via Tag (cria Release automático)**
```bash
git tag v1.0.0
git push origin v1.0.0
```

**Opção B: Manual na interface**
- Vá na aba **Actions** → **Build MasterFPS ISO** → **Run workflow**

### 4. Baixe a ISO
- Aguarde ~2-3 horas
- Vá em **Releases** → `MasterFPS v1.0.0`
- Baixe todas as partes `MasterFPS.iso.part-*` e o `MasterFPS.sha256`

## 📀 Como usar a ISO

```bash
# 1. Junte as partes (se splitado)
cat MasterFPS.iso.part-* > MasterFPS.iso

# 2. Verifique integridade
sha256sum -c MasterFPS.sha256

# 3. Grave no USB (substitua sdX pelo seu dispositivo)
sudo dd if=MasterFPS.iso of=/dev/sdX bs=4M status=progress conv=fsync

# 4. Boot no PC → Login: gaming / gaming
```

## 🖥️ Build Local (opcional)

Se quiser buildar na sua máquina (precisa root, 50+ GB, 2-4h):

```bash
# Arch/Manjaro
sudo pacman -S mkosi

# Fedora
sudo dnf install mkosi

# Ubuntu 24.04+
sudo apt install mkosi

# Build
sudo mkosi --force --output=MasterFPS.raw --format=raw
```

## 👤 Primeiro Boot

1. Login: `gaming` / `gaming`
2. `firstboot.service` roda: atualiza sistema, configura locale/teclado, reboot
3. Entra no **Gamescope** (modo Steam Deck) ou TTY
4. Steam abre automaticamente → loga → joga `.exe` via Proton-GE

## ⚠️ Limitações Conhecidas

| Item | Status |
|------|--------|
| Anti-cheat kernel (Valorant, Vanguard, BattlEye, EAC não-Proton) | ❌ Não funciona |
| Adobe Creative Cloud | ❌ Use DaVinci Resolve (nativo) |
| Xbox Game Pass PC / Windows Store | ⚠️ Via browser (xbox.com/play) ou GeForce Now |
| Drivers impressora/scanner específicos | ⚠️ Verifique suporte Linux |

## 📄 Licença

MIT — Use, modifique, distribua livremente.

---

**Feito com mkosi + GitHub Actions** — Build reproduzível, declarativo, na nuvem.