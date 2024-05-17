# Temel image olarak resmi Node.js image'ını kullanın
FROM node:14

# Çalışma dizinini belirleyin
WORKDIR /usr/src/app

# package.json ve package-lock.json dosyalarını çalışma dizinine kopyalayın
COPY package*.json ./

# Bağımlılıkları yükleyin
RUN npm install

# Uygulama kodunuzu kopyalayın
COPY . .

# Uygulamanın çalışacağı portu belirleyin
EXPOSE 3000

# Uygulamanızı çalıştırın
CMD ["node", "app.js"]
