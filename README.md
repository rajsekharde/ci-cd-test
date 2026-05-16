# CI/CD Pipeline test

## Workflow

Initial project setup
- Build a simple Go http server
- Add basic tests
- Containerize it using Docker
- Run it using Docker Compose
- Push the image to Docker hub
- Launch a new EC2 instance and install docker, docker compose on it
- Copy docker-compose.prod.yml file into it
- Pull the image from Docker hub to the instance
- Create a .env having contents: API_KEY=8000
- Run the container using docker compose and test the endpoint

CI pipeline setup
- Create .github/workflows/ci.yml
- Add the CI script to build, test and push image
- Add new secrets to GitHub repository: docker username and password
- Commit and push code. Github actions runs script automatically. Runs tests, builds image and pushes it to docker hub


## API

Minimal Go http server with one endpoint: GET /. Containerised using Docker.
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

Tag image:
docker tag ci-cd-test-api:latest {username}/ci-cd-test-api:latest

Push image to docker hub:
docker push {username}/ci-cd-test-api:latest

Pull image from docker hub to a different machine:
docker pull {username}/ci-cd-test-api:latest
```

Libraries used:
- net/http : HTTP server, Routing
- github.com/joho/godotenv : Reading environment variables

## EC2 Instance

The app will be hosted on an AWS EC2 instance with Ubuntu OS and amd64 architecture.

```bash
Make the scripts executable:
chmod +x scripts/*.sh

Launch instance:
./scripts/ec2-launch.sh
Returns the instance ID and public IPv4 address

Copy files to the instance:
scp -i <key-pair .pem file> ./scripts/ec2-setup.sh <user>@<public IPv4 address>:/home/ubuntu/ec2-setup.sh
scp -i <key-pair .pem file> ./docker-compose.prod.yml <user>@<public IPv4 address>:/home/ubuntu/docker-compose.prod.yml

SSH into the instance:
ssh -i <key-pair .pem file> <user>@<public IPv4 address>

Set up instance and install git, docker, docker compose:
chmod +x ec2-setup.sh
sudo ./ec2-setup.sh

Stop instance:
./scripts/ec2-stop.sh

Terminate instance:
./scripts/ec2-terminate.sh
```