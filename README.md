

# Redirect go.gov.sg to www.go.gov.sg

https://docs.bitnami.com/bch/how-to/generate-install-lets-encrypt-ssl/#alternative-approach

### Install lego client

```
cd /tmp
curl -Ls https://api.github.com/repos/xenolf/lego/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | wget -i -
tar xf lego_vX.Y.Z_linux_amd64.tar.gz
sudo mkdir -p /opt/bitnami/letsencrypt
sudo mv lego /opt/bitnami/letsencrypt/lego
```

### Turn off bitnami nginx

`sudo /opt/bitnami/ctlscript.sh stop`

### Create certificate

`sudo /opt/bitnami/letsencrypt/lego --tls --email="jean@data.gov.sg" --domains="forms.gov.sg" --domains="www.forms.gov.sg" --path="/opt/bitnami/letsencrypt" `

### Create certificates

```
sudo mv /opt/bitnami/nginx/conf/server.crt /opt/bitnami/nginx/conf/server.crt.old
sudo mv /opt/bitnami/nginx/conf/server.key /opt/bitnami/nginx/conf/server.key.old
sudo mv /opt/bitnami/nginx/conf/server.csr /opt/bitnami/nginx/conf/server.csr.old
sudo ln -sf /opt/bitnami/letsencrypt/certificates/go.gov.sg.key /opt/bitnami/nginx/conf/server.key
sudo ln -sf /opt/bitnami/letsencrypt/certificates/go.gov.sg.crt /opt/bitnami/nginx/conf/server.crt
sudo chown root:root /opt/bitnami/nginx/conf/server*
sudo chmod 600 /opt/bitnami/nginx/conf/server
```

### Move config file to correct location

`sudo cp bitnami.conf /opt/bitnami/nginx/conf/bitnami/`

### Restart services

`sudo /opt/bitnami/ctlscript.sh start`

### Set up cron job  to renew the cert 

```
sudo mkdir /opt/bitnami/letsencrypt/scripts/
sudo cp renew-certificate.sh /opt/bitnami/letsencrypt/scripts/
chmod +x /opt/bitnami/letsencrypt/scripts/renew-certificate.sh
sudo crontab -e
```

Add the following line

`0 0 1 * * /opt/bitnami/letsencrypt/scripts/renew-certificate.sh 2> /dev/null`
