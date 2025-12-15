# Dockerfile for running tests in an isolated environment
# Usage from project root: docker build -f _tests/Dockerfile -t mnhsfl-test . && docker run --rm mnhsfl-test

FROM python:3.11-slim

WORKDIR /app

# Install pytest first (this layer gets cached unless we change the version)
RUN pip install --no-cache-dir pytest>=9.0.0

# Copy files that change frequently AFTER installing dependencies
# This way pip install doesn't re-run every time we change a test
COPY _scripts/ ./_scripts/
COPY _tests/ ./_tests/
COPY _fencing-results/ ./_fencing-results/

# Run tests and show output
CMD ["pytest", "_tests/test_generate_results.py", "-v", "--tb=short"]
