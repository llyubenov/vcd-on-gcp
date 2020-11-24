# VMware Cloud Director on Google Cloud Terraform Modules

This Repo contains Terraform mudules that can be used to deploy VMware Cloud Director on Google Cloud.
The idea is for the deployed VCD instance to be able to connect and leverage vSphere resources from Google Compute VMware Engine.

## Features

The modules will create the following resources:
1. A bucket in Google Storage to store the Cloud Director Binaries, Java Keystore and response.properties files.
2. VPC Network, Cloud Router and Cloud NAT in the specified Region.
3. Subnetwork with the specified CIDR block.
4. The necessary firewall rules for the Cloud Dircetor Deployment to work.
5. Filestore instance that will be mounter by the VCD cells for as a transfer store.
6. Cloud SQL Postgres Instance for the VCD databease.
7. Compute Engin Instance:
  - Bastion VM to access the VCD Cells thru it.
  - VCD Cells (minimum 2) to run the Cloud Director Services. The cels are separated in two Managed Insntace Groups, based on the function the execute - API/UI and Console Proxy.
8. Two Load Balancers:
  - HTTPS loadbalancer ot provide acces to Cloud Director UI and API.
  - TCP Proxy loabalancer to provide access for Cloud Director Console proxy.


## Deployment diagram

**Figure 1.** *diagram of terraform resources*

![architecture diagram](./vcd_on_gcp_diagram.png)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Requirements

The modules 

### Local Files

- VMware Cloud Director Binary - Place the VCD binary `<vcd-binary-name>.bin` in `files/vcd-binaries` folder.
- VCD Java keystore files - Place the Java keystore files `<jave-keystore-filename>.ks` in `files/vcd-keystore-file` filder.
- HTTPS Load balancer certificate files - Place the HTTPS loadbalancer certificate `<cert-file>.crt` and key `<cert-key-file>.key` files in `files/vcd-lb-cert` folder.

### IAM permissions

### APIs
