# Imagem base oficial e enxuta
FROM node:20-alpine

# Diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos de dependências e instala
COPY package*.json ./
RUN npm ci --only=production

# Copia o restante do código da aplicação
COPY . .

# Porta exposta e comando de inicialização
EXPOSE 8080
CMD ["node", "src/index.js"]