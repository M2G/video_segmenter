# Video Segmenter - HLS

Outil de segmentation vidéo pour streaming HLS (HTTP Live Streaming).

## Description

Ce programme découpe une vidéo en segments MPEG-TS et génère une playlist M3U8 compatible avec le standard HLS d'Apple.

## Installation

### macOS (Homebrew)

```bash
# Installer FFmpeg avec les bibliothèques de développement
brew install ffmpeg

# Compiler le programme
make
```

### Linux (Ubuntu/Debian)

```bash
# Installer les dépendances FFmpeg
sudo apt-get update
sudo apt-get install libavformat-dev libavcodec-dev libavutil-dev

# Compiler le programme
make
```

## Utilisation

1. Rendez les scripts exécutables

```bash
chmod +x install.sh video_processor.sh
```

2. Installez (nécessite sudo)

```bash
sudo ./install.sh
```

3. Installez (nécessite sudo)

```bash
Vérifiez l'installation
```

Test manuel (traite une fois)

```bash
/usr/local/bin/video_processor.sh
```

Mode surveillance continue (boucle)

```bash
/usr/local/bin/video_processor.sh watch
```

Déposer une vidéo pour test

```bash
cp ma_video.mp4 /tmp/videos/
```

Voir les logs en direct

```bash
tail -f /var/log/video_processor.log
```

Nettoyer les anciens fichiers (>7 jours)

```bash
/usr/local/bin/video_processor.sh cleanup 7
```

Voir les tâches cron

```bash
crontab -l
```

### Paramètres

- `input_file` : Fichier vidéo source (mp4, mkv, avi, etc.)
- `output_dir` : Répertoire de sortie pour les segments
- `index_file` : Nom du fichier playlist M3U8
- `base_name` : Préfixe des fichiers segments
- `extension` : Extension des segments (généralement `.ts`)
- `segment_duration` : Durée de chaque segment en secondes
- `max_segments` : (optionnel) Nombre max de segments dans la playlist (0 = illimité)

## Structure de sortie

Après exécution, vous obtiendrez :

```
/tmp/videos/                 Dossier surveillé (déposez vos MP4 ici)
├── processing/          Vidéos en cours de traitement
├── done/                Vidéos traitées avec succès
└── error/               Vidéos en erreur

/var/www/html/streams/     Dossier de sortie
├── nom_video/
├── segment-1.ts
├── segment-2.ts
├── ...
├── nom_video.m3u8
└── info.txt
```

Le fichier `output.m3u8` référence tous les segments et peut être lu par n'importe quel lecteur HLS.

## Lecture des segments

### Avec FFplay
```bash
ffplay output/output.m3u8
```
## Nettoyage

```bash
# Supprimer les fichiers compilés
make clean

# Supprimer les segments générés
rm -rf output/
```