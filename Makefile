# Nom du programme final
TARGET = video_segmenter

# Fichiers source
SOURCES = video_segmenter.c

# Compilateur C
CC = gcc

# Flags de compilation
CFLAGS = -Wall -Wextra -O2

# Flags pour lier FFmpeg (détection automatique avec pkg-config)
LDFLAGS = $(shell pkg-config --libs libavformat libavcodec libavutil)
CFLAGS += $(shell pkg-config --cflags libavformat libavcodec libavutil)

# Règle par défaut : compile le programme
all: $(TARGET)

# Compilation du programme
$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES) $(LDFLAGS)
	@echo "Compilation réussie : ./$(TARGET)"

# Nettoyage des fichiers compilés
clean:
	rm -f $(TARGET)
	@echo "Nettoyage terminé"

# Exemple d'utilisation
example: $(TARGET)
	@echo "Création du répertoire de test..."
	@mkdir -p test_output
	@echo "Lancement de l'exemple (nécessite un fichier test.mp4):"
	@echo "./$(TARGET) test.mp4 test_output output.m3u8 segment .ts 10"

# Affiche l'aide
help:
	@echo "Makefile pour Video Segmenter"
	@echo ""
	@echo "Commandes disponibles:"
	@echo "  make          - Compile le programme"
	@echo "  make clean    - Supprime les fichiers compilés"
	@echo "  make example  - Montre un exemple d'utilisation"
	@echo "  make help     - Affiche cette aide"

.PHONY: all clean example help