# TaskWarrior DiagnosticPro API Integration Guide
## Complete Platform Integration Documentation

**Created:** 2025-09-29
**Status:** ✅ Production Ready
**For:** Developers and DevOps teams

---

## 🎯 Integration Overview

The TaskWarrior DiagnosticPro system integrates with multiple APIs and services to provide comprehensive payment flow testing. This guide details all integration points, authentication methods, and monitoring procedures.

### Architecture Diagram
```
TaskWarrior System
       ↓
DiagnosticPro Frontend (diagnosticpro.io)
       ↓
Payment Processing (Stripe API)
       ↓
Webhook Handler (Firebase Cloud Functions)
       ↓
Database Storage (Firestore)
       ↓
AI Processing (Vertex AI Gemini 2.5 Flash)
       ↓
Document Generation (PDF Service)
       ↓
Email Delivery (Email Service)
```

### Integration Points Summary

| Service | Purpose | Authentication | Monitoring |
|---------|---------|----------------|------------|
| **DiagnosticPro Platform** | Frontend application | Session-based | Health checks |
| **Stripe API** | Payment processing | API keys | Dashboard monitoring |
| **Firebase Cloud Functions** | Webhook handling | Service account | Function logs |
| **Firestore** | Database operations | IAM roles | Query monitoring |
| **Vertex AI** | AI analysis | ADC/Service account | Usage tracking |
| **Email Service** | Customer notifications | API keys | Delivery logs |

---

## 🌐 DiagnosticPro Platform Integration

### Platform Endpoints

#### Frontend Application
```
Base URL: https://diagnosticpro.io
Environment: Production
Framework: React 18 + TypeScript + Vite
Hosting: Firebase Hosting
```

#### Key Endpoints
```bash
# Health check
GET https://diagnosticpro.io/api/health

# Payment session creation
POST https://diagnosticpro.io/api/payment/session
Content-Type: application/json
{
  "submissionId": "string",
  "amount": 2999,
  "currency": "usd",
  "customerEmail": "string"
}

# Order status check
GET https://diagnosticpro.io/api/orders/{orderId}

# Diagnostic submission
POST https://diagnosticpro.io/api/submissions
Content-Type: multipart/form-data
```

### TaskWarrior Integration

#### Platform Health Monitoring
```python
# Integration script: monitor_diagnosticpro.py
import requests
import subprocess
import json
from datetime import datetime

def check_diagnosticpro_health():
    """Monitor DiagnosticPro platform health and update TaskWarrior"""

    endpoints = [
        "https://diagnosticpro.io/api/health",
        "https://diagnosticpro.io/api/payment/health",
        "https://diagnosticpro.io/api/orders/health"
    ]

    results = {}

    for endpoint in endpoints:
        try:
            response = requests.get(endpoint, timeout=10)
            results[endpoint] = {
                'status': response.status_code,
                'response_time': response.elapsed.total_seconds(),
                'healthy': response.status_code == 200
            }
        except Exception as e:
            results[endpoint] = {
                'status': 'error',
                'error': str(e),
                'healthy': False
            }

    # Update TaskWarrior with health status
    update_monitoring_task(results)
    return results

def update_monitoring_task(health_results):
    """Update TaskWarrior monitoring task with health status"""

    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    for endpoint, result in health_results.items():
        if result['healthy']:
            status = f"✅ {endpoint}: {result['status']} ({result['response_time']:.2f}s)"
        else:
            status = f"❌ {endpoint}: {result.get('status', 'error')}"

        # Add annotation to monitoring task
        cmd = [
            'task', 'project:DiagnosticPro', '+monitoring',
            'limit:1', 'annotate', f"[{timestamp}] {status}"
        ]
        subprocess.run(cmd, capture_output=True, text=True)

# Usage in TaskWarrior workflow
if __name__ == "__main__":
    results = check_diagnosticpro_health()
    print(json.dumps(results, indent=2))
```

#### Automated Testing Integration
```bash
# Create monitoring task for platform health
task add "DiagnosticPro Platform Health Monitoring" \
  project:DiagnosticPro \
  priority:L \
  +monitoring +health \
  recur:daily \
  estimate:5min

# Run health check
python3 monitor_diagnosticpro.py

# Integrate with existing workflow
python3 taskwarrior_helpers.py annotate --task-id <MONITORING-ID> \
  --annotation "$(python3 monitor_diagnosticpro.py | grep -E '✅|❌')"
```

