# Security Policy

## 🔒 Supported Versions

We actively support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| main    | ✅ Yes             |
| v1.x.x  | ✅ Yes             |
| < 1.0   | ❌ No              |

## 🚨 Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report security vulnerabilities by emailing:
📧 **jeremy@intentlabs.co**

### What to Include

Please include the following information in your report:

- **Description** of the vulnerability
- **Steps to reproduce** the issue
- **Potential impact** of the vulnerability
- **Suggested fix** (if you have one)
- **Your contact information** for follow-up

### Response Process

1. **Acknowledgment**: We'll acknowledge receipt within **24 hours**
2. **Investigation**: We'll investigate and provide an initial assessment within **72 hours**
3. **Updates**: We'll keep you informed of our progress at least every **5 business days**
4. **Resolution**: We'll work with you to resolve the issue promptly

### Timeline Expectations

| Severity | Response Time | Resolution Target |
|----------|---------------|-------------------|
| Critical | 24 hours      | 7 days            |
| High     | 48 hours      | 14 days           |
| Medium   | 72 hours      | 30 days           |
| Low      | 5 days        | 60 days           |

## 🛡️ Security Best Practices

### For Contributors

- **Never commit secrets** (API keys, passwords, tokens) to the repository
- **Review dependencies** for known vulnerabilities
- **Use semantic versioning** for security-related changes
- **Update documentation** when fixing security issues

### For Users

- **Keep updated** to the latest version
- **Review prompt templates** before using in production environments
- **Sanitize inputs** when using templates with external systems
- **Report issues** promptly if you discover vulnerabilities

## 🔍 Vulnerability Disclosure

### Our Commitment

- We will investigate all legitimate reports
- We will not pursue legal action against researchers acting in good faith
- We will provide credit to researchers (unless they prefer anonymity)
- We will maintain transparency about security issues (after resolution)

### Hall of Fame

We maintain a list of security researchers who have helped improve our security:

<!-- This section will be updated when we receive security reports -->
*No security issues reported yet. Be the first to help us improve!*

## 📋 Security Checklist

### For New Features
- [ ] Input validation implemented
- [ ] No hardcoded secrets
- [ ] Proper error handling (no information leakage)
- [ ] Security implications documented

### For Dependencies
- [ ] Dependencies regularly updated
- [ ] Security advisories monitored
- [ ] Known vulnerabilities addressed

### For Releases
- [ ] Security changelog included
- [ ] Breaking changes documented
- [ ] Migration guide provided (if needed)

## 🔗 Security Resources

- [GitHub Security Advisories](https://github.com/jeremylongshore/prompts-intent-solutions/security/advisories)
- [Conventional Commits for Security](https://www.conventionalcommits.org/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)

## 📞 Contact Information

**Security Contact**: jeremy@intentlabs.co
**Response Team**: Jeremy Longshore ([@jeremylongshore](https://github.com/jeremylongshore))

---

**We take security seriously and appreciate your help in keeping our project secure.** 🔒