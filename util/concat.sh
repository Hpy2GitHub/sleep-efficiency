#!/usr/bin/bash
files="README.md deploy.sh  dist/index.html dist/vite.svg eslint.config.js index.html package-lock.json package.json public/vite.svg src/App.css src/App.tsx src/assets/react.svg src/index.css src/main.tsx tsconfig.app.json tsconfig.json vite.apache vite.config.ts vite.npm dist/assets/*"
>$rhd/project-contents.txt
for i in $files
do
    echo "==============="
    echo " FILE: $i"
    echo "==============="
    cat $i
done >>$rhd/project-contents.txt
