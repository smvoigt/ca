# Dev Certificate Authority
This project automates the creation of a root certificate and an intermediate certificate authority and a certificate chain that contains both certs. A single script then creates server certificates signed by the intermediate certificate authority. 

__This certificate authority and generated certificates are for development use only. You should not consider them to provide any security other than requiring a few extra steps to decrypt__

## Bootstrap 
Bootstrap autotools to create the configure script
```bash
./bootstrap.sh
```
## Configure the project
Configure options:

|option           |default |     |
|-----------------|--------|-----|
| --cert_country   |AU            |default cert country|
| --cert_state     |State         |default cert state|
| --cert_locality  |Locality      |default cert locality|
| --cert_org       |Org           |default cert org|
| --cert_org_unit  |Org Unit      |default cert org_unit|
| --with-carootdir |$sysconfdir/ca|ca root directory|

## Install

```bash
make install
```

## Creating a new server certificate the easy way

./create_new_server_cert.sh <fullyqualified.domain.name>

## Files
| file | description |
|------|-------------|
|$sbindir/create_new_server_cert.sh _hostname.domain_| script to create new server certificates signed by the certificate authority|
|$sysconfdir/ca/intermediate/certs/ca-chain.cert.pem| certificate authority trust certificate|
|$sysconfdir/ca/intermediate/certs/| server certs in the form: hostname.domain.cert.pem

This certificate authority project has been created by following the guide at https://jamielinux.com/docs/openssl-certificate-authority/index.html. 

