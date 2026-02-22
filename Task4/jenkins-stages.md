# Jenkins CI/CD Pipeline for Shopping Cart Application

This document describes a production-grade Jenkins pipeline for building, pushing, and deploying the 
**Shopping Cart Application** using Docker. 

---

## 1. Pipeline Stages

### 1.1 Checkout Code
- Pulls the latest code from the `master` branch of GitHub.
- Ensures Jenkins builds from the most recent codebase.

### 1.2 Build Docker Image
- Builds Docker image from the application’s `Dockerfile`.
- Tags images with both the Jenkins `BUILD_NUMBER` and `latest`.
- Enables traceability for versioned deployments.

### 1.3 Push to DockerHub
- Uses Jenkins credentials (`dockerhub-creds`) for authentication.
- Pushes both versioned and `latest` tags to DockerHub.
- Ensures images are available for remote deployment.

### 1.4 Deploy on Application Server
- SSH into the remote server using `ssh-agent` and pre-configured keys.
- Pulls the `latest` image from DockerHub.
- Stops running containers gracefully with `docker-compose down`.
- Starts updated containers with `docker-compose up -d`.
- Logs deployment completion and errors.

---

## 2. Deployment Strategy

- **CI/CD Automation:** Entire process from build to deployment is automated.
- **Docker-Based Containers:** Ensures consistency across environments.
- **Remote Deployment:** Secure SSH-based deployment on production server.
- **Versioning:** Each build is uniquely tagged, enabling tracking and rollback.
- **Zero-Downtime Considerations:** Graceful container stop/start reduces downtime.

> This strategy ensures fast, repeatable, and auditable deployments suitable for production-grade applications.

---

## 3. Rollback Approach 

In case the deployed version is unstable or fails post-deployment:

1. **Identify Previous Stable Image**
   - Images are tagged with Jenkins build numbers.
   - Use the last known stable build tag.

2. **Pull Previous Image**
```bash
docker pull neharote/task:<previous-build-number>
```

3. **Stop Current Containers**
```bash
docker-compose down
```

4. **Deploy Previous Version**
```bash
docker tag neharote/task:<previous-build-number> neharote/task:latest
docker-compose up -d
```

5. **Verify Application Stability**
- Check logs, services, and functionality.
- Notify stakeholders about rollback completion.

> Maintain all image tags and logs for accountability and audit purposes.



