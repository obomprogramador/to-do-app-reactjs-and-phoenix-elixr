FROM node:22

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 5173

# CMD ["sleep", "infinity"]