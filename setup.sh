#!/bin/bash
# Setup script for choiz-ga4-mcp (Mac/Linux)
set -e

echo "Setting up choiz-ga4-mcp..."

# Check Python version
python_version=$(python3 --version 2>&1 | awk '{print $2}')
required="3.10"
if ! python3 -c "import sys; exit(0 if sys.version_info >= (3,10) else 1)"; then
    echo "ERROR: Python 3.10+ is required (found $python_version)."
    exit 1
fi
echo "Python $python_version detected."

# Create virtual environment
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    echo "Virtual environment created at .venv/"
fi

# Activate and install
source .venv/bin/activate
pip install --upgrade pip -q
pip install -e . -q
echo "Dependencies installed."

# Copy .env.example if .env doesn't exist
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo ""
    echo "Created .env from .env.example."
    echo "IMPORTANT: Edit .env and set your GOOGLE_APPLICATION_CREDENTIALS and GA4_PROPERTY_ID."
fi

# Remind about credentials file permissions
if [ -f ".env" ]; then
    creds=$(grep GOOGLE_APPLICATION_CREDENTIALS .env | cut -d= -f2)
    if [ -n "$creds" ] && [ -f "$creds" ]; then
        chmod 600 "$creds"
        echo "Set permissions 600 on credentials file."
    fi
fi

echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "  1. Edit .env with your credentials"
echo "  2. Run: source .venv/bin/activate && python -m ga4_mcp"
echo "  3. Update claude-config-template.json with your paths and add it to Claude Desktop config"
