# Stage 1: Build & Run
FROM node:20-alpine

# Security: OS packages ko update aur upgrade karo
RUN apk update && apk upgrade

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy the rest of the application
COPY . .

# Expose the backend port
EXPOSE 8080

# Start the server
CMD ["node", "server.js"]
