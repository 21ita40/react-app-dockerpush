# Stage 1: Build React application
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React application using Nginx
FROM nginx:alpine

# Copy the built React app from the previous stage into the Nginx server directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to start Nginx and serve the React app
CMD ["nginx", "-g", "daemon off;"]