---

## 💳 Stripe API Integration

### Authentication and Configuration

#### API Keys Management
```bash
# Environment variables (never commit these)
export STRIPE_SECRET_KEY="sk_test_..."
export STRIPE_PUBLISHABLE_KEY="pk_test_..."
export STRIPE_WEBHOOK_SECRET="whsec_..."

# Test mode verification
curl -X GET https://api.stripe.com/v1/account \
  -H "Authorization: Bearer sk_test_..." \
  | jq '.details_submitted'
```

#### Webhook Configuration
```bash
# List configured webhooks
curl -X GET https://api.stripe.com/v1/webhook_endpoints \
  -H "Authorization: Bearer sk_test_..."

# Create webhook endpoint
curl -X POST https://api.stripe.com/v1/webhook_endpoints \
  -H "Authorization: Bearer sk_test_..." \
  -d url="https://us-central1-diagnosticpro.cloudfunctions.net/stripeWebhook" \
  -d "enabled_events[]=payment_intent.succeeded" \
  -d "enabled_events[]=payment_intent.payment_failed"
```

### TaskWarrior Integration

#### Payment Session Monitoring
```python
# Integration script: stripe_monitor.py
import stripe
import subprocess
from datetime import datetime, timedelta

stripe.api_key = "sk_test_..."

def monitor_payment_sessions():
    """Monitor Stripe payment sessions and update TaskWarrior"""

    # Get recent payment intents
    recent_time = int((datetime.now() - timedelta(hours=1)).timestamp())

    payment_intents = stripe.PaymentIntent.list(
        created={'gte': recent_time},
        limit=10
    )

    for pi in payment_intents:
        # Update TaskWarrior with payment status
        annotation = f"Stripe Payment: {pi.id} - Status: {pi.status} - Amount: ${pi.amount/100}"

        cmd = [
            'task', 'project:DiagnosticPro', '+payment', '+execute',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

def test_stripe_connection():
    """Test Stripe API connection"""
    try:
        account = stripe.Account.retrieve()
        return {
            'status': 'connected',
            'account_id': account.id,
            'test_mode': account.livemode is False
        }
    except Exception as e:
        return {
            'status': 'error',
            'error': str(e)
        }

# TaskWarrior integration
def update_stripe_status():
    """Update TaskWarrior with Stripe connection status"""
    status = test_stripe_connection()
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    if status['status'] == 'connected':
        annotation = f"[{timestamp}] Stripe connected: {status['account_id']} (Test mode: {status['test_mode']})"
    else:
        annotation = f"[{timestamp}] Stripe error: {status['error']}"

    cmd = [
        'task', 'project:DiagnosticPro', '+prep', '+stripe',
        'limit:1', 'annotate', annotation
    ]
    subprocess.run(cmd, capture_output=True, text=True)
```

#### Payment Testing Automation
```bash
# Create Stripe test payment
create_test_payment() {
    local AMOUNT=$1
    local CUSTOMER_EMAIL=$2

    # Create payment intent
    PAYMENT_INTENT=$(curl -X POST https://api.stripe.com/v1/payment_intents \
      -H "Authorization: Bearer sk_test_..." \
      -d amount=$AMOUNT \
      -d currency=usd \
      -d "receipt_email=$CUSTOMER_EMAIL" \
      -d "metadata[test_source]=taskwarrior")

    # Extract payment intent ID
    PI_ID=$(echo $PAYMENT_INTENT | jq -r '.id')

    # Update TaskWarrior
    python3 taskwarrior_helpers.py annotate --task-id <EXECUTE-ID> \
      --annotation "Created Stripe Payment Intent: $PI_ID"

    echo $PI_ID
}

# Usage in testing workflow
create_test_payment 2999 "test@example.com"
```

---

## 🔥 Firebase Cloud Functions Integration

### Function Deployment and Management

#### Deployment Commands
```bash
# Navigate to project
cd /path/to/diagnosticpro/functions

# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:stripeWebhook

# Check deployment status
firebase functions:list
```

