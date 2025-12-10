# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci  # installs both dev & prod here (needed for build if you have build scripts)

COPY . .
# RUN npm run build   # if you have a build step

# Production stage
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force
COPY --from=builder /app .   # copy only built files if needed
CMD ["node", "server.js"]    # or whatever your start command is