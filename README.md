# CI/CD Pipeline test

## Workflow

- Build a simple Go http server
- Add basic tests
- Containerize it using Docker
- Run it using Docker Compose

## API

Minimal Go http server with one endpoing: GET /. Containerised using Docker.
```bash
Build Image:
docker build -t ci-cd-test-api:latest .

Run Container:
docker run --env_file api/.env -p 8000:8000 -d ci-cd-test-api:latest

Build and run using Docker compose:
docker compose up --build

Stop container:
docker stop ci-cd-test-api:latest
OR
docker compose down
```

Libraries used:
- net/http : HTTP server, Routing
- github.com/joho/godotenv : Reading environment variables