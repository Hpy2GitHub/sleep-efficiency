#!/bin/bash

# Configuration
BUILD_DIR="dist"
GITHUB_BRANCH="gh-pages"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting GitHub Pages deployment...${NC}"

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

# Deploy to GitHub Pages
echo -e "${YELLOW}Deploying to GitHub Pages...${NC}"
npx gh-pages -d "$BUILD_DIR"

# Check if deployment was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Deployment failed! Check errors above.${NC}"
    exit 1
fi

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Deployment complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo -e "Your site will be available at your GitHub Pages URL shortly"

