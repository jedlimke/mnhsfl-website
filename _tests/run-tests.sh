#!/bin/bash
# Run tests in a clean Docker container
# This ensures tests work in the same environment as CI/CD

set -e

echo "🐳 Building test container..."
docker build -f _tests/Dockerfile -t mnhsfl-test .

echo ""
echo "🧪 Running tests..."
docker run --rm mnhsfl-test

echo ""
echo "✅ Tests completed successfully!"