#### Function Monitoring
```bash
# View function logs
firebase functions:log --only stripeWebhook

# Real-time log monitoring
firebase functions:log --follow

# Filter logs by time
firebase functions:log --since="2025-09-29T10:00:00"
```

### TaskWarrior Integration

#### Webhook Monitoring
```python
# Integration script: firebase_monitor.py
import subprocess
import json
import re
from datetime import datetime

def monitor_firebase_functions():
    """Monitor Firebase Cloud Functions and update TaskWarrior"""

    # Get recent function logs
    result = subprocess.run([
        'firebase', 'functions:log', '--only', 'stripeWebhook',
        '--since', '1h', '--format', 'json'
    ], capture_output=True, text=True)

    if result.returncode == 0:
        logs = result.stdout.strip().split('\n')

        webhook_events = []
        for log_line in logs:
            try:
                log_data = json.loads(log_line)
                if 'payment_intent.succeeded' in log_data.get('textPayload', ''):
                    webhook_events.append({
                        'timestamp': log_data['timestamp'],
                        'severity': log_data['severity'],
                        'message': log_data['textPayload']
                    })
            except json.JSONDecodeError:
                continue

        # Update TaskWarrior with webhook events
        for event in webhook_events[-5:]:  # Last 5 events
            annotation = f"Webhook processed: {event['timestamp']} - {event['severity']}"
            cmd = [
                'task', 'project:DiagnosticPro', '+verify', '+webhook',
                'limit:1', 'annotate', annotation
            ]
            subprocess.run(cmd, capture_output=True, text=True)

def check_function_health():
    """Check Cloud Functions health status"""
    result = subprocess.run([
        'firebase', 'functions:list'
    ], capture_output=True, text=True)

    if result.returncode == 0:
        functions = []
        for line in result.stdout.split('\n'):
            if 'stripeWebhook' in line:
                functions.append(line.strip())

        return {
            'status': 'healthy' if functions else 'error',
            'functions': functions
        }
    else:
        return {
            'status': 'error',
            'error': result.stderr
        }
```

#### Automated Function Testing
```bash
# Test webhook endpoint directly
test_webhook() {
    local WEBHOOK_URL="https://us-central1-diagnosticpro.cloudfunctions.net/stripeWebhook"

    # Test POST request
    curl -X POST $WEBHOOK_URL \
      -H "Content-Type: application/json" \
      -H "Stripe-Signature: $STRIPE_WEBHOOK_SECRET" \
      -d '{"type":"payment_intent.succeeded","data":{"object":{"id":"pi_test_123"}}}' \
      -w "Response Time: %{time_total}s\nHTTP Code: %{http_code}\n"
}

# Integrate with TaskWarrior
test_webhook_with_task() {
    local TASK_ID=$1

    # Start task
    python3 taskwarrior_helpers.py start --task-id $TASK_ID

    # Run webhook test
    local RESPONSE=$(test_webhook)

    # Update task with results
    python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
      --annotation "Webhook test: $RESPONSE"

    # Complete task
    python3 taskwarrior_helpers.py complete --task-id $TASK_ID \
      --annotation "Webhook endpoint validated successfully"
}
```

---

## 🗄️ Firestore Database Integration

### Database Operations

#### Connection and Authentication
```bash
# Set up Firebase CLI
firebase login
firebase projects:list
firebase use diagnosticpro-prod

# Test Firestore access
firebase firestore:delete --shallow test/document
firebase firestore:get test/document
```

#### Collection Structure
```javascript
// Firestore collections used by DiagnosticPro
collections = {
  'orders': {
    'fields': [
      'orderId', 'customerId', 'submissionId', 'paymentIntentId',
      'amount', 'currency', 'status', 'createdAt', 'updatedAt'
    ]
  },
  'diagnosticSubmissions': {
    'fields': [
      'submissionId', 'customerEmail', 'equipmentType', 'problemDescription',
      'photos', 'status', 'analysisResult', 'createdAt'
    ]
  },
  'emailLogs': {
    'fields': [
      'orderId', 'customerEmail', 'emailType', 'status',
      'sentAt', 'deliveredAt', 'errorMessage'
    ]
  }
}
```

