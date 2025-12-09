############################################
# Crontab pour le traitement vidéo
############################################

# Option 1: Vérification toutes les 5 minutes
#*/5 * * * * /usr/local/bin/video_processor.sh >> /var/log/video_processor_cron.log 2>&1
*/5 * * * * ./usr/local/bin/video_processor.sh >> ./var/log/video_processor_cron.log 2>&1

# Option 2: Vérification toutes les minutes (plus réactif)
# * * * * * /usr/local/bin/video_processor.sh >> /var/log/video_processor_cron.log 2>&1

# Option 3: Toutes les 30 secondes (nécessite 2 entrées)
# * * * * * /usr/local/bin/video_processor.sh >> /var/log/video_processor_cron.log 2>&1
# * * * * * sleep 30 && /usr/local/bin/video_processor.sh >> /var/log/video_processor_cron.log 2>&1

# Nettoyage hebdomadaire des anciens fichiers (dimanche à 3h)
#0 3 * * 0 /usr/local/bin/video_processor.sh cleanup 7
0 3 * * 0 ./usr/local/bin/video_processor.sh cleanup 7

# Rotation des logs (premier du mois à 4h)
#0 4 1 * * find /var/log -name "video_processor*.log" -size +100M -exec gzip {} \;
0 4 1 * * find ./var/log -name "video_processor*.log" -size +100M -exec gzip {} \;

############################################
# Installation de cette crontab :
# crontab -e
############################################
