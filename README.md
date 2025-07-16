# onprem-devops-project



# Fehlerbehebung: Permission Denied beim Erstellen einer libvirt-VM mit Terraform auf Ubuntu

## Problemstellung

Beim Versuch, mit Terraform und dem libvirt-Provider eine VM zu erstellen, tritt folgender Fehler auf:

Error: error creating libvirt domain: internal error: process exited while connecting to monitor:
qemu-system-x86_64: -drive file=/var/lib/libvirt/images/test.qcow2,format=qcow2,if=none,id=drive-virtio-disk0:
Could not open '/var/lib/libvirt/images/test.qcow2': Permission denied


Dieser Fehler zeigt, dass QEMU nicht auf die `.qcow2`-Datei zugreifen kann, was meist an fehlenden Zugriffsrechten oder an AppArmor-Sicherheitsrichtlinien liegt.

---

## Zusammenhang mit Terraform

- Terraform wird mit einem libvirt-Provider konfiguriert, um die VM zu definieren und zu starten.
- Die VM benutzt eine `.qcow2`-Image-Datei, die Terraform bzw. libvirt in `/var/lib/libvirt/images/` erwartet.
- QEMU benötigt ausreichende Rechte, um die Image-Datei zu öffnen.
- Fehlende Rechte oder restriktive AppArmor-Profile verhindern den Zugriff, was zu diesem Fehler führt.

---

## Schritt-für-Schritt Lösung

### 1. AppArmor prüfen und temporär in `complain` Modus versetzen

AppArmor kann den Zugriff blockieren. Um dies zu umgehen:

```bash
# Profil herausfinden (Beispiel aus Logs):
sudo aa-complain /etc/apparmor.d/libvirt-32703299-dd46-4e27-9bb9-c1a22aa0ce34

# AppArmor Dienst neu starten (optional)
sudo systemctl restart apparmor

2. Rechte der Image-Datei anpassen

QEMU läuft typischerweise unter Benutzer libvirt-qemu. Stelle sicher, dass dieser Nutzer Zugriff hat:

sudo chown libvirt-qemu:kvm /var/lib/libvirt/images/test.qcow2
sudo chmod 644 /var/lib/libvirt/images/test.qcow2

3. Terraform VM Definition prüfen (Beispiel)

resource "libvirt_domain" "vm" {
  name   = "test-vm"
  memory = "1024"
  vcpu   = 1

  disk {
    volume_id = libvirt_volume.test_vol.id
  }

  network_interface {
    network_name = "default"
  }
}

4. VM mit Terraform starten

terraform apply

Dauerhafte AppArmor-Anpassung (optional)

Um den Fehler dauerhaft zu vermeiden, füge die .qcow2-Datei zum lokalen AppArmor-Profil hinzu:

sudo nano /etc/apparmor.d/local/usr.sbin.libvirtd

Füge hinzu:

/var/lib/libvirt/images/test.qcow2 rw,

Profil neu laden:

sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.libvirtd

Zusammenfassung
Ursache	Lösung
AppArmor blockiert	Profil in complain-Modus versetzen
Dateiberechtigungen	Besitzer und Rechte anpassen
Terraform-Config	Pfad zur Image-Datei prüfen
Weiterführende Tipps

    Logs mit dmesg | grep apparmor oder journalctl auswerten.

    Prüfe, unter welchem Benutzer QEMU läuft (ps aux | grep qemu).

    Nutze sudo aa-status, um AppArmor-Profile und deren Status zu prüfen.

Kontakt

Falls das Problem weiter besteht, bitte Logs und Terraform-Konfiguration bereitstellen.
