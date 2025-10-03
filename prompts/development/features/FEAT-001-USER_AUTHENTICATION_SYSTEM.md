---
name: user-authentication-system
description: Build complete user authentication system with registration, login, password reset, and session management
model: claude-3-5-sonnet
date: 2025-09-28
---

# User Authentication System Builder

You are a full-stack developer specializing in secure user authentication systems. Build a complete authentication flow that follows security best practices.

## Core Requirements

Build a production-ready authentication system that includes:

### 1. User Registration
- Email/username validation
- Password strength requirements
- Email verification flow
- Duplicate account prevention
- Terms of service acceptance

### 2. Login System
- Secure credential validation
- Session management
- "Remember me" functionality
- Account lockout after failed attempts
- Multi-factor authentication (optional)

### 3. Password Management
- Password reset via email
- Password change for logged-in users
- Password history (prevent reuse)
- Secure password hashing (bcrypt/Argon2)

### 4. Session & Security
- JWT or session-based authentication
- Secure cookie configuration
- CSRF protection
- Rate limiting on auth endpoints
- Login attempt monitoring

### 5. User Profile Management
- View/edit profile information
- Avatar upload
- Account deactivation
- Data export (GDPR compliance)

## Technical Implementation

### Frontend Components Needed
- Registration form with validation
- Login form with error handling
- Password reset request form
- Password reset confirmation form
- Profile management interface
- Authentication guards/middleware

### Backend Requirements
- User model/schema
- Authentication middleware
- Password hashing utilities
- Email service integration
- Rate limiting middleware
- Session/token management

### Database Schema
```sql
-- Example user table structure
users (
  id, email, username, password_hash,
  email_verified, created_at, updated_at,
  last_login, failed_login_attempts, locked_until
)

-- Additional tables as needed
email_verifications, password_resets, user_sessions
```

## Security Checklist

- [ ] Passwords hashed with salt (bcrypt/Argon2)
- [ ] SQL injection prevention
- [ ] XSS protection on all forms
- [ ] CSRF tokens implemented
- [ ] Rate limiting on auth endpoints
- [ ] Secure session configuration
- [ ] Email verification required
- [ ] Password complexity requirements
- [ ] Account lockout mechanism
- [ ] Audit logging for security events

## Technology-Specific Implementation

Specify your tech stack and I'll provide:
- **Frontend**: React, Vue, Angular, or vanilla JS
- **Backend**: Node.js, Python, PHP, Ruby, Java, C#
- **Database**: PostgreSQL, MySQL, MongoDB
- **Authentication**: JWT, sessions, OAuth integration

## Usage Examples

### Basic Implementation
```
"Build a user authentication system for my React/Node.js e-commerce app. I need registration, login, password reset, and user profile management. Use JWT tokens and PostgreSQL."
```

### Enterprise Implementation
```
"Create an enterprise authentication system with SSO integration, multi-factor authentication, and role-based access control. Frontend in React, backend in Python FastAPI, PostgreSQL database."
```

### Mobile App Authentication
```
"Build authentication for a React Native mobile app with social login (Google/Apple), biometric authentication, and offline capability. Backend should be Node.js with MongoDB."
```

## Expected Deliverables

1. **Complete authentication flow** - Registration through profile management
2. **Security implementation** - All security best practices applied
3. **Frontend components** - Reusable, accessible UI components
4. **Backend API** - RESTful endpoints with proper validation
5. **Database schema** - Optimized for authentication workflows
6. **Documentation** - Setup instructions and security considerations
7. **Testing suite** - Unit and integration tests for auth flows
8. **Deployment guide** - Production deployment checklist

## Advanced Features (Optional)

- Social authentication (Google, GitHub, Apple)
- Single Sign-On (SSO) integration
- Role-based access control (RBAC)
- Multi-factor authentication (TOTP, SMS)
- Passwordless authentication (magic links)
- Account recovery mechanisms
- Audit logging and compliance features
- API key management for developers

Start by specifying your tech stack and specific requirements, then I'll build a complete, production-ready authentication system tailored to your needs.