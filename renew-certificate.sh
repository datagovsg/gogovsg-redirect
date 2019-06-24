#!/bin/bash

sudo /opt/bitnami/ctlscript.sh stop 
sudo /opt/bitnami/letsencrypt/lego --tls --email="jean@data.gov.sg" --domains="go.gov.sg" --domains="www.go.gov.sg" --path="/opt/bitnami/letsencrypt" renew --days 90
sudo /opt/bitnami/ctlscript.sh start 