# CI/CD Pipeline test

## API

Minimal Go http server with one endpoing: GET /. Containerised using Docker.
```bash
Build Image:
docker build -t ci-cd-test-api:latest

Run Container:
docker run -p 8000:8000 -d ci-cd-test-api:latest
```

Libraries used:
- net/http : HTTP server, Routing