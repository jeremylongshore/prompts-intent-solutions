---
name: cicd-pipeline-setup
description: Complete CI/CD pipeline configuration for automated testing, building, and deployment
model: opus
date: 2025-09-28
---

# CI/CD Pipeline Configuration Setup

You are a DevOps specialist who designs and implements robust CI/CD pipelines that automate software delivery with reliability, security, and efficiency.

## Purpose

Set up complete CI/CD pipelines for automated testing, building, security scanning, and deployment across multiple environments. Ensure code quality, security, and reliable deployments from development to production.

## The Setup Prompt

### Complete CI/CD Pipeline Configuration

```
I need to set up a complete CI/CD pipeline for my project. Help me configure automated testing, building, security scanning, and deployment.

**Project Information:**
- Repository platform: [GitHub/GitLab/Bitbucket/Azure DevOps]
- Project type: [web app/API/mobile app/library/microservices]
- Primary language: [JavaScript/Python/Java/Go/C#/PHP/Ruby/other]
- Framework: [React/Vue/Django/Spring Boot/Express/Next.js/other]
- Build tool: [npm/Maven/Gradle/pip/Cargo/Composer/other]

**Infrastructure Details:**
- Deployment target: [AWS/GCP/Azure/Heroku/Vercel/self-hosted]
- Container platform: [Docker/Kubernetes/Docker Compose/none]
- Database: [PostgreSQL/MySQL/MongoDB/DynamoDB/other]
- Environment count: [dev/staging/prod or specify custom environments]

**Current State:**
- Existing CI/CD: [none/basic/GitHub Actions/Jenkins/GitLab CI/other]
- Testing setup: [none/unit tests/integration tests/e2e tests]
- Deployment method: [manual/basic automation/fully automated]
- Team size: [solo/small team/large team]

**Pipeline Requirements:**
Please help me configure:

1. **Source Control Integration**
   - Set up branch protection rules and merge policies
   - Configure automated triggers for commits, PRs, and releases
   - Set up proper branching strategy (GitFlow, GitHub Flow, etc.)
   - Configure code review requirements and approval workflows

2. **Automated Testing Pipeline**
   - Configure unit test execution with coverage reporting
   - Set up integration testing for APIs and databases
   - Configure end-to-end testing for critical user flows
   - Set up performance and load testing
   - Configure test result reporting and notifications

3. **Code Quality & Security**
   - Set up static code analysis and linting
   - Configure security vulnerability scanning
   - Set up dependency vulnerability checks
   - Configure code coverage thresholds and reporting
   - Set up license compliance checking

4. **Build & Artifact Management**
   - Configure automated building for all environments
   - Set up artifact generation and storage
   - Configure container image building and registry
   - Set up build caching for faster execution
   - Configure build notifications and failure handling

5. **Deployment Automation**
   - Set up automated deployment to development environment
   - Configure staged deployment to staging/UAT
   - Set up production deployment with approval gates
   - Configure rollback mechanisms and health checks
   - Set up blue-green or canary deployment strategies

6. **Monitoring & Notifications**
   - Configure pipeline monitoring and alerting
   - Set up deployment success/failure notifications
   - Configure performance monitoring post-deployment
   - Set up log aggregation and error tracking
   - Configure uptime monitoring and alerting

7. **Environment Management**
   - Set up environment-specific configuration
   - Configure secrets and environment variable management
   - Set up infrastructure as code deployment
   - Configure database migrations and data seeding
   - Set up environment cleanup and cost optimization

**Security Requirements:**
- Secret management: [how to handle API keys, passwords, certificates]
- Compliance needs: [GDPR/HIPAA/SOC2/other requirements]
- Access controls: [who can deploy to what environments]
- Audit logging: [what needs to be tracked and logged]

**Performance Requirements:**
- Pipeline execution time: [target maximum duration]
- Deployment frequency: [daily/weekly/on-demand]
- Mean time to recovery: [target for fixing failed deployments]
- Success rate target: [acceptable failure rate]

**Expected Deliverables:**
- Complete CI/CD pipeline configuration files
- Step-by-step setup and configuration instructions
- Environment-specific deployment scripts
- Monitoring and alerting configuration
- Troubleshooting guide and runbooks
- Team workflow documentation
- Security best practices implementation
- Performance optimization recommendations

**Constraints:**
[Budget limits, technology restrictions, compliance requirements, etc.]

Please provide detailed configuration files and instructions for implementing this CI/CD pipeline.
```

## Usage Examples

### Web Application (React + Node.js)
```
Repository: GitHub
Project type: web app
Primary language: JavaScript
Framework: React + Node.js/Express
Build tool: npm
Deployment target: AWS (S3 + CloudFront + Lambda)
Container platform: Docker
Database: PostgreSQL on RDS
Environments: dev, staging, prod
Team size: 5 developers
```

### Microservices (Python + Kubernetes)
```
Repository: GitLab
Project type: microservices
Primary language: Python
Framework: FastAPI
Build tool: pip + Docker
Deployment target: GCP (GKE)
Container platform: Kubernetes
Database: PostgreSQL + Redis
Environments: dev, test, staging, prod
Team size: 15 developers
```

### Mobile App CI/CD
```
Repository: GitHub
Project type: mobile app
Primary language: JavaScript
Framework: React Native
Build tool: npm + Xcode/Gradle
Deployment target: App Store + Google Play
Container platform: none
Database: Firebase
Environments: dev, staging, prod
Team size: 3 developers
```

## Expected Outcomes

### Automated Quality Assurance
- All code changes automatically tested before deployment
- Security vulnerabilities caught early in development
- Code quality metrics enforced consistently
- Performance regressions detected automatically

### Reliable Deployments
- Zero-downtime deployments with rollback capability
- Consistent deployments across all environments
- Automated health checks and monitoring
- Fast recovery from deployment failures

### Developer Productivity
- Fast feedback loops for code changes
- Automated repetitive tasks
- Clear visibility into pipeline status
- Easy debugging of pipeline failures

### Security & Compliance
- Secrets properly managed and rotated
- Security scanning integrated into pipeline
- Audit trails for all deployments
- Compliance requirements automatically enforced

## Implementation Notes

### Key Techniques Used
- **Pipeline as Code**: All pipeline configuration in version control
- **Infrastructure as Code**: Environment setup automated
- **Security by Design**: Security checks integrated throughout
- **Observability**: Comprehensive monitoring and alerting

### Why These Choices Work
- **Reduces Human Error**: Automation eliminates manual deployment mistakes
- **Increases Velocity**: Developers can focus on features, not deployment
- **Improves Quality**: Automated testing catches issues early
- **Enhances Security**: Consistent security practices across all deployments

### Performance Benchmarks
- Pipeline execution time: < 15 minutes for most projects
- Deployment frequency: Multiple times per day capability
- Mean time to recovery: < 30 minutes
- Pipeline success rate: > 95%

---

**Date Created:** September 28, 2025
**Last Updated:** September 28, 2025