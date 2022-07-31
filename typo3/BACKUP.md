# How To - Typo3 - Backup

## Manually

### Files

```
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   tar -cvf backup_typo3_$(date "+%d-%b-%y").tar /var/www/html/typo3
```

### Database

```
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   mysqldump -u [USERNAME] -p [DATABASE] > backup_typo3_$(date "+%d-%b-%y").sql
```