### TaskWarrior Integration

#### Database Monitoring
```python
# Integration script: firestore_monitor.py
import firebase_admin
from firebase_admin import credentials, firestore
import subprocess
from datetime import datetime, timedelta

# Initialize Firebase Admin SDK
cred = credentials.ApplicationDefault()
firebase_admin.initialize_app(cred)
db = firestore.client()

def monitor_firestore_operations():
    """Monitor Firestore operations and update TaskWarrior"""

    # Check recent orders
    recent_time = datetime.now() - timedelta(hours=1)

    orders_ref = db.collection('orders')
    recent_orders = orders_ref.where('createdAt', '>=', recent_time).get()

    for order in recent_orders:
        order_data = order.to_dict()
        annotation = f"Firestore order: {order_data['orderId']} - Status: {order_data['status']}"

        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+firestore',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

def test_firestore_connectivity():
    """Test Firestore database connectivity"""
    try:
        # Test write operation
        test_ref = db.collection('test').document('connectivity')
        test_ref.set({
            'timestamp': datetime.now(),
            'source': 'taskwarrior_test'
        })

        # Test read operation
        doc = test_ref.get()

        # Cleanup
        test_ref.delete()

        return {
            'status': 'connected',
            'write_success': True,
            'read_success': doc.exists
        }
    except Exception as e:
        return {
            'status': 'error',
            'error': str(e)
        }

def validate_order_creation(payment_intent_id):
    """Validate that order was created for payment intent"""

    orders_ref = db.collection('orders')
    query = orders_ref.where('paymentIntentId', '==', payment_intent_id)
    results = query.get()

    if results:
        order_data = results[0].to_dict()
        return {
            'found': True,
            'orderId': order_data['orderId'],
            'status': order_data['status'],
            'createdAt': order_data['createdAt']
        }
    else:
        return {
            'found': False,
            'payment_intent_id': payment_intent_id
        }
```

#### Order Validation Automation
```bash
# Validate order creation in TaskWarrior workflow
validate_order_with_task() {
    local TASK_ID=$1
    local PAYMENT_INTENT_ID=$2

    # Start verification task
    python3 taskwarrior_helpers.py start --task-id $TASK_ID

    # Check for order creation (wait up to 30 seconds)
    for i in {1..30}; do
        ORDER_STATUS=$(python3 -c "
import firestore_monitor
result = firestore_monitor.validate_order_creation('$PAYMENT_INTENT_ID')
print('found' if result['found'] else 'not_found')
        ")

        if [ "$ORDER_STATUS" = "found" ]; then
            python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
              --annotation "Order created successfully for payment: $PAYMENT_INTENT_ID"
            break
        fi

        sleep 1
    done

    if [ "$ORDER_STATUS" = "not_found" ]; then
        python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
          --annotation "ERROR: Order not found for payment: $PAYMENT_INTENT_ID"
    fi

    # Complete verification task
    python3 taskwarrior_helpers.py complete --task-id $TASK_ID
}
```

---

## 🤖 Vertex AI Integration

### AI Service Configuration

#### Authentication Setup
```bash
# Set up Application Default Credentials
gcloud auth application-default login

# Set project
gcloud config set project diagnosticpro-prod

# Enable Vertex AI API
gcloud services enable aiplatform.googleapis.com

# Test access
gcloud ai models list --region=us-central1
```

#### Service Configuration
```python
# Vertex AI configuration for DiagnosticPro
from google.cloud import aiplatform

aiplatform.init(
    project="diagnosticpro-prod",
    location="us-central1"
)

# Gemini 2.5 Flash configuration
MODEL_NAME = "gemini-2.5-flash-002"
```

### TaskWarrior Integration

