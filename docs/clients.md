# Configure IPsec/L2TP VPN Clients

**Note: You may also connect using the faster [IPsec/XAuth mode](clients-xauth.md), or set up [IKEv2](ikev2-howto.md).**

Setelah <a href="https://github.com/umarhadi/ipsec-vpn" target="_blank">membuat VPN server mu sendiri</a>, ikuti langkah ini untuk konfigurasi perangkatmu. IPsec/L2TP secara native support untuk Android, iOS, OS X, dan Windows. Tidak membutuhkan software tambahan untuk install. Setup ini harusnya memakan waktu beberapa menit. Dalam kasus jika tidak bisa connect, cek detail akun vpn sudah benar.

---
* Platforms
  * [Windows](#windows)
  * [OS X (macOS)](#os-x)
  * [Android](#android)
  * [iOS (iPhone/iPad)](#ios)
  * [Chromebook](#chromebook)
  * [Linux](#linux)
* [Troubleshooting](#troubleshooting)

## Windows

### Windows 10 dan 8.x

1. Klik-kanan pada wireless/network icon di system tray.
1. Pilih **Open Network and Sharing Center**. atau, jika menggunakan Windows 10 version 1709 atau diatasnya, pilih **Open Network & Internet settings**, lalu pada halaman yang terbuka, klik **Network and Sharing Center**.
1. Klik **Set up a new connection or network**.
1. Pilih **Connect to a workplace** dan klik **Next**.
1. Klik **Use my Internet connection (VPN)**.
1. Masukkan `Your VPN Server IP` pada field **Internet address**.
1. Masukkan apapan yang kamu suka pada field **Destination name**, lalu klik **Create**.
1. Kembali ke **Network and Sharing Center**. On the left, Klik **Change adapter settings**.
1. Klik-kanan pada VPN entry baru dan pilih **Properties**.
1. Klik tab **Security**. Pilih "Layer 2 Tunneling Protocol with IPsec (L2TP/IPSec)" untuk **Type of VPN**.
1. Klik **Allow these protocols**. Centang "Challenge Handshake Authentication Protocol (CHAP)" dan "Microsoft CHAP Version 2 (MS-CHAP v2)".
1. Klik tombol **Advanced settings**.
1. Pilih **Use preshared key for authentication** dan Masukkan `Your VPN IPsec PSK` untuk **Key**.
1. Klik **OK** untuk menutup **Advanced settings**.
1. Klik **OK** untuk save detail VPN connection.

**Note:** **one-time registry change** dibutuhkan sebelum menghubungkan. Lihat details dibawah.

Sebagai alternatif, daripada mengikuti langkah-langkah di atas, Kamu dapat membuat koneksi VPN menggunakan perintah Windows PowerShell. Replace `Your VPN Server IP` dan `Your VPN IPsec PSK` dengan value sendiri, didalam tanda petik:

```console
# Disable persistent command history
Set-PSReadlineOption –HistorySaveStyle SaveNothing
# Create VPN connection
Add-VpnConnection -Name 'My IPsec VPN' -ServerAddress 'Your VPN Server IP' -L2tpPsk 'Your VPN IPsec PSK' -TunnelType L2tp -EncryptionLevel Required -AuthenticationMethod Chap,MSChapv2 -Force -RememberCredential -PassThru
# Ignore the data encryption warning (data is encrypted in the IPsec tunnel)
```

### Windows 7, Vista dan XP

1. Klik Start Menu dan pilih Control Panel
1. Ke **Network and Internet**.
1. Klik **Network and Sharing Center**.
1. Klik **Set up a new connection or network**.
1. Pilih **Connect to a workplace** dan Klik **Next**.
1. Klik **Use my Internet connection (VPN)**.
1. Masukkan `Your VPN Server IP` dalam field **Internet address**.
1. Masukkan apapun pada field **Destination name**.
1. Centang **Don't connect now; just set it up so I can connect later**.
1. Klik **Next**.
1. Masukkan `Your VPN Username` dalam field **User name**.
1. Masukkan `Your VPN Password` dalam field **Password**.
1. Centang **Remember this password**.
1. Klik **Create**, lalu **Close**.
1. Kembali ke **Network and Sharing Center**. Lihat bagian kiri, Klik **Change adapter settings**.
1. Klik-kanan pada new VPN entry dan pilih **Properties**.
1. Klik tab **Options** dan hilangkan centang **Include Windows logon domain**.
1. Klik tab **Security**. Pilih "Layer 2 Tunneling Protocol with IPsec (L2TP/IPSec)" untuk **Type of VPN**.
1. Klik **Allow these protocols**. Centang "Challenge Handshake Authentication Protocol (CHAP)" dan "Microsoft CHAP Version 2 (MS-CHAP v2)".
1. Klik tombol **Advanced settings**.
1. Pilih **Use preshared key for authentication** dan Masukkan `Your VPN IPsec PSK` untuk **Key**.
1. Klik **OK** untuk menutup **Advanced settings**.
1. Klik **OK** untuk simpan detail VPN connection.

**Note:** <a href="#windows-error-809">one-time registry change</a> dibutuhkan jika VPN server/Client dalam NAT(contoh. router rumah)

Untuk menghubungkan ke VPN: Klik pada wireless/network icon pada system tray, Pilih new VPN entry, and Klik **Connect**. Jika diijinkan, Masukkan `Your VPN Username` dan `Password`, lalu Klik **OK**. Lalu kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, lihat <a href="#troubleshooting">Troubleshooting</a>.

## OS X

1. Buka System Preferences dan ke bagian Network.
1. Klik tombol **+** di ujung bawah kiri.
1. Pilih **VPN** pada menu dropdown **Interface**.
1. Pilih **L2TP over IPSec** pada menu dropdown **VPN Type**.
1. Masukkan apapun untuk **Service Name**.
1. Klik **Create**.
1. Masukkan `Your VPN Server IP` untuk **Server Address**.
1. Masukkan `Your VPN Username` untuk **Account Name**.
1. Klik tombol **Authentication Settings**.
1. Pada bagian **User Authentication**, Klik radio button **Password** dan Masukkan `Your VPN Password`.
1. Pada **Machine Authentication**, Klik radio button **Shared Secret** dan Masukkan `Your VPN IPsec PSK`.
1. Klik **OK**.
1. Centang **Show VPN status in menu bar**.
1. **(Penting)** Klik tombol **Advanced** dan pastikan checkbox **Send all traffic over VPN connection** telah dicentang.
1. **(Penting)** Klik tab **TCP/IP**, dan pastikan **Link-local only** dipilih pada bagian **Configure IPv6**.
1. Klik **OK** untuk close Advanced settings, dan Klik **Apply** untuk save informasi VPN connection.

Untuk menghubungkan ke VPN: Gunakan icon pada menu bar, atau ke bagian Network pada System Preferences, Pilih VPN dan pilih **Connect**. Lalu kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, lihat <a href="#troubleshooting">Troubleshooting</a>.

## Android

1. Buka **Settings**.
1. Klik "Network & internet". atau, jika kamu menggunakan Android 7 kebawah, klik **More...** pada bagian **Wireless & networks**.
1. Klik **VPN**.
1. Klik **Add VPN Profile** atau klik icon **+** di ujung kanan bawah.
1. Masukkan apapun pada field **Name**.
1. Pilih **L2TP/IPSec PSK** di menu dropdown **Type**.
1. Masukkan `Your VPN Server IP` pada field **Server address**.
1. Biarkan field **L2TP secret** kosong.
1. Biarkan field **IPSec identifier** kosong.
1. Masukkan `Your VPN IPsec PSK` pada field **IPSec pre-shared key**.
1. Klik **Save**.
1. Klik new VPN connection.
1. Masukkan `Your VPN Username` pada field **Username**.
1. Masukkan `Your VPN Password` pada field **Password**.
1. Centang **Save account information**.
1. Klik **Connect**.

Saat terkoneksi, kamu bisa melihat icon VPN pada statusbar. Lalu kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, lihat <a href="#troubleshooting">Troubleshooting</a>.

## iOS

1. Ke Settings -> General -> VPN.
1. Klik **Add VPN Configuration...**.
1. Klik **Type**. Pilih **L2TP** dan kembali.
1. Klik **Description** dan masukkan apapaun.
1. Klik **Server** dan Masukkan `Your VPN Server IP`.
1. Klik **Account** dan Masukkan `Your VPN Username`.
1. Klik **Password** dan Masukkan `Your VPN Password`.
1. Klik **Secret** dan Masukkan `Your VPN IPsec PSK`.
1. Pastikan switch **Send All Traffic** ON.
1. Klik **Done**.
1. Klik switch **VPN** ON.

Saat terkoneksi, kamu bisa melihat icon VPN pada control center. Lalu kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, lihat <a href="#troubleshooting">Troubleshooting</a>.

## Chromebook

1. Jka kamu belum sign in di Chromebook.
1. Klik area status, yang menampilkan fotomu.
1. Klik **Settings**.
1. Pada bagian **Internet connection**, Klik **Add connection**.
1. Klik **Add OpenVPN / L2TP**.
1. Masukkan `Your VPN Server IP` untuk **Server hostname**.
1. Masukkan apapun untuk **Service name**.
1. Pastikan **Provider type** adalah **L2TP/IPSec + pre-shared key**.
1. Masukkan `Your VPN IPsec PSK` untuk **Pre-shared key**.
1. Masukkan `Your VPN Username` untuk **Username**.
1. Masukkan `Your VPN Password` untuk **Password**.
1. Klik **Connect**.

Saat terkoneksi, kamu bisa melihat icon VPN pada area status. Lalu kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, lihat <a href="#troubleshooting">Troubleshooting</a>.

## Linux

### Ubuntu Linux

Ubuntu 18.04 (dan terbaru) pengguna bisa menginstall package <a href="https://packages.ubuntu.com/search?keywords=network-manager-l2tp-gnome" target="_blank">network-manager-l2tp-gnome</a> menggunanakn `apt`, lalu konfigurasi client IPSec/L2TP VPN menggunakan GUI. Pengguna Ubuntu 16.04 mungkin membutuhkan PPA `nm-l2tp`, baca lebih lanjut <a href="https://medium.com/@hkdb/ubuntu-16-04-connecting-to-l2tp-over-ipsec-via-network-manager-204b5d475721" target="_blank">disini</a>.

1. Ke Settings -> Network -> VPN. Klik tombol **+**.
1. Pilih **Layer 2 Tunneling Protocol (L2TP)**.
1. Masukkan apapaun pada field **Name**.
1. Masukkan `Your VPN Server IP` untuk **Gateway**.
1. Masukkan `Your VPN Username` untuk **User name**.
1. Klik-kanan di **?** dalam field **Password**, Pilih **Store the password only for this user**.
1. Masukkan `Your VPN Password` untuk **Password**.
1. Biarkan field **NT Domain** kosong.
1. Klik tombol **IPsec Settings...**.
1. Centang **Enable IPsec tunnel to L2TP host**.
1. Biarkan field **Gateway ID** kosong.
1. Masukkan `Your VPN IPsec PSK` untuk **Pre-shared key**.
1. Expand bagian **Advanced**.
1. Masukkan `aes128-sha1-modp2048!` untuk **Phase1 Algorithms**.
1. Masukkan `aes128-sha1-modp2048!` untuk **Phase2 Algorithms**.
1. Klik **OK**, lalu Klik **Add** untuk save VPN connection information.
1. Nyalakan **VPN**.

Saat terkoneksi, kamu bisa verifikasi apakah jaringanmu sudah terhubung ke VPN dengan <a href="https://www.google.com/search?q=my+ip" target="_blank">cek IP address di Google </a>. Ini akan menampilkan "Your public IP address is `Your VPN Server IP`".

Jika menemukan error saat mencoba menghubungkan, coba <a href="https://github.com/nm-l2tp/NetworkManager-l2tp/blob/master/README.md#issue-with-not-stopping-system-xl2tpd-service" target="_blank">untuk fix</a>.

### Fedora dan CentOS

Fedora 28 (atau yang lebih baru) dan pengguna CentOS 8/7 bisa menggunakan client [IPsec/XAuth](clients-xauth.md#linux).

### Linux Lainnya

Pertama cek <a href="https://github.com/nm-l2tp/NetworkManager-l2tp/wiki/Prebuilt-Packages" target="_blank">disini</a> untuk melihat apakah package `network-manager-l2tp` dan `network-manager-l2tp-gnome` ada untuk distro Linux yang digunakan. Jika ada, install keduanya (Pilih strongSwan) dan ikuti instruksi dibawah. Alternativenya, kmau mungkin [konfigurasi Linux VPN clients menggunakan command line](#konfigurasi-linux-vpn-clients-menggunakan-command-line).

## Troubleshooting

* [Windows Error 809](#windows-error-809)
* [Windows Error 628 or 766](#windows-error-628-or-766)
* [Windows 10 connecting](#windows-10-connecting)
* [Windows 10 upgrades](#windows-10-upgrades)
* [Windows 8/10 DNS leaks](#windows-810-dns-leaks)
* [Android MTU/MSS issues](#android-mtumss-issues)
* [Android 6 and 7](#android-6-and-7)
* [macOS send traffic over VPN](#macos-send-traffic-over-vpn)
* [iOS 13 and macOS 10.15](#ios-13-and-macos-1015)
* [iOS/Android sleep mode](#iosandroid-sleep-mode)
* [Debian 10 kernel](#debian-10-kernel)
* [Chromebook issues](#chromebook-issues)
* [Other errors](#other-errors)
* [Check logs and VPN status](#check-logs-and-vpn-status)

### Windows Error 809

> Error 809: Sambungan jaringan antara komputermu dan server VPN tidak dapat dibuat karena server tidak merespons. Ini mungkin karena salah satu perangkat jaringan (mis., Firewall, NAT, router, dll.) Antara komputer kamu dan server tidak dikonfigurasi untuk mengizinkan koneksi VPN. Silakan hubungi Administrator atau penyedia layanan kamu untuk menentukan perangkat mana yang mungkin menyebabkan masalah.

Untuk memperbaiki error ini, <a href="https://documentation.meraki.com/MX-Z/Client_VPN/Troubleshooting_Client_VPN#Windows_Error_809" target="_blank">one-time registry change</a>  dibutuhkan jika VPN server/Client dalam NAT(contoh. router rumah). Download dan import file `.reg` dibawah, atau jalankan dari <a href="http://www.winhelponline.com/blog/open-elevated-command-prompt-windows/" target="_blank">elevated command prompt</a>. **Kamu harus reboot saat selesai.**

- Untuk Windows Vista, 7, 8.x dan 10 ([download file .reg](https://static.ls20.com/reg-files/v1/Fix_VPN_Error_809_Windows_Vista_7_8_10_Reboot_Required.reg))

  ```console
  REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
  ```

- HANYA Untuk Windows XP ([download file .reg](https://static.ls20.com/reg-files/v1/Fix_VPN_Error_809_Windows_XP_ONLY_Reboot_Required.reg))

  ```console
  REG ADD HKLM\SYSTEM\CurrentControlSet\Services\IPSec /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
  ```

Meskipun tidak umum, beberapa sistem Windows menonaktifkan enkripsi IPsec, yang menyebabkan koneksi gagal. Untuk mengaktifkannya kembali, jalankan perintah berikut dan reboot.

- Untuk Windows XP, Vista, 7, 8.x dan 10 ([download file .reg](https://static.ls20.com/reg-files/v1/Fix_VPN_Error_809_Allow_IPsec_Reboot_Required.reg))

  ```console
  REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f
  ```

### Windows Error 628 atau 766

> Error 628: Koneksi diakhiri oleh server sebelum dapat diselesaikan.

> Error 766: Sertifikat tidak dapat ditemukan. Sambungan yang menggunakan protokol L2TP melalui IPSec memerlukan penginstalan sertifikat mesin, juga dikenal sebagai sertifikat komputer.

Untuk memperbaiki error ini, ikuti langkah dibawah:

1. Klik-kanan pada icon wireless/network di system tray.
1. Pilih **Open Network and Sharing Center**. Atau, Jika menggunakan Windows 10 version 1709 atau yang lebih baru, Pilih **Open Network & Internet settings**, lalu pada window yang terbuka, Klik **Network and Sharing Center**.
1. Di kiri, Klik **Change adapter settings**. Klik-kanan pada new VPN dan pilih **Properties**.
1. Klik tab **Security**. Pilih "Layer 2 Tunneling Protocol with IPsec (L2TP/IPSec)" untuk **Type of VPN**.
1. Klik **Allow these protocols**. Centang "Challenge Handshake Authentication Protocol (CHAP)" and "Microsoft CHAP Version 2 (MS-CHAP v2)".
1. Klik tombol **Advanced settings**.
1. Pilih **Use preshared key for authentication** dan Masukkan `Your VPN IPsec PSK` untuk **Key**.
1. Klik **OK** untuk menutup **Advanced settings**.
1. Klik **OK** untuk menyimpan VPN connection details.

![Pilih CHAP di VPN connection properties](images/vpn-properties.png)

### Windows 10 connecting

Jika menggunakan Windows 10 dan VPN macet saat "menyambung" selama lebih dari beberapa menit, coba langkah-langkah berikut:

1. Klik-kanan pada icon wireless/network di system tray.
1. Pilih **Open Network & Internet settings**, lalu pada windows yang terbuka, Klik **VPN** dikiri.
1. Pilih new VPN entry, lalu Klik **Connect**. Jika diminta, Masukkan `Your VPN Username` dan `Password`, lalu Klik **OK**.

### Windows 10 upgrades

Setelah upgrade versi Windows 10 (mis. Dari 1709 ke 1803), Kamu mungkin perlu menerapkan ulang perbaikan di atas untuk [Windows Error 809](#windows-error-809) dan reboot.

### Windows 8/10 DNS leaks

Windows 8.x dan 10 menggunakan "smart multi-homed name resolution" secara default, yang dapat menyebabkan "DNS leaks" saat menggunakan client VPN IPsec native, Jika server DNS kamu di adaptor Internet berasal dari segmen jaringan lokal. Untuk memperbaikinya, Kamu juga bisa<a href="https://www.neowin.net/news/guide-prevent-dns-leakage-while-using-a-vpn-on-windows-10-and-windows-8/" target="_blank">disable smart multi-homed name resolution</a>, atau konfigurasikan adaptor Internet kamu untuk menggunakan server DNS di luar jaringan lokal (mis. 8.8.8.8 dan 8.8.4.4). Saat selesai, <a href="https://support.opendns.com/hc/en-us/articles/227988627-How-to-clear-the-DNS-Cache-" target="_blank">clear DNS cache</a> dan reboot PC.

Selain itu, jika komputermu mengaktifkan IPv6, Semua traffic IPv6 (termasuk DNS queries) akan bypass VPN. Pelajari bagaimana <a href="https://support.microsoft.com/en-us/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users" target="_blank">disable IPv6</a> di Windwos.

### Android MTU/MSS issues

Beberapa perangkat Android memiliki masalah MTU / MSS, sehingga mereka dapat terhubung ke VPN menggunakan mode IPsec / XAuth ("Cisco IPsec"), tetapi tidak dapat membuka situs web. Jika mengalami masalah ini, coba jalankan perintah berikut di server VPN. Jika berhasil, Kamu dapat menambahkan perintah ini ke `/etc/rc.local` untuk persist setelah reboot.

```
iptables -t mangle -A FORWARD -m policy --pol ipsec --dir in \
  -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 \
  -j TCPMSS --set-mss 1360
iptables -t mangle -A FORWARD -m policy --pol ipsec --dir out \
  -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 \
  -j TCPMSS --set-mss 1360

echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
```

### Android 6 dan 7

Jika Android 6.x atau 7.x tidak dapat terhubung, coba langkah ini:

1. Klik icon "Settings" pada VPN Profile. Pilih "Show advanced options" dan scroll kebawah. Jika ada opsi "Backward compatible mode" exists (lihat gambar dibawah), enable dan reconnect VPN. Jika tidak, coba langkah ini.
1. Edit `/etc/ipsec.conf` pada VPN server. Cari line `sha2-truncbug` dan lihat value. jika ada, Replace `sha2-truncbug=no` dengan `sha2-truncbug=yes`, atau replace `sha2-truncbug=yes` dengan `sha2-truncbug=no`. Save file dan jalankan `service ipsec restart`. Lalu reconnect.

![Android VPN workaround](images/vpn-profile-Android.png)

### macOS send traffic over VPN

Pengguna OS X (macOS): Jika kamu bisa sukses terkoneksi dengan mode IPsec/L2TP, tapi public IP tidak memperlihatkan `Your VPN Server IP`, baca bagian [OS X](#os-x) dan selesaikan semua langkah. Save konfigurasi VPN dan Reconnect.

1. Klik tombol **Advanced** dan pastikan centang **Send all traffic over VPN connection**.
1. Klik tab **TCP/IP**, pastikan **Link-local only** dipilih pada **Configure IPv6**.

After trying the steps above, if your computer is still not sending traffic over the VPN, check the service order. From the main network preferences screen, Pilih "set service order" in the cog drop down under the list of connections. Drag the VPN connection to the top.

### iOS 13 and macOS 10.15

If your iOS 13 or macOS 10.15 (Catalina) device cannot connect, try these steps: Edit `/etc/ipsec.conf` on the VPN server. Find `sha2-truncbug=yes` and replace it with `sha2-truncbug=no`. Save the file and run `service ipsec restart`. Then reconnect the VPN.

### iOS/Android sleep mode

To save battery, iOS devices (iPhone/iPad) will automatically disconnect Wi-Fi shortly after the screen turns off (sleep mode). As a result, the IPsec VPN disconnects. This behavior is <a href="https://discussions.apple.com/thread/2333948" target="_blank">by design</a> and cannot be configured. If you need the VPN to auto-reconnect when the device wakes up, try <a href="https://github.com/Nyr/openvpn-install" target="_blank">OpenVPN</a> instead, which <a href="https://docs.openvpn.net/connecting/connecting-to-access-server-with-apple-ios/faq-regarding-openvpn-connect-ios/" target="_blank">has support for options</a> such as "Reconnect on Wakeup" and "Seamless Tunnel".

Android devices will also disconnect Wi-Fi shortly after Masukkaning sleep mode, unless the option "Keep Wi-Fi on during sleep" is enabled. This option is no longer available in Android 8 (Oreo). Alternatively, you may try enabling the "Always-on VPN" option to stay connected. Learn more <a href="https://support.google.com/android/answer/9089766?hl=en" target="_blank">here</a>.

### Debian 10 kernel

Debian 10 users: Run `uname -r` to check your server's Linux kernel version. If it contains the word "cloud", and `/dev/ppp` is missing, then the kernel lacks `ppp` support and cannot use IPsec/L2TP mode ([IPsec/XAuth mode](clients-xauth.md) is not affected).

To fix, you may switch to the standard Linux kernel by installing e.g. the `linux-image-amd64` package. Then update the default kernel in GRUB and reboot.

### Chromebook issues

Chromebook users: If you are unable to connect, try these steps: Edit `/etc/ipsec.conf` on the VPN server. Find the line `phase2alg=...` and append `,aes_gcm-null` at the end. Save the file and run `service ipsec restart`.

### Other errors

If you encounter other errors, refer to the links below:

* http://www.tp-link.com/en/faq-1029.html
* https://documentation.meraki.com/MX-Z/Client_VPN/Troubleshooting_Client_VPN#Common_Connection_Issues   
* https://blogs.technet.microsoft.com/rrasblog/2009/08/12/troubleshooting-common-vpn-related-errors/   
* https://stackoverflow.com/questions/25245854/windows-8-1-gets-error-720-on-connect-vpn

### Check logs and VPN status

Commands below must be run as `root` (or using `sudo`).

First, restart services on the VPN server:

```bash
service ipsec restart
service xl2tpd restart
```

**Docker users:** Run `docker restart ipsec-vpn-server`.

Then reboot your VPN client device, and retry the connection. If still unable to connect, try removing and recreating the VPN connection, by following the instructions in this document. Make sure that the VPN credentials are Masukkaned correctly.

Check the Libreswan (IPsec) and xl2tpd logs for errors:

```bash
# Ubuntu & Debian
grep pluto /var/log/auth.log
grep xl2tpd /var/log/syslog

# CentOS & RHEL
grep pluto /var/log/secure
grep xl2tpd /var/log/messages
```

Check status of the IPsec VPN server:

```bash
ipsec status
ipsec verify
```

Show current established VPN connections:

```bash
ipsec whack --trafficstatus
```

## Configure Linux VPN clients using the command line

After <a href="https://github.com/hwdsl2/setup-ipsec-vpn" target="_blank">setting up your own VPN server</a>, follow these steps to configure Linux VPN clients using the command line. Alternatively, you may configure [using the GUI](#linux). Instructions below are based on [the work of Peter Sanford](https://gist.github.com/psanford/42c550a1a6ad3cb70b13e4aaa94ddb1c). Commands must be run as `root` on your VPN client.

To set up the VPN client, first install the following packages:

```bash
# Ubuntu & Debian
apt-get update
apt-get -y install strongswan xl2tpd net-tools

# CentOS & RHEL
yum -y install epel-release
yum --enablerepo=epel -y install strongswan xl2tpd net-tools

# Fedora
yum -y install strongswan xl2tpd net-tools
```

Create VPN variables (replace with actual values):

```bash
VPN_SERVER_IP='your_vpn_server_ip'
VPN_IPSEC_PSK='your_ipsec_pre_shared_key'
VPN_USER='your_vpn_username'
VPN_PASSWORD='your_vpn_password'
```

Configure strongSwan:

```bash
cat > /etc/ipsec.conf <<EOF
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
  # strictcrlpolicy=yes
  # uniqueids = no

# Add connections here.

# Sample VPN connections

conn %default
  ikelifetime=60m
  keylife=20m
  rekeymargin=3m
  keyingtries=1
  keyexchange=ikev1
  authby=secret
  ike=aes128-sha1-modp2048!
  esp=aes128-sha1-modp2048!

conn myvpn
  keyexchange=ikev1
  left=%defaultroute
  auto=add
  authby=secret
  type=transport
  leftprotoport=17/1701
  rightprotoport=17/1701
  right=$VPN_SERVER_IP
EOF

cat > /etc/ipsec.secrets <<EOF
: PSK "$VPN_IPSEC_PSK"
EOF

chmod 600 /etc/ipsec.secrets

# For CentOS/RHEL & Fedora ONLY
mv /etc/strongswan/ipsec.conf /etc/strongswan/ipsec.conf.old 2>/dev/null
mv /etc/strongswan/ipsec.secrets /etc/strongswan/ipsec.secrets.old 2>/dev/null
ln -s /etc/ipsec.conf /etc/strongswan/ipsec.conf
ln -s /etc/ipsec.secrets /etc/strongswan/ipsec.secrets
```

Configure xl2tpd:

```bash
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[lac myvpn]
lns = $VPN_SERVER_IP
ppp debug = yes
pppoptfile = /etc/ppp/options.l2tpd.client
length bit = yes
EOF

cat > /etc/ppp/options.l2tpd.client <<EOF
ipcp-accept-local
ipcp-accept-remote
refuse-eap
require-chap
noccp
noauth
mtu 1280
mru 1280
noipdefault
defaultroute
usepeerdns
connect-delay 5000
name $VPN_USER
password $VPN_PASSWORD
EOF

chmod 600 /etc/ppp/options.l2tpd.client
```

The VPN client setup is now complete. Follow the steps below to connect.

**Note:** You must repeat all steps below every time you try to connect to the VPN.

Create xl2tpd control file:

```bash
mkdir -p /var/run/xl2tpd
touch /var/run/xl2tpd/l2tp-control
```

Restart services:

```bash
service strongswan restart
service xl2tpd restart
```

Start the IPsec connection:

```bash
# Ubuntu & Debian
ipsec up myvpn

# CentOS/RHEL & Fedora
strongswan up myvpn
```

Start the L2TP connection:

```bash
echo "c myvpn" > /var/run/xl2tpd/l2tp-control
```

Run `ifconfig` and check the output. You should now see a new interface `ppp0`.

Check your existing default route:

```bash
ip route
```

Find this line in the output: `default via X.X.X.X ...`. Write down this gateway IP for use in the two commands below.

Exclude your VPN server's IP from the new default route (replace with actual value):

```bash
route add YOUR_VPN_SERVER_IP gw X.X.X.X
```

If your VPN client is a remote server, you must also exclude your Local PC's public IP from the new default route, to prevent your SSH session from being disconnected (replace with <a href="https://www.google.com/search?q=my+ip" target="_blank">actual value</a>):

```bash
route add YOUR_LOCAL_PC_PUBLIC_IP gw X.X.X.X
```

Add a new default route to start routing traffic via the VPN server：

```bash
route add default dev ppp0
```

The VPN connection is now complete. Verify that your traffic is being routed properly:

```bash
wget -qO- http://ipv4.icanhazip.com; echo
```

The above command should return `Your VPN Server IP`.

To stop routing traffic via the VPN server:

```bash
route del default dev ppp0
```

To disconnect:

```bash
# Ubuntu & Debian
echo "d myvpn" > /var/run/xl2tpd/l2tp-control
ipsec down myvpn

# CentOS/RHEL & Fedora
echo "d myvpn" > /var/run/xl2tpd/l2tp-control
strongswan down myvpn
```

## Credits

This document was adapted from the <a href="https://github.com/StreisandEffect/streisand" target="_blank">Streisand</a> project, maintained by Joshua Lund and contributors.

## License

Note: This license applies to this document only.

Copyright (C) 2016-2020 Lin Song   
Based on <a href="https://github.com/StreisandEffect/streisand/blob/6aa6b6b2735dd829ca8c417d72eb2768a89b6639/playbooks/roles/l2tp-ipsec/templates/instructions.md.j2" target="_blank">the work of Joshua Lund</a> (Copyright 2014-2016)

This program is free software: you can redistribute it and/or modify it under the terms of the <a href="https://www.gnu.org/licenses/gpl.html" target="_blank">GNU General Public License</a> as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
