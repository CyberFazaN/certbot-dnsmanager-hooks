# certbot-dnsmanager-hooks
ISPsystem DNS API for certbot --manual-auth-hook --manual-cleanup-hook

**Note for firstvds.ru:** You should get DNSManager username and password from support team (open ticket).

Install and renew Let's encrypt wildcard ssl certificate for domain *.site.com using ISPsystem DNS API:

#### 1) Clone this repo and set the API key
```bash
git clone https://github.com/CyberFazaN/certbot-dnsmanager-hooks && cd ./certbot-dnsmanager-hooks
```

#### 2) Edit access settings

Get the parameters in your control panel or in your provider's billing system (*see note for firstvds.ru in the start of README*).

```bash
nano ./config.sh
```

#### 3) Install CertBot from repo
```bash
sudo apt update && sudo apt install certbot
```

#### 4) Generate wildcard
```bash
sudo certbot certonly --manual-public-ip-logging-ok --agree-tos --email info@site.com --renew-by-default -d site.com -d *.site.com --manual --manual-auth-hook $PWD/auth-hook.sh --manual-cleanup-hook $PWD/cleanup.sh --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
```

#### 5) Force Renew
```bash
cd /path/to/certbot-dnsmanager-hooks
sudo certbot renew --force-renew --manual --manual-auth-hook $PWD/auth-hook.sh --manual-cleanup-hook $PWD/cleanup.sh --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
```
or
```bash
sudo certbot renew --force-renew --manual --manual-auth-hook /path/to/certbot-dnsmanager-hooks/auth-hook.sh --manual-cleanup-hook /path/to/certbot-dnsmanager-hooks/cleanup.sh --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
```