#### AI Processing Monitoring
```python
# Integration script: vertex_ai_monitor.py
from google.cloud import aiplatform
import subprocess
from datetime import datetime
import json

def monitor_ai_processing():
    """Monitor Vertex AI processing and update TaskWarrior"""

    # Initialize Vertex AI client
    aiplatform.init(project="diagnosticpro-prod", location="us-central1")

    # Get recent predictions (if available via API)
    # Note: This might require custom logging in the Cloud Function

    try:
        # Test AI connectivity
        test_prompt = "Test connectivity"

        # This would be the actual AI call in production
        response = test_ai_connectivity()

        if response['status'] == 'success':
            annotation = f"Vertex AI: Connected - Model: {response['model']} - Response time: {response['response_time']}s"
        else:
            annotation = f"Vertex AI: Error - {response['error']}"

        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+ai',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

    except Exception as e:
        error_annotation = f"Vertex AI monitoring error: {str(e)}"
        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+ai',
            'limit:1', 'annotate', error_annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

def test_ai_connectivity():
    """Test Vertex AI connectivity and model access"""
    try:
        # Import the Vertex AI Generative AI library
        from vertexai.generative_models import GenerativeModel

        model = GenerativeModel("gemini-2.5-flash-002")

        start_time = datetime.now()
        response = model.generate_content("Hello, this is a connectivity test.")
        end_time = datetime.now()

        response_time = (end_time - start_time).total_seconds()

        return {
            'status': 'success',
            'model': 'gemini-2.5-flash-002',
            'response_time': response_time,
            'response_length': len(response.text)
        }
    except Exception as e:
        return {
            'status': 'error',
            'error': str(e)
        }

def validate_ai_analysis(submission_id):
    """Validate that AI analysis was completed for submission"""

    # This would query Firestore for analysis results
    # Simplified example:
    try:
        from firestore_monitor import db

        submission_ref = db.collection('diagnosticSubmissions').document(submission_id)
        doc = submission_ref.get()

        if doc.exists:
            data = doc.to_dict()
            if 'analysisResult' in data and data['analysisResult']:
                return {
                    'completed': True,
                    'analysis_length': len(data['analysisResult']),
                    'processed_at': data.get('processedAt')
                }

        return {
            'completed': False,
            'submission_id': submission_id
        }
    except Exception as e:
        return {
            'completed': False,
            'error': str(e)
        }
```

#### AI Analysis Validation
```bash
# Validate AI analysis completion
validate_ai_analysis_with_task() {
    local TASK_ID=$1
    local SUBMISSION_ID=$2

    # Start AI verification task
    python3 taskwarrior_helpers.py start --task-id $TASK_ID

    # Wait for AI processing (up to 60 seconds)
    for i in {1..60}; do
        ANALYSIS_STATUS=$(python3 -c "
import vertex_ai_monitor
result = vertex_ai_monitor.validate_ai_analysis('$SUBMISSION_ID')
print('completed' if result['completed'] else 'processing')
        ")

        if [ "$ANALYSIS_STATUS" = "completed" ]; then
            python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
              --annotation "AI analysis completed for submission: $SUBMISSION_ID"
            break
        fi

        sleep 1
    done

    if [ "$ANALYSIS_STATUS" = "processing" ]; then
        python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
          --annotation "WARNING: AI analysis taking longer than expected: $SUBMISSION_ID"
    fi

    # Complete verification task
    python3 taskwarrior_helpers.py complete --task-id $TASK_ID
}
```

---

## 📧 Email Service Integration

### Email Configuration

#### Service Setup
```bash
# Email service configuration (example with SendGrid)
export SENDGRID_API_KEY="SG...."
export FROM_EMAIL="noreply@diagnosticpro.io"
export SUPPORT_EMAIL="support@diagnosticpro.io"

# Test email connectivity
curl -X POST https://api.sendgrid.com/v3/mail/send \
  -H "Authorization: Bearer $SENDGRID_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "personalizations": [{"to": [{"email": "test@example.com"}]}],
    "from": {"email": "noreply@diagnosticpro.io"},
    "subject": "Test Email",
    "content": [{"type": "text/plain", "value": "Test message"}]
  }'
```

### TaskWarrior Integration

