# Deploy to Microsoft Azure


Template ini akan membuat VPN server yang langsung berjalan pada Microsoft Azure Cloud (<a href="https://azure.microsoft.com/en-us/pricing/details/virtual-machines/" target="_blank">detail harga</a>).

Dapat disesuaikan dengan opsi berikut:

 - Username untuk VPN **dan** SSH
 - Password untuk VPN **dan** SSH
 - IPsec Pre-Shared Key dan VPN
 - Operating System Image (Debian 9 or Ubuntu 18.04/16.04 LTS)
 - Virtual Machine Size (Default: Standard_B1s)

**Note:** JANGAN menggunakan special characters dalam value: `\ " '`

Tekan tombol ini untuk memulai:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fumarhadi%2Fipsec-vpn%2Fmaster%2Fazure%2Fazuredeploy.json" target="_blank">
    <img src="../docs/images/azure-deploy-button.png" alt="Deploy to Azure" />
</a><br><br>

Saat deploy selesai, Azure akan memberikan notifikasi. Langkah selanjutnya: [Konfigurasi VPN Clients](../docs/clients.md).

## Authors

Copyright (C) 2016 [Daniel Falkner](https://github.com/derdanu)   
Copyright (C) 2019-2020 Umar Hadi Siswanto

## Screenshot

![Azure Custom Deployment](custom_deployment_screenshot.png)
