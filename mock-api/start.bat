@echo off

set PWD=%~dp0
cd "%PWD%"

type "banner.txt" 2>nul

set API_PORT=8080

docker-compose down
docker-compose up