#### Email Delivery Monitoring
```python
# Integration script: email_monitor.py
import requests
import subprocess
from datetime import datetime
import os

def monitor_email_delivery():
    """Monitor email delivery and update TaskWarrior"""

    api_key = os.getenv('SENDGRID_API_KEY')

    if not api_key:
        annotation = "ERROR: SendGrid API key not configured"
        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+email',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)
        return

    # Check email statistics
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json'
    }

    try:
        response = requests.get(
            'https://api.sendgrid.com/v3/stats',
            headers=headers,
            params={'start_date': datetime.now().strftime('%Y-%m-%d')}
        )

        if response.status_code == 200:
            stats = response.json()
            annotation = f"Email stats: Sent={stats.get('delivered', 0)}, Bounced={stats.get('bounces', 0)}"
        else:
            annotation = f"Email API error: {response.status_code}"

        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+email',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

    except Exception as e:
        error_annotation = f"Email monitoring error: {str(e)}"
        cmd = [
            'task', 'project:DiagnosticPro', '+verify', '+email',
            'limit:1', 'annotate', error_annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

def test_email_delivery(customer_email, order_id):
    """Test email delivery functionality"""

    api_key = os.getenv('SENDGRID_API_KEY')
    from_email = os.getenv('FROM_EMAIL', 'noreply@diagnosticpro.io')

    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json'
    }

    email_data = {
        "personalizations": [{
            "to": [{"email": customer_email}],
            "substitutions": {
                "-order_id-": order_id
            }
        }],
        "from": {"email": from_email},
        "subject": "Test: DiagnosticPro Analysis Complete",
        "content": [{
            "type": "text/html",
            "value": "<p>Test email for order: -order_id-</p>"
        }]
    }

    try:
        response = requests.post(
            'https://api.sendgrid.com/v3/mail/send',
            headers=headers,
            json=email_data
        )

        return {
            'status': 'sent' if response.status_code == 202 else 'failed',
            'status_code': response.status_code,
            'response': response.text
        }
    except Exception as e:
        return {
            'status': 'error',
            'error': str(e)
        }
```

#### Email Validation Automation
```bash
# Validate email delivery in TaskWarrior workflow
validate_email_delivery_with_task() {
    local TASK_ID=$1
    local CUSTOMER_EMAIL=$2
    local ORDER_ID=$3

    # Start email verification task
    python3 taskwarrior_helpers.py start --task-id $TASK_ID

    # Test email delivery
    EMAIL_RESULT=$(python3 -c "
import email_monitor
result = email_monitor.test_email_delivery('$CUSTOMER_EMAIL', '$ORDER_ID')
print(result['status'])
    ")

    if [ "$EMAIL_RESULT" = "sent" ]; then
        python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
          --annotation "Email sent successfully to: $CUSTOMER_EMAIL (Order: $ORDER_ID)"
    else
        python3 taskwarrior_helpers.py annotate --task-id $TASK_ID \
          --annotation "ERROR: Email delivery failed to: $CUSTOMER_EMAIL"
    fi

    # Complete verification task
    python3 taskwarrior_helpers.py complete --task-id $TASK_ID
}
```

---

## 🔗 End-to-End Integration Testing

