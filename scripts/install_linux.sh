#!/bin/bash

# Scientific PDF Translator - Linux Installation Script
# Author: Hugues DTANKOUO

echo "=================================="
echo "Scientific PDF Translator Setup"
echo "Linux Installation Script"
echo "=================================="
echo ""

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    echo "❌ Cannot detect Linux distribution"
    exit 1
fi

echo "🐧 Detected: $OS $VER"
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

# Update package manager
echo "🔄 Updating package manager..."
if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
    sudo apt-get update
    print_status $? "Package manager update"
    PKG_MANAGER="apt-get"
elif [[ "$OS" == *"Fedora"* ]] || [[ "$OS" == *"Red Hat"* ]] || [[ "$OS" == *"CentOS"* ]]; then
    sudo dnf update -y
    print_status $? "Package manager update"
    PKG_MANAGER="dnf"
elif [[ "$OS" == *"Arch"* ]]; then
    sudo pacman -Syu
    print_status $? "Package manager update"
    PKG_MANAGER="pacman"
else
    echo "⚠️  Unsupported distribution. Please install dependencies manually."
    exit 1
fi

# Install Python 3.11+
echo "🔍 Checking for Python 3.11+..."
PYTHON_CMD=""
for ver in python3.13 python3.12 python3.11; do
    if command_exists $ver; then
        PYTHON_CMD=$ver
        break
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "📦 Installing Python 3.11..."
    if [ "$PKG_MANAGER" = "apt-get" ]; then
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa -y
        sudo apt-get update
        sudo apt-get install -y python3.11 python3.11-venv python3.11-dev
        PYTHON_CMD="python3.11"
    elif [ "$PKG_MANAGER" = "dnf" ]; then
        sudo dnf install -y python3.11 python3.11-devel
        PYTHON_CMD="python3.11"
    elif [ "$PKG_MANAGER" = "pacman" ]; then
        sudo pacman -S python python-pip
        PYTHON_CMD="python3"
    fi
    print_status $? "Python installation"
else
    echo "✅ Python 3.11+ is already installed"
    echo "   Using: $PYTHON_CMD"
fi

# Install system dependencies
echo "📦 Installing system dependencies..."
if [ "$PKG_MANAGER" = "apt-get" ]; then
    sudo apt-get install -y \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-fra \
        libtesseract-dev \
        libleptonica-dev \
        python3-pip \
        python3-pil \
        texlive-full \
        git \
        curl
elif [ "$PKG_MANAGER" = "dnf" ]; then
    sudo dnf install -y \
        tesseract \
        tesseract-langpack-eng \
        tesseract-langpack-fra \
        tesseract-devel \
        leptonica-devel \
        python3-pip \
        python3-pillow \
        texlive-scheme-full \
        git \
        curl
elif [ "$PKG_MANAGER" = "pacman" ]; then
    sudo pacman -S \
        tesseract \
        tesseract-data-eng \
        tesseract-data-fra \
        python-pillow \
        texlive-most \
        texlive-lang \
        git \
        curl
fi
print_status $? "System dependencies installation"

# Verify Tesseract installation
echo "🔍 Verifying Tesseract..."
if command_exists tesseract; then
    echo "✅ Tesseract is installed"
    tesseract --version | head -1
else
    echo "❌ Tesseract installation failed"
    exit 1
fi

# Verify LaTeX installation
echo "🔍 Verifying LaTeX..."
if command_exists pdflatex; then
    echo "✅ LaTeX is installed"
    pdflatex --version | head -1
else
    echo "❌ LaTeX installation failed"
    exit 1
fi

# Create virtual environment
echo ""
echo "🐍 Setting up Python environment..."
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

# Install Python packages
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
echo "✅ System packages: Updated"
echo "✅ Python 3.11+: Installed"
echo "✅ Tesseract OCR: Installed"
echo "✅ LaTeX: Installed"
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