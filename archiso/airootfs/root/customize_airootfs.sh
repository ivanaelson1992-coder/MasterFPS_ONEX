#!/bin/bash
set -e

ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "masterfps" > /etc/hostname

useradd -m -G wheel,video,audio,input -s /bin/bash gamer
echo "gamer:gamer" | chpasswd
echo "root:gamer" | chpasswd
echo "gamer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/gamer
chmod 0440 /etc/sudoers.d/gamer

mkdir -p /etc/modules-load.d /etc/lightdm/lightdm.conf.d /usr/share/themes /usr/share/backgrounds /usr/local/bin /home/gamer/Desktop /usr/share/applications
echo "ntsync" > /etc/modules-load.d/ntsync.conf

cat << 'EOL' > /etc/lightdm/lightdm.conf.d/10-autologin.conf
[Seat:*]
autologin-user=gamer
autologin-user-timeout=0
user-session=xfce
EOL

# Wallpaper Fenix nativo em Python puro
python3 - << 'EOP'
import zlib, struct
W, H = 1920, 1080
raw = bytearray()
for y in range(H):
    raw.append(0)
    raw.extend(bytes([int(15+(y/H)*45), int(10+(y/H)*10), int(20+(y/H)*25)]) * W)
def chunk(t, d): return struct.pack("!I", len(d)) + t + d + struct.pack("!I", zlib.crc32(t + d) & 0xffffffff)
png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack("!IIBBBBB", W, H, 8, 2, 0, 0, 0)) + chunk(b"IDAT", zlib.compress(bytes(raw), 6)) + chunk(b"IEND", b"")
open("/usr/share/backgrounds/masterfps-fenix.png", "wb").write(png)
EOP

# Painel Master Gamer
cat << 'EOG' > /usr/local/bin/master-gamer
#!/usr/bin/env python3
import sys, os, psutil
from PyQt6.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QLabel
from PyQt6.QtCore import QTimer, Qt

class MasterGamer(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Master Gamer - Painel MasterFPS")
        self.setFixedSize(380, 300)
        self.setStyleSheet("QWidget{background:#12141a;color:#fff;font-family:sans-serif;}QPushButton{background:#d9381e;padding:10px;border-radius:6px;font-weight:bold;}QPushButton:hover{background:#ff4d2e;}")
        l = QVBoxLayout()
        self.s = QLabel("CPU: 0% | RAM: 0%")
        self.s.setAlignment(Qt.AlignmentFlag.AlignCenter)
        l.addWidget(self.s)
        b1 = QPushButton("Energia Maxima (CPU Performance)")
        b1.clicked.connect(lambda: os.system("echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"))
        b2 = QPushButton("Modo Turbo FPS (Limpar RAM)")
        b2.clicked.connect(lambda: os.system("sync && echo 3 | sudo tee /proc/sys/vm/drop_caches"))
        b3 = QPushButton("Zero Input Lag (Compositor OFF + BBR)")
        b3.clicked.connect(lambda: os.system("xfconf-query -c xfwm4 -p /general/use_compositing -s false && sudo sysctl -w net.ipv4.tcp_congestion_control=bbr"))
        for b in (b1, b2, b3): l.addWidget(b)
        self.setLayout(l)
        self.t = QTimer()
        self.t.timeout.connect(lambda: self.s.setText(f"CPU: {psutil.cpu_percent()}% | RAM: {psutil.virtual_memory().percent}%"))
        self.t.start(1000)

app = QApplication(sys.argv)
w = MasterGamer()
w.show()
sys.exit(app.exec())
EOG
chmod +x /usr/local/bin/master-gamer

cat << 'EOD' > /usr/share/applications/master-gamer.desktop
[Desktop Entry]
Name=Master Gamer
Exec=/usr/local/bin/master-gamer
Icon=utilities-system-monitor
Terminal=false
Type=Application
EOD
cp /usr/share/applications/master-gamer.desktop /home/gamer/Desktop/
chmod +x /home/gamer/Desktop/master-gamer.desktop

git clone --depth=1 https://github.com /usr/share/themes/Windows-7 || true

systemctl enable lightdm NetworkManager
chown -R gamer:gamer /home/gamer