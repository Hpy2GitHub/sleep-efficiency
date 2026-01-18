#!/bin/bash

# Configuration
BUILD_DIR="dist"
APACHE_DIR="/mnt/d/Apache/html/sandbox/sleep-efficiency"
#BACKUP_DIR="$APACHE_DIR.backup"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting deployment process...${NC}"

# Setup the Apache vite.config.ts
cp vite.apache vite.config.ts

# Clean previous build
echo -e "${YELLOW}Cleaning previous build...${NC}"
rm -rf "$BUILD_DIR"

# Build the application
echo -e "${YELLOW}Building application...${NC}"
npm run build

# Check if build was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed! Check errors above.${NC}"
    exit 1
fi

echo -e "${GREEN}Build successful!${NC}"

# Create backup of existing deployment
#if [ -d "$APACHE_DIR" ]; then
#    echo -e "${YELLOW}Creating backup of existing deployment...${NC}"
#    sudo rm -rf "$BACKUP_DIR"
#    sudo mv "$APACHE_DIR" "$BACKUP_DIR"
#fi

# Create Apache directory
echo -e "${YELLOW}Creating deployment directory...${NC}"
sudo mkdir -p "$APACHE_DIR"

# Copy built files to Apache directory
echo -e "${YELLOW}Copying files to Apache directory...${NC}"
sudo cp -r "$BUILD_DIR"/* "$APACHE_DIR/"

# Copy the favicon
sudo cp  "favicon.ico" "$APACHE_DIR/."

# Create .htaccess for client-side routing
echo -e "${YELLOW}Copying .htaccess for routing...${NC}"
cp htaccess.txt $APACHE_DIR/.htaccess

# Set proper permissions
echo -e "${YELLOW}Setting permissions...${NC}"
sudo chown -R www-data:www-data "$APACHE_DIR"
sudo chmod -R 755 "$APACHE_DIR"

# Restore vite.config.ts for local development
cp vite.npm vite.config.ts

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Deployment complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo -e "Deployed to: ${YELLOW}$APACHE_DIR${NC}"
#echo -e "Backup saved at: ${YELLOW}$BACKUP_DIR${NC}"
echo -e ""
echo -e "To rollback if needed:"
echo -e "  sudo rm -rf $APACHE_DIR"
#echo -e "  sudo mv $BACKUP_DIR $APACHE_DIR"

cp  vite.npm vite.config.ts
