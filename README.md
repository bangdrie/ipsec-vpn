# IPsec VPN Server Auto Setup Scripts

Buat sendiri IPsec VPN server dalam beberapa menit, dengan IPsec/L2TP dan Cisco IPsec di Ubuntu, Debian dan CentOS. Semua yang Kamu butuhkan hanya mengisi VPN credentials, dan biarkan script ini bekerja.

IPsec VPN men enkripsi jaringan, sehingga tidak ada seorang pun antara Kamu dan server VPN yang dapat mengintip data Kamu saat dikirimkan melalui Internet. Ini sangat berguna saat menggunakan jaringan tidak aman, contoh. di cafe, hotel, bandara.

Kita menggunakan <a href="https://libreswan.org/" target="_blank">Libreswan</a> sebagai IPsec server, dan <a href="https://github.com/xelerance/xl2tpd" target="_blank">xl2tpd</a> sebagai L2TP provider.


#### Table of Contents

- [Langkah pertama](#langkah-pertama)
- [Fitur](#fitur)
- [Persyaratan](#persyaratan)
- [Instalasi](#instalasi)
- [Langkah selanjutnya](#langkah-selanjutnya)
- [Catatan penting](#catatan-penting)
- [Upgrade Libreswan](#upgrade-libreswan)
- [Uninstall](#uninstall)
- [License](#license)

## Langkah pertama

Pertama, Siapkan Linux server[\*](#quick-start-note) dalam fresh install (kosong) pada Ubuntu LTS, Debian or CentOS.

Gunakan satu baris ini untuk memulai setup IPsec VPN server:

```bash
wget https://bit.ly/ipsec-vpnsetup -O vpnsetup.sh && sudo sh vpnsetup.sh
```

Jika menggunakan CentOS, ganti link dengan `https://bit.ly/ipsec-vpnsetup-centos`.

Detail login VPN kamu akan random, dan ditampilkan saat selesai.

Untuk konfirgurasi instalasi lainnya dan cara setup VPN clients, baca dibawah.


[\*](#quick-start-note)Server dedicated atau virtual private server (VPS). OpenVZ VPS tidak didukung.

## Fitur

- Lebih cepat `IPsec/XAuth ("Cisco IPsec")` mode disupport
- Full otomatis setup IPsec VPN server, tidak perlu input user
- Traffic VPN dienkapsulasi dengan UDP - tidak membutuhkan protokol ESP
- Bisa langsung digunakan sebagai "user-data" untuk instance Amazon EC2
- Termasuk optimisasi `sysctl.conf` untuk memperbaiki performa
- Sudah dicoba dengan Ubuntu 20.04/18.04/16.04, Debian 10/9 dan CentOS 8/7/6

## Persyaratan

<a href="https://aws.amazon.com/ec2/" target="_blank">Amazon EC2</a> instance yang baru dibuat, dari salah satu images dibawah:
- <a href="https://cloud-images.ubuntu.com/locator/" target="_blank">Ubuntu 20.04 (Focal), 18.04 (Bionic) or 16.04 (Xenial)</a>
- <a href="https://wiki.debian.org/Cloud/AmazonEC2Image" target="_blank">Debian 10 (Buster)</a>[\*](#debian-10-note)<a href="https://wiki.debian.org/Cloud/AmazonEC2Image" target="_blank"> or 9 (Stretch)</a>
- <a href="https://wiki.centos.org/Cloud/AWS" target="_blank">CentOS 8 (x86_64)</a>
- <a href="https://aws.amazon.com/marketplace/pp/B00O7WM7QW" target="_blank">CentOS 7 (x86_64) with Updates</a>
- <a href="https://aws.amazon.com/marketplace/pp/B00NQAYLWO" target="_blank">CentOS 6 (x86_64) with Updates</a>
- <a href="https://aws.amazon.com/partners/redhat/faqs/" target="_blank">Red Hat Enterprise Linux (RHEL) 8, 7 or 6</a>

Lihat <a href="https://blog.ls20.com/ipsec-l2tp-vpn-auto-setup-for-ubuntu-12-04-on-amazon-ec2/#vpnsetup" target="_blank">Instruksi detail</a> dan <a href="https://aws.amazon.com/ec2/pricing/" target="_blank">harga EC2</a>.

**-Atau-**

Sebuah dedicated server atau virtual private server (VPS), yang baru diinstall dengan salah satu OS dibawah. OpenVZ VPS tidak disupport, atau bisa mencoba<a href="https://github.com/Nyr/openvpn-install" target="_blank">OpenVPN</a>.

Ini juga termasuk Linux VMs di public clouds, seperti <a href="https://digitalocean.com" target="_blank">DigitalOcean</a>, <a href="https://vultr.com" target="_blank">Vultr</a>, <a href="https://linode.com" target="_blank">Linode</a>, <a href="https://cloud.google.com/compute/" target="_blank">Google Compute Engine</a>, <a href="https://aws.amazon.com/lightsail/" target="_blank">Amazon Lightsail</a>, <a href="https://azure.microsoft.com" target="_blank">Microsoft Azure</a>, <a href="https://www.ibm.com/cloud/virtual-servers" target="_blank">IBM Cloud</a>, <a href="https://www.ovh.com/world/vps/" target="_blank">OVH</a> dan <a href="https://www.rackspace.com" target="_blank">Rackspace</a>.

<a href="azure/README.md" target="_blank"><img src="docs/images/azure-deploy-button.png" alt="Deploy to Azure" /></a> <a href="http://dovpn.carlfriess.com/" target="_blank"><img src="docs/images/do-install-button.png" alt="Install on DigitalOcean" /></a> <a href="https://cloud.linode.com/stackscripts/37239" target="_blank"><img src="docs/images/linode-deploy-button.png" alt="Deploy to Linode" /></a>


Pengguna tingkat lanjut bisa setup VPN server dengan Rp. 500,000 <a href="https://www.raspberrypi.org" target="_blank">Raspberry Pi</a>. Lihat <a href="https://blog.elasticbyte.net/setting-up-a-native-cisco-ipsec-vpn-server-using-a-raspberry-pi/" target="_blank">[1]</a> <a href="https://www.stewright.me/2018/07/create-a-raspberry-pi-vpn-server-using-l2tpipsec/" target="_blank">[2]</a>.

<a name="debian-10-note"></a>
\* Pengguna Debian 10 harus menggunakan kernel Linux standar (bukan versi "cloud" ). Baca lebih lanjut <a href="docs/clients.md#debian-10-kernel" target="_blank">disini</a>.   

:warning: **JANGAN** jalankan script ini di PC atau Mac pribadi! Harus dijalankan pada server.

## Instalasi

### Ubuntu & Debian

Pertama, update system dengan `apt-get update && apt-get dist-upgrade` dan reboot. Ini oposional, tapi direkomendasikan.

Untuk install VPN, pilih salah satu pilihan dibawah:

**Pilihan 1:** Script membuat VPN credentials secara random (akan ditampilkan saat selesai):

```bash
wget https://bit.ly/ipsec-vpnsetup -O vpnsetup.sh && sudo sh vpnsetup.sh
```

**Pilihan 2:** Edit script dan isi dengan VPN credentials kamu:

```bash
wget https:/bit.ly/ipsec-vpnsetup -O vpnsetup.sh
nano -w vpnsetup.sh
[Replace dengan values yang kamu inginkan: YOUR_IPSEC_PSK, YOUR_USERNAME dan YOUR_PASSWORD]
sudo sh vpnsetup.sh
```

**Note:** IPsec PSK yang aman harus terdiri dari setidaknya 20 karakter acak.

**Pilihan 3:** Tentukan VPN credentials mu sebagai environment variables:

```bash
# - SEMUA value HARUS ditempatkan pada 'petik 1'
# - JANGAN menggunakan special characters dalam value: \ " '
wget https://bit.ly/ipsec-vpnsetup -O vpnsetup.sh && sudo \
VPN_IPSEC_PSK='your_ipsec_pre_shared_key' \
VPN_USER='your_vpn_username' \
VPN_PASSWORD='your_vpn_password' \
sh vpnsetup.sh
```

**Note:** Jika gagal download via `wget`, kamu bisa membuka <a href="vpnsetup.sh" target="_blank">vpnsetup.sh</a> (atau <a href="vpnsetup_centos.sh" target="_blank">vpnsetup_centos.sh</a>) dan klik tombol **`Raw`**. Tekan `Ctrl-A` untuk select all, `Ctrl-C` untuk copy, Lalu paste ke editor favoritmu.

### CentOS & RHEL

Pertama, update system dengan `yum update` dan reboot. Ini oposional, tapi direkomendasikan.

Ikuti langkah seperti dibawah, tapi replace `https://bit.ly/ipsec-vpnsetup` dengan `https://bit.ly/ipsec-vpnsetup-centos`.

## Langkah selanjutnya

Untuk menggunakan VPN pada PC, Laptop, dan Smartphone, baca dibawah:

<a href="docs/clients.md" target="_blank">**Konfigurasi IPsec/L2TP VPN Clients**</a>

<a href="docs/clients-xauth.md" target="_blank">**Konfigurasi IPsec/XAuth ("Cisco IPsec") VPN Clients**</a>

<a href="docs/ikev2-howto.md" target="_blank">**Step-by-Step Guide: How to Set Up IKEv2 VPN**</a>

Jika error saat koneksi ke VPN, lihat <a href="docs/clients.md#troubleshooting" target="_blank">Troubleshooting</a>.

Enjoy! :sparkles::tada::rocket::sparkles:

## Catatan penting

**Pengguna Windows**: <a href="docs/clients.md#windows-error-809" target="_blank">one-time registry change</a> dibutuhkan jika VPN server/Client dalam NAT(contoh. router rumah)

**Pengguna Android**: Jika kamu menemukan masalah saat koneksi, coba <a href="docs/clients.md#android-mtumss-issues" target="_blank">langkah ini</a>.

Akun VPN sama bisa digunakan pada beberapa perangkat. Tapi, karena limitasi IPsec/L2TP, Jika kamu ingin konek ke beberapa perangkat secara bersamaan dari belakan NAT yang sama (cth. router rumah), kamu harus menggunakan <a href="docs/clients-xauth.md" target="_blank">IPsec/XAuth mode</a>.

Jika kamu ingin menambah, edit, atau hapus akun VPN, baca <a href="docs/manage-users.md" target="_blank">Manage VPN Users</a>.

Untuk server dengan firewall eksternal(contoh. <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html" target="_blank">EC2</a>/<a href="https://cloud.google.com/vpc/docs/firewalls" target="_blank">GCE</a>), buka port UDP 500 dan 4500 untuk VPN.

Client akan menggunakan <a href="https://developers.google.com/speed/public-dns/" target="_blank">Google Public DNS</a> saat VPN aktif. Jika ingin menggunakan provider DNS lain, replace `8.8.8.8` dan `8.8.4.4` di `/etc/ppp/options.xl2tpd` dan `/etc/ipsec.conf`, lalu reboot server. Pengguna tingkat lanjut bisa mengganti value `VPN_DNS_SRV1` dan `VPN_DNS_SRV2` saat menjalankan script.

Menggunakan kernel support bisa meningkatkan performa IPsec/L2TP. Ini tersedia di Ubuntu 16.04-20.04, Debian 9-10 and CentOS 6-8. Pengguna Ubuntu : Install `linux-modules-extra-$(uname -r)` (atau `linux-image-extra`), lalu jalankan `service xl2tpd restart`.

Untuk mengubah IPTables rules saat selesai install, edit `/etc/iptables.rules` dan/atau `/etc/iptables/rules.v4` (Ubuntu/Debian), atau `/etc/sysconfig/iptables` (CentOS/RHEL). Lalu reboot server.

Saat menghubungkan lewat `IPsec/L2TP`, VPN server menggunakan IP `192.168.42.1` dengan VPN subnet `192.168.42.0/24`.

Script ini akan mem backup file config yang ada saat membuat perubahan, dengan suffix `.old-date-time`.

## Upgrade Libreswan

Script tambahan <a href="extras/vpnupgrade.sh" target="_blank">vpnupgrade.sh</a> dan <a href="extras/vpnupgrade_centos.sh" target="_blank">vpnupgrade_centos.sh</a> bisa digunakan untuk upgrade <a href="https://libreswan.org" target="_blank">Libreswan</a> (<a href="https://github.com/libreswan/libreswan/blob/master/CHANGES" target="_blank">changelog</a> | <a href="https://lists.libreswan.org/mailman/listinfo/swan-announce" target="_blank">announce</a>). Edit variabel `SWAN_VER` saat dibutuhkan. Cek setiap versi yang terinstall: `ipsec --version`.

```bash
# Ubuntu & Debian
wget https://bit.ly/vpnupgrade -O vpnupgrade.sh
# CentOS & RHEL
wget https://bit.ly/vpnupgrade-centos -O vpnupgrade.sh
```

## Uninstallation

Baca ini, <a href="docs/uninstall.md" target="_blank">Uninstall VPN</a>.

## License

Copyright (C) 2019-2020 <a href="https://www.linkedin.com/in/umarhadi/" target="_blank">Umar Hadi Siswanto</a> <a href="https://www.linkedin.com/in/umarhadi/" target="_blank"><img src="https://static.licdn.com/scds/common/u/img/webpromo/btn_viewmy_160x25.png" width="160" height="25" border="0" alt="View my profile on LinkedIn"></a>   
Berdasarkan <a href="https://github.com/sarfata/voodooprivacy" target="_blank">hasil kerja Thomas Sarlandie</a> (Copyright 2012)

Project ini dalam lisensi <a href="http://creativecommons.org/licenses/by-sa/3.0/" target="_blank">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>  
