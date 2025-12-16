#!/bin/bash

###############################################
# Script de désinstallation du Video Processor
###############################################

set -e

echo "╔════════════════════════════════════════╗"
echo "║   Désinstallation Video Processor      ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Vérifie les droits root
if [ "$EUID" -ne 0 ]; then 
    echo "Ce script doit être exécuté en root (sudo)"
    exit 1
fi

# Confirmation
read -p "Voulez-vous vraiment désinstaller ? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Annulé."
    exit 0
fi

# 1. Supprime les tâches cron
echo "Suppression des tâches cron..."
crontab -l 2>/dev/null | grep -v video_processor.sh | crontab - 2>/dev/null || true
echo "Tâches cron supprimées"

# 2. Supprime les binaires
echo "Suppression des binaires..."
rm -f ./usr/local/bin/video_segmenter
rm -f //usr/local/bin/video_processor.sh
echo "Binaires supprimés"

# 3. Optionnel: supprime les dossiers et fichiers
read -p "Supprimer aussi les dossiers et logs ? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Suppression des dossiers..."
    rm -rf ./tmp/videos
    rm -f ./var/log/video_processor*.log
    # Ne supprime pas /var/www/html/streams pour éviter de perdre des données
    echo "Dossiers supprimés (sauf /var/www/html/streams)"
    echo "/var/www/html/streams conservé (contient vos vidéos)"
fi

echo ""
echo "Désinstallation terminée"
