---
name: docker-containerization-setup
description: Complete Docker containerization setup for applications with best practices for development and production
model: opus
date: 2025-09-28
---

# Docker Containerization Setup

You are a containerization expert who helps developers properly containerize applications using Docker best practices for security, performance, and maintainability.

## Purpose

Set up complete Docker containerization for applications including multi-stage builds, environment-specific configurations, security hardening, and orchestration setup. Ensure containers are production-ready with optimal performance and security.

## The Setup Prompt

### Complete Docker Containerization Setup

```
I need to containerize my application using Docker with best practices for development and production environments. Help me create a complete containerization setup.

**Application Details:**
- Application type: [web app/API/microservice/CLI tool/data processing/other]
- Primary language: [JavaScript/Python/Java/Go/C#/PHP/Ruby/other]
- Framework: [React/Vue/Django/Spring/Express/FastAPI/other]
- Runtime version: [Node 18/Python 3.11/Java 17/Go 1.21/other]
- Build requirements: [npm install/pip install/maven/gradle/other]

**Current Architecture:**
- Database: [PostgreSQL/MySQL/MongoDB/Redis/none]
- External services: [Redis/Elasticsearch/message queues/APIs]
- Static assets: [images/CSS/JS files/uploads]
- Background jobs: [Celery/cron jobs/workers/none]

**Infrastructure Requirements:**
- Deployment target: [local dev/Docker Compose/Kubernetes/AWS ECS/other]
- Environment count: [dev/staging/prod or specify]
- Scaling needs: [single instance/horizontal scaling/auto-scaling]
- Resource limits: [memory/CPU constraints]

**Security Requirements:**
- Security level: [development/production/enterprise]
- Compliance: [basic/GDPR/HIPAA/SOC2/other]
- Network access: [internal only/public facing/restricted]
- Secret management: [environment variables/Docker secrets/external vault]

**Performance Requirements:**
- Startup time: [target boot time]
- Image size: [size constraints or optimization priority]
- Resource usage: [memory/CPU efficiency requirements]
- Scaling speed: [how fast containers need to start]

**Development Workflow:**
- Team size: [solo/small team/large team]
- Development style: [local dev/remote dev/mixed]
- Hot reloading: [needed/not needed]
- Debugging: [remote debugging requirements]

Please help me configure:

1. **Dockerfile Optimization**
   - Create multi-stage Dockerfile for build and runtime
   - Implement layer caching optimization
   - Set up proper base image selection
   - Configure non-root user and security hardening
   - Optimize image size and startup time

2. **Development Environment**
   - Set up Docker Compose for local development
   - Configure volume mounts for hot reloading
   - Set up development database and dependencies
   - Configure debugging and development tools
   - Set up environment variable management

3. **Production Configuration**
   - Create production-optimized Dockerfile
   - Set up health checks and monitoring
   - Configure proper logging and observability
   - Set up resource limits and constraints
   - Implement security best practices

4. **Multi-Service Architecture**
   - Configure service discovery and networking
   - Set up inter-service communication
   - Configure load balancing and scaling
   - Set up shared volumes and data persistence
   - Configure backup and disaster recovery

5. **Security Hardening**
   - Implement least privilege containers
   - Set up secret management and rotation
   - Configure network security and isolation
   - Set up vulnerability scanning
   - Implement compliance requirements

6. **CI/CD Integration**
   - Set up automated image building
   - Configure image testing and scanning
   - Set up registry management and tagging
   - Configure deployment automation
   - Set up rollback and recovery procedures

7. **Monitoring & Observability**
   - Configure container metrics and logging
   - Set up health checks and readiness probes
   - Configure alerting and notifications
   - Set up distributed tracing (if applicable)
   - Configure performance monitoring

8. **Orchestration Setup**
   - Configure Kubernetes manifests (if applicable)
   - Set up Helm charts or Kustomize
   - Configure ingress and service mesh
   - Set up auto-scaling and resource management
   - Configure persistent volumes and storage

**Specific Requirements:**
[Any specific technologies, constraints, or requirements]

**Expected Deliverables:**
- Production-ready Dockerfile with multi-stage builds
- Docker Compose configuration for development
- Production deployment configuration (K8s/ECS/etc.)
- Environment-specific configuration files
- Security hardening implementation
- CI/CD pipeline integration
- Monitoring and logging setup
- Documentation and troubleshooting guide
- Performance optimization recommendations
- Team workflow and best practices guide

Please provide complete, production-ready containerization setup with all necessary configuration files and detailed explanations.
```

## Usage Examples

### Node.js Web Application
```
Application type: web app
Primary language: JavaScript
Framework: React + Express
Runtime version: Node 18
Database: PostgreSQL
Deployment target: Kubernetes
Environment count: dev, staging, prod
Team size: 8 developers
Security level: production
```

### Python API Microservice
```
Application type: API
Primary language: Python
Framework: FastAPI
Runtime version: Python 3.11
Database: PostgreSQL + Redis
External services: Elasticsearch
Deployment target: AWS ECS
Scaling needs: horizontal auto-scaling
Security level: enterprise
```

### Java Spring Boot Application
```
Application type: microservice
Primary language: Java
Framework: Spring Boot
Runtime version: Java 17
Build requirements: Maven
Database: MySQL
Deployment target: Kubernetes
Background jobs: Spring Scheduler
Compliance: SOC2
```

## Expected Outcomes

### Optimized Containers
- Small, fast-starting container images
- Multi-stage builds reducing final image size by 50-80%
- Proper layer caching for fast rebuilds
- Security-hardened containers with minimal attack surface

### Development Efficiency
- Hot reloading and fast feedback loops
- Easy local environment setup with Docker Compose
- Consistent development environment across team
- Integrated debugging and development tools

### Production Readiness
- Secure, non-root containers with proper permissions
- Health checks and graceful shutdown handling
- Proper logging and monitoring integration
- Resource limits and performance optimization

### Operational Excellence
- Automated container building and deployment
- Comprehensive monitoring and alerting
- Easy scaling and resource management
- Clear troubleshooting and maintenance procedures

## Implementation Notes

### Key Techniques Used
- **Multi-stage Builds**: Separate build and runtime stages for optimization
- **Security by Design**: Non-root users, minimal base images, vulnerability scanning
- **Configuration as Code**: All container configuration in version control
- **Observability**: Comprehensive logging, metrics, and health checks

### Why These Choices Work
- **Reduces Complexity**: Standardized containerization approach
- **Improves Security**: Built-in security best practices
- **Enhances Performance**: Optimized images and resource usage
- **Enables Scalability**: Ready for orchestration and auto-scaling

### Performance Benchmarks
- Image build time: < 5 minutes for most applications
- Container startup time: < 30 seconds
- Image size reduction: 50-80% vs naive containerization
- Resource efficiency: 20-40% better resource utilization

### Security Standards
- Non-root container execution
- Minimal base images (Alpine, Distroless)
- Regular vulnerability scanning
- Secure secret management
- Network isolation and least privilege access

---

**Date Created:** September 28, 2025
**Last Updated:** September 28, 2025