# Stage 1: Build the React app
FROM node:14-alpine AS react-build

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Stage 2: Serve the React build using a lightweight Node.js server
FROM node:14-alpine AS node-server

WORKDIR /app

COPY --from=react-build /app/build ./build
COPY package*.json ./
RUN npm install express
COPY server.js ./

EXPOSE 3000
CMD ["node", "server.js"]
