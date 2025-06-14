# Instructions for Claude - Scientific PDF Translation

## 🎯 Your Mission

You are about to help translate a scientific PDF document from English to French. This is a quality-focused task that requires patience, precision, and attention to detail. The goal is to produce a professionally formatted, accurately translated document that maintains the academic rigor of the original.

## 📋 Initial Setup

### Step 1: Create TODO.md
**FIRST AND FOREMOST**: Create a comprehensive TODO.md file that lists EVERY step of this process. This file will be your checkpoint system. Make it exhaustive - include every single task, no matter how small.

### Step 2: Python Environment
Create and activate a Python virtual environment with Python 3.11+:
```bash
python3.11 -m venv venv
source venv/bin/activate  # On macOS/Linux
```

**CRITICAL**: Use this virtual environment for ALL Python operations throughout this process.

### Step 3: Check System Requirements

1. **Tesseract OCR**: 
   - Check if installed: `which tesseract`
   - If not installed, ask the user to run: `./scripts/install_macos.sh`
   - Or install manually: `brew install tesseract`

2. **MacTeX**:
   - Check if installed: `which pdflatex`
   - If not installed, direct user to install MacTeX

## 📁 Directory Structure

Create the following structure:
```
workspace/
├── extracted_pages/     # PNG images of each page
├── ocr_output/         # Raw OCR text files
├── translations/       # Translated text files
└── latex_output/       # Final LaTeX document
```

## 🔄 Translation Process

### Phase 1: PDF to Images
**Location**: `prompts/01_extraction_guide.md`

1. Extract EVERY page as PNG with naming: `page_001.png`, `page_002.png`, etc.
2. Use high resolution (2x zoom minimum) for better OCR quality
3. Store in `workspace/extracted_pages/`

**IMPORTANT**: This step reduces hallucination risk by working with actual page images.

### Phase 2: OCR Extraction
**Location**: `prompts/02_ocr_guide.md`

1. Process each page with Tesseract OCR
2. Save raw text as `page_001.txt`, `page_002.txt`, etc. in `workspace/ocr_output/`
3. **VERIFY** each extracted text by using your Read tool to compare with the image
4. Document any OCR issues in TODO.md for manual correction during translation

### Phase 3: Translation (MOST CRITICAL PHASE)
**Location**: `prompts/03_translation_guide.md`

**ABSOLUTE REQUIREMENTS**:
- Translate ONE PAGE AT A TIME
- Save each translation separately as `page_001_fr.txt`, etc. in `workspace/translations/`
- Do NOT attempt to create scripts to automate translation
- Do NOT try to batch process pages
- Do NOT look for shortcuts

**Why this matters**: You are the translation engine. Your LLM capabilities provide context-aware, scientifically accurate translations that no script can match.

**For each page**:
1. Read the OCR text
2. View the original page image for context
3. Translate with attention to:
   - Scientific terminology
   - Mathematical expressions (preserve LaTeX format)
   - Figure/table references
   - Bibliographic citations
4. Save the translation immediately

### Phase 4: LaTeX Document Creation
**Location**: `prompts/04_latex_guide.md`

Build the final document PAGE BY PAGE:

1. Create initial LaTeX structure with proper headers
2. For EACH page:
   - Read the original page image to understand layout
   - Read the translated text file
   - Add to LaTeX with:
     - `\origpage{X}` marker for original page reference
     - Proper formatting and structure
     - If page contains figures, include the page image with `\includegraphics`
3. Include page number references in headers for easy validation

### Phase 5: PDF Generation
**Location**: `prompts/05_compilation_guide.md`

1. Compile with pdflatex (multiple passes for references)
2. Check for errors and warnings
3. Ensure all figures are properly included

## ⚠️ Critical Reminders

1. **Quality over Speed**: This process will take hours. That's expected and desired.
2. **No Automation for Translation**: Your understanding of context is irreplaceable.
3. **Save Frequently**: After each page translation, save immediately.
4. **Check TODO.md**: Update it constantly. If interrupted, use it to resume.
5. **Verify Everything**: Double-check OCR output, translations, and formatting.

## 🔧 If You're Interrupted

1. First, read TODO.md to see where you left off
2. Check which phase you were in by looking at the workspace directories
3. Count completed files in each directory
4. Resume from the last incomplete task
5. Update TODO.md with your progress

## 📝 Progress Tracking

Maintain clear progress indicators:
- In TODO.md, mark items as: `[ ]` pending, `[x]` completed, `[~]` in progress
- Log any issues or special handling needed
- Note pages that require special attention (complex formulas, tables, etc.)

## 🎯 Final Checklist

Before declaring the task complete:
- [ ] All pages extracted as images
- [ ] All pages processed through OCR
- [ ] All pages translated individually
- [ ] LaTeX document includes all content
- [ ] Original page references are included
- [ ] All figures are properly placed
- [ ] PDF compiles without errors
- [ ] Random spot-checks pass quality review

Remember: The user is counting on your meticulous attention to detail. Take your time, be thorough, and produce a translation they can be proud of.