#!/bin/bash
# deploy-release.sh - Deploy to production/registry

echo "=== DEPLOYING RELEASE ==="
task project:$RELEASE_ID +DEPLOY start

echo "→ This is a prompt template repository - no deployment needed"
echo "✅ Deployment complete (templates are ready for use)"

task project:$RELEASE_ID +DEPLOY done