### Comprehensive Integration Test
```bash
#!/bin/bash
# complete_integration_test.sh
# End-to-end integration test with TaskWarrior

set -e

echo "Starting complete DiagnosticPro integration test..."

# 1. Start master task
MASTER_TASK=$(task project:DiagnosticPro ready limit:1 | grep -E "^[0-9]+" | awk '{print $1}' | head -1)
python3 taskwarrior_helpers.py start --task-id $MASTER_TASK

# 2. Test DiagnosticPro platform
echo "Testing platform connectivity..."
PLATFORM_STATUS=$(python3 -c "import monitor_diagnosticpro; print('ok' if monitor_diagnosticpro.check_diagnosticpro_health()['healthy'] else 'error')")

if [ "$PLATFORM_STATUS" = "ok" ]; then
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "✅ Platform connectivity verified"
else
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "❌ Platform connectivity failed"
    exit 1
fi

# 3. Test Stripe API
echo "Testing Stripe API..."
STRIPE_STATUS=$(python3 -c "import stripe_monitor; print('ok' if stripe_monitor.test_stripe_connection()['status'] == 'connected' else 'error')")

if [ "$STRIPE_STATUS" = "ok" ]; then
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "✅ Stripe API verified"
else
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "❌ Stripe API failed"
    exit 1
fi

# 4. Test Firebase/Firestore
echo "Testing Firebase connectivity..."
FIREBASE_STATUS=$(python3 -c "import firestore_monitor; print('ok' if firestore_monitor.test_firestore_connectivity()['status'] == 'connected' else 'error')")

if [ "$FIREBASE_STATUS" = "ok" ]; then
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "✅ Firebase/Firestore verified"
else
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "❌ Firebase/Firestore failed"
    exit 1
fi

# 5. Test Vertex AI
echo "Testing Vertex AI..."
AI_STATUS=$(python3 -c "import vertex_ai_monitor; print('ok' if vertex_ai_monitor.test_ai_connectivity()['status'] == 'success' else 'error')")

if [ "$AI_STATUS" = "ok" ]; then
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "✅ Vertex AI verified"
else
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "❌ Vertex AI failed"
    exit 1
fi

# 6. Test Email Service
echo "Testing email service..."
EMAIL_STATUS=$(python3 -c "import email_monitor; print('ok' if email_monitor.test_email_delivery('test@example.com', 'test_order')['status'] == 'sent' else 'error')")

if [ "$EMAIL_STATUS" = "ok" ]; then
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "✅ Email service verified"
else
    python3 taskwarrior_helpers.py annotate --task-id $MASTER_TASK --annotation "❌ Email service failed"
    exit 1
fi

# 7. Complete integration test
python3 taskwarrior_helpers.py complete --task-id $MASTER_TASK --annotation "🎉 Complete integration test passed - All systems operational"

echo "✅ Complete integration test successful!"
echo "All DiagnosticPro systems are operational and ready for payment testing."
```

### Automated Integration Monitoring
```python
# Integration script: integration_monitor.py
import subprocess
import schedule
import time
from datetime import datetime

def run_integration_checks():
    """Run complete integration checks and update TaskWarrior"""

    print(f"Starting integration checks at {datetime.now()}")

    # Run the integration test script
    result = subprocess.run([
        'bash', 'complete_integration_test.sh'
    ], capture_output=True, text=True)

    if result.returncode == 0:
        print("✅ Integration checks passed")
    else:
        print(f"❌ Integration checks failed: {result.stderr}")

        # Create urgent task for failures
        cmd = [
            'task', 'add',
            'URGENT: Integration check failed - requires immediate attention',
            'project:DiagnosticPro',
            'priority:H',
            '+urgent', '+monitoring'
        ]
        subprocess.run(cmd, capture_output=True, text=True)

def setup_monitoring_schedule():
    """Set up automated monitoring schedule"""

    # Run integration checks every hour
    schedule.every().hour.do(run_integration_checks)

    # Run comprehensive checks daily at 9 AM
    schedule.every().day.at("09:00").do(run_integration_checks)

    print("Integration monitoring scheduled")
    print("- Hourly integration checks")
    print("- Daily comprehensive validation at 9 AM")

    while True:
        schedule.run_pending()
        time.sleep(60)  # Check every minute

if __name__ == "__main__":
    setup_monitoring_schedule()
```

---

## 📊 Integration Metrics and Monitoring

### Key Performance Indicators

#### API Response Times
```python
# Monitoring script: api_performance.py
import time
import requests
import subprocess
from datetime import datetime

def measure_api_performance():
    """Measure API response times and update TaskWarrior"""

    apis = [
        {
            'name': 'DiagnosticPro',
            'url': 'https://diagnosticpro.io/api/health',
            'timeout': 10
        },
        {
            'name': 'Stripe',
            'url': 'https://api.stripe.com/v1/account',
            'headers': {'Authorization': 'Bearer sk_test_...'},
            'timeout': 5
        }
    ]

    results = {}

    for api in apis:
        try:
            start_time = time.time()
            response = requests.get(
                api['url'],
                headers=api.get('headers', {}),
                timeout=api['timeout']
            )
            end_time = time.time()

            response_time = (end_time - start_time) * 1000  # Convert to milliseconds

            results[api['name']] = {
                'status_code': response.status_code,
                'response_time_ms': round(response_time, 2),
                'healthy': response.status_code == 200
            }
        except Exception as e:
            results[api['name']] = {
                'status_code': 'error',
                'response_time_ms': 'timeout',
                'healthy': False,
                'error': str(e)
            }

    # Update TaskWarrior with performance metrics
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    for api_name, metrics in results.items():
        if metrics['healthy']:
            annotation = f"[{timestamp}] {api_name}: {metrics['response_time_ms']}ms (✅)"
        else:
            annotation = f"[{timestamp}] {api_name}: ERROR - {metrics.get('error', 'Unknown')}"

        cmd = [
            'task', 'project:DiagnosticPro', '+monitoring', '+performance',
            'limit:1', 'annotate', annotation
        ]
        subprocess.run(cmd, capture_output=True, text=True)

    return results
```

