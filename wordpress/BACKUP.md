# How To - Wordpress - Backup

## Manually

### Files

```
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   tar -cvf backup_wordpress_$(date "+%d-%b-%y").tar /var/www/html/wordpress
```

### Database

```
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   mysqldump -u [USERNAME] -p [DATABASE] > backup_wordpress_$(date "+%d-%b-%y").sql
```

## via Plugin

- #### [UpdraftPlus](https://de.wordpress.org/plugins/updraftplus/)
- #### [BackWPup](https://de.wordpress.org/plugins/backwpup/)
- #### [VaultPress](https://de.wordpress.org/plugins/vaultpress/)

## Export Data (no Backup!)

![Screenshot-1](/files/wordpress_export.jpg)