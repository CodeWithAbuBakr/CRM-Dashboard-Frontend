# Frontend Dockerfile

# Use a Node.js image to build the frontend
FROM node:16-alpine AS builder

# Create app directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the frontend code and build the app
COPY . .
RUN npm run build

# Serve the frontend with a lightweight web server
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the frontend port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