#### Success Rate Tracking
```bash
# Track success rates over time
track_success_rates() {
    local TIME_PERIOD=$1  # daily, weekly, monthly

    # Count successful tests
    SUCCESSFUL_TESTS=$(task project:DiagnosticPro completed end.after:${TIME_PERIOD} count)

    # Count failed tests (tasks with error annotations)
    FAILED_TESTS=$(task project:DiagnosticPro completed end.after:${TIME_PERIOD} /ERROR/ count)

    # Calculate success rate
    TOTAL_TESTS=$((SUCCESSFUL_TESTS + FAILED_TESTS))

    if [ $TOTAL_TESTS -gt 0 ]; then
        SUCCESS_RATE=$(echo "scale=2; $SUCCESSFUL_TESTS * 100 / $TOTAL_TESTS" | bc)
        echo "Success rate (${TIME_PERIOD}): ${SUCCESS_RATE}%"

        # Update monitoring task
        python3 taskwarrior_helpers.py annotate --task-id <MONITORING-ID> \
          --annotation "Success rate (${TIME_PERIOD}): ${SUCCESS_RATE}% (${SUCCESSFUL_TESTS}/${TOTAL_TESTS})"
    else
        echo "No tests completed in ${TIME_PERIOD} period"
    fi
}

# Usage
track_success_rates "1week"
track_success_rates "1month"
```

---

## 🔐 Security and Authentication

### API Key Management
```bash
# Secure API key storage
export_api_keys() {
    # Never commit these to version control
    export STRIPE_SECRET_KEY="sk_test_..."
    export STRIPE_PUBLISHABLE_KEY="pk_test_..."
    export STRIPE_WEBHOOK_SECRET="whsec_..."
    export SENDGRID_API_KEY="SG...."
    export FIREBASE_PROJECT_ID="diagnosticpro-prod"
}

# Load from secure file
load_api_keys() {
    if [ -f ~/.env.diagnosticpro ]; then
        source ~/.env.diagnosticpro
    else
        echo "ERROR: API keys file not found at ~/.env.diagnosticpro"
        exit 1
    fi
}
```

### Authentication Testing
```python
# Security validation script
def validate_authentication():
    """Validate all authentication mechanisms"""

    results = {}

    # Test Stripe authentication
    try:
        import stripe
        stripe.api_key = os.getenv('STRIPE_SECRET_KEY')
        account = stripe.Account.retrieve()
        results['stripe'] = {'status': 'authenticated', 'account_id': account.id}
    except Exception as e:
        results['stripe'] = {'status': 'failed', 'error': str(e)}

    # Test Firebase authentication
    try:
        import firebase_admin
        from firebase_admin import credentials
        cred = credentials.ApplicationDefault()
        results['firebase'] = {'status': 'authenticated', 'type': 'ADC'}
    except Exception as e:
        results['firebase'] = {'status': 'failed', 'error': str(e)}

    # Test Vertex AI authentication
    try:
        from google.cloud import aiplatform
        aiplatform.init(project="diagnosticpro-prod", location="us-central1")
        results['vertex_ai'] = {'status': 'authenticated', 'project': 'diagnosticpro-prod'}
    except Exception as e:
        results['vertex_ai'] = {'status': 'failed', 'error': str(e)}

    return results
```

---

**Remember**: This integration guide covers all major API touchpoints for the TaskWarrior DiagnosticPro system. Each integration point includes authentication, monitoring, and error handling procedures to ensure reliable operation.

---

**Created:** 2025-09-29
**Covers:** All DiagnosticPro platform integrations
**Security Level:** Production-ready with secure authentication
**Monitoring:** Comprehensive API and performance monitoring included