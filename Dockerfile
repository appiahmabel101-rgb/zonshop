# Ultra-small Dockerfile that works on Render free tier every single time
FROM node:20-alpine

WORKDIR /app

# 1. Copy only package files
COPY package*.json ./

# 2. THIS IS THE MAGIC LINE — installs prod only + cleans aggressively in one layer
RUN npm ci --omit=dev --prefer-offline --no-audit --progress=false \
    && npm cache clean --force \
    && rm -rf /var/cache/apk/* /tmp/* /root/.npm/_cacache || true

# 3. Copy the rest of your (now tiny) app
COPY . .

# 4. Start command (change if yours is different)
CMD ["npm", "start"]
