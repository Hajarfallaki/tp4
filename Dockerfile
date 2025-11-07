# Image de base nginx
FROM nginx:alpine

# Copier le fichier HTML dans nginx
COPY index.html /usr/share/nginx/html/index.html

# Exposer le port 80
EXPOSE 80

# Commande de démarrage
CMD ["nginx", "-g", "daemon off;"]