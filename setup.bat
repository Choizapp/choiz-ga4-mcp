@echo off
REM Setup script for choiz-ga4-mcp (Windows)

echo Setting up choiz-ga4-mcp...

REM Check Python version
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found. Install Python 3.10+ from https://python.org
    exit /b 1
)

REM Create virtual environment
if not exist ".venv" (
    python -m venv .venv
    echo Virtual environment created at .venv\
)

REM Activate and install
call .venv\Scripts\activate.bat
pip install --upgrade pip -q
pip install -e . -q
echo Dependencies installed.

REM Copy .env.example if .env doesn't exist
if not exist ".env" (
    copy .env.example .env >nul
    echo.
    echo Created .env from .env.example.
    echo IMPORTANT: Edit .env and set your GOOGLE_APPLICATION_CREDENTIALS and GA4_PROPERTY_ID.
)

echo.
echo Setup complete.
echo.
echo Next steps:
echo   1. Edit .env with your credentials
echo   2. Run: .venv\Scripts\activate ^&^& python -m ga4_mcp
echo   3. Update claude-config-template.json with your paths and add it to Claude Desktop config
