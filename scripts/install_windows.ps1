# Scientific PDF Translator - Windows Installation Script
# Author: Hugues DTANKOUO
# Run this script in PowerShell as Administrator

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Scientific PDF Translator Setup" -ForegroundColor Cyan
Write-Host "Windows Installation Script" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check if running as administrator
if (-not (Test-Administrator)) {
    Write-Host "❌ This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click on PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Exit 1
}

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    try {
        Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Function to print status
function Print-Status {
    param($success, $message)
    if ($success) {
        Write-Host "✅ $message" -ForegroundColor Green
    } else {
        Write-Host "❌ $message" -ForegroundColor Red
        Exit 1
    }
}

# Enable script execution
Write-Host "🔧 Setting execution policy..." -ForegroundColor Yellow
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Print-Status $? "Execution policy set"

# Check for Chocolatey
Write-Host "🔍 Checking for Chocolatey..." -ForegroundColor Yellow
if (-not (Test-CommandExists choco)) {
    Write-Host "📦 Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    if (Test-CommandExists choco) {
        Print-Status $true "Chocolatey installation"
    } else {
        Print-Status $false "Chocolatey installation"
    }
} else {
    Write-Host "✅ Chocolatey is already installed" -ForegroundColor Green
}

# Install Python 3.11
Write-Host "🔍 Checking for Python 3.11+..." -ForegroundColor Yellow
$pythonInstalled = $false
$pythonCmd = ""

foreach ($ver in @("python3.13", "python3.12", "python3.11", "python")) {
    if (Test-CommandExists $ver) {
        $version = & $ver --version 2>&1
        if ($version -match "3\.(1[1-9]|[2-9][0-9])") {
            $pythonInstalled = $true
            $pythonCmd = $ver
            Write-Host "✅ Python 3.11+ is already installed: $version" -ForegroundColor Green
            break
        }
    }
}

if (-not $pythonInstalled) {
    Write-Host "📦 Installing Python 3.11..." -ForegroundColor Yellow
    choco install python311 -y
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    $pythonCmd = "python"
    Print-Status (Test-CommandExists $pythonCmd) "Python installation"
}

# Install Tesseract
Write-Host "🔍 Checking for Tesseract OCR..." -ForegroundColor Yellow
if (-not (Test-CommandExists tesseract)) {
    Write-Host "📦 Installing Tesseract..." -ForegroundColor Yellow
    choco install tesseract -y
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Print-Status (Test-CommandExists tesseract) "Tesseract installation"
} else {
    Write-Host "✅ Tesseract is already installed" -ForegroundColor Green
    & tesseract --version
}

# Install MiKTeX (LaTeX distribution for Windows)
Write-Host "🔍 Checking for LaTeX (pdflatex)..." -ForegroundColor Yellow
if (-not (Test-CommandExists pdflatex)) {
    Write-Host "📦 Installing MiKTeX..." -ForegroundColor Yellow
    Write-Host "This may take several minutes..." -ForegroundColor Yellow
    choco install miktex -y
    
    # Refresh environment
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    if (Test-CommandExists pdflatex) {
        Print-Status $true "MiKTeX installation"
    } else {
        Write-Host "⚠️  MiKTeX installation may require a system restart" -ForegroundColor Yellow
        Write-Host "Please restart your computer and run this script again if pdflatex is not found" -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ LaTeX is already installed" -ForegroundColor Green
    & pdflatex --version | Select-Object -First 1
}

# Create virtual environment
Write-Host ""
Write-Host "🐍 Setting up Python environment..." -ForegroundColor Yellow
Write-Host "📁 Creating virtual environment..." -ForegroundColor Yellow

& $pythonCmd -m venv venv
Print-Status $? "Virtual environment creation"

# Activate virtual environment
Write-Host "🔌 Activating virtual environment..." -ForegroundColor Yellow
& ".\venv\Scripts\Activate.ps1"
Print-Status $? "Virtual environment activation"

# Upgrade pip
Write-Host "📦 Upgrading pip..." -ForegroundColor Yellow
& python -m pip install --upgrade pip
Print-Status $? "pip upgrade"

# Install Python packages
Write-Host "📦 Installing Python packages..." -ForegroundColor Yellow
& pip install PyMuPDF pytesseract pillow numpy
Print-Status $? "Python packages installation"

# Create workspace directories
Write-Host ""
Write-Host "📁 Creating workspace directories..." -ForegroundColor Yellow
$directories = @(
    "workspace",
    "workspace\extracted_pages",
    "workspace\ocr_output",
    "workspace\translations",
    "workspace\latex_output"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}
Print-Status $true "Workspace creation"

# Create activation script
$activationScript = @"
# Activation script for Scientific PDF Translator
Write-Host "Activating Scientific PDF Translator environment..." -ForegroundColor Green
& ".\venv\Scripts\Activate.ps1"
Write-Host "Environment activated! You can now run 'claude' to start." -ForegroundColor Green
"@

$activationScript | Out-File -FilePath "activate.ps1" -Encoding UTF8
Write-Host "✅ Created activation script: activate.ps1" -ForegroundColor Green

# Final summary
Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Installation Summary" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "✅ Chocolatey: Installed/Available" -ForegroundColor Green
Write-Host "✅ Python 3.11+: Installed" -ForegroundColor Green
Write-Host "✅ Tesseract OCR: Installed" -ForegroundColor Green
if (Test-CommandExists pdflatex) {
    Write-Host "✅ LaTeX (MiKTeX): Installed" -ForegroundColor Green
} else {
    Write-Host "⚠️  LaTeX (MiKTeX): May require restart" -ForegroundColor Yellow
}
Write-Host "✅ Python packages: Installed" -ForegroundColor Green
Write-Host "✅ Workspace: Created" -ForegroundColor Green
Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Place your PDF document in the 'workspace' directory" -ForegroundColor White
Write-Host "2. Run '.\activate.ps1' to activate the environment" -ForegroundColor White
Write-Host "3. Run 'claude' to start Claude Code" -ForegroundColor White
Write-Host "4. Ask Claude to read CLAUDE.md and begin the translation" -ForegroundColor White
Write-Host ""
Write-Host "To activate the Python environment in future sessions:" -ForegroundColor Yellow
Write-Host "  .\activate.ps1" -ForegroundColor White
Write-Host "  OR" -ForegroundColor Gray
Write-Host "  .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host ""