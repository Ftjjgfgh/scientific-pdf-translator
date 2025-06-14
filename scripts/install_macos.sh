#!/bin/bash

# Scientific PDF Translator - macOS Installation Script
# Author: Hugues DTANKOUO

echo "=================================="
echo "Scientific PDF Translator Setup"
echo "macOS Installation Script"
echo "=================================="
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo "✅ $2"
    else
        echo "❌ $2"
        exit 1
    fi
}

# Check for Homebrew
echo "🔍 Checking for Homebrew..."
if ! command_exists brew; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_status $? "Homebrew installation"
else
    echo "✅ Homebrew is already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update
print_status $? "Homebrew update"

# Check for Python 3.11+
echo "🔍 Checking for Python 3.11+..."
if command_exists python3.11 || command_exists python3.12 || command_exists python3.13; then
    echo "✅ Python 3.11+ is already installed"
    PYTHON_CMD=$(command -v python3.13 || command -v python3.12 || command -v python3.11)
    echo "   Using: $PYTHON_CMD"
else
    echo "📦 Installing Python 3.11..."
    brew install python@3.11
    print_status $? "Python 3.11 installation"
    PYTHON_CMD="python3.11"
fi

# Check for Tesseract
echo "🔍 Checking for Tesseract OCR..."
if ! command_exists tesseract; then
    echo "📦 Installing Tesseract..."
    brew install tesseract
    print_status $? "Tesseract installation"
    
    # Install additional language data
    echo "📦 Installing Tesseract language data..."
    brew install tesseract-lang
    print_status $? "Tesseract language data installation"
else
    echo "✅ Tesseract is already installed"
    tesseract --version | head -1
fi

# Check for MacTeX
echo "🔍 Checking for LaTeX (pdflatex)..."
if ! command_exists pdflatex; then
    echo "⚠️  MacTeX is not installed!"
    echo ""
    echo "MacTeX is a large package (>4GB) and requires manual installation."
    echo "Please install it using ONE of these methods:"
    echo ""
    echo "Option 1 - Full MacTeX (recommended):"
    echo "  brew install --cask mactex"
    echo ""
    echo "Option 2 - BasicTeX (smaller, ~100MB):"
    echo "  brew install --cask basictex"
    echo ""
    echo "Option 3 - Download from:"
    echo "  https://www.tug.org/mactex/mactex-download.html"
    echo ""
    echo "After installation, please restart your terminal and run this script again."
    LATEX_MISSING=1
else
    echo "✅ LaTeX is already installed"
    pdflatex --version | head -1
fi

# Install Python packages
echo ""
echo "🐍 Setting up Python environment..."

# Create virtual environment
echo "📁 Creating virtual environment..."
$PYTHON_CMD -m venv venv
print_status $? "Virtual environment creation"

# Activate virtual environment
echo "🔌 Activating virtual environment..."
source venv/bin/activate
print_status $? "Virtual environment activation"

# Upgrade pip
echo "📦 Upgrading pip..."
pip install --upgrade pip
print_status $? "pip upgrade"

# Install required packages
echo "📦 Installing Python packages..."
pip install PyMuPDF pytesseract pillow numpy
print_status $? "Python packages installation"

# Create workspace directories
echo ""
echo "📁 Creating workspace directories..."
mkdir -p workspace/{extracted_pages,ocr_output,translations,latex_output}
print_status $? "Workspace creation"

# Final summary
echo ""
echo "=================================="
echo "Installation Summary"
echo "=================================="
echo "✅ Homebrew: Installed/Updated"
echo "✅ Python 3.11+: Installed"
echo "✅ Tesseract OCR: Installed"
if [ -z "$LATEX_MISSING" ]; then
    echo "✅ LaTeX: Installed"
else
    echo "⚠️  LaTeX: Not installed (manual installation required)"
fi
echo "✅ Python packages: Installed"
echo "✅ Workspace: Created"
echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Place your PDF document in the 'workspace' directory"
echo "2. Run 'claude' to start Claude Code"
echo "3. Ask Claude to read CLAUDE.md and begin the translation"
echo ""
echo "To activate the Python environment in future sessions:"
echo "  source venv/bin/activate"
echo ""