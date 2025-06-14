# Phase 5: PDF Compilation Guide

## Objective
Compile the LaTeX document into a professional PDF with all figures, references, and formatting properly rendered.

## Pre-Compilation Checklist

Before compiling, verify:
- [ ] All pages are included in the LaTeX document
- [ ] All `\origpage{}` markers are present
- [ ] All image paths are correct
- [ ] LaTeX document ends with `\end{document}`
- [ ] No obvious syntax errors (unmatched braces, etc.)

## Compilation Process

### Step 1: Initial Compilation

```bash
cd workspace/latex_output
pdflatex -interaction=nonstopmode translated_document.tex
```

**Expected behavior**:
- First run will generate `.aux` files
- May show warnings about undefined references
- Will create initial PDF (may have issues)

### Step 2: Second Compilation (References)

```bash
pdflatex -interaction=nonstopmode translated_document.tex
```

**Purpose**: Resolve cross-references, page numbers, and labels

### Step 3: Third Compilation (Final)

```bash
pdflatex -interaction=nonstopmode translated_document.tex
```

**Purpose**: Finalize any remaining references and ensure consistency

## Compilation Script

Create `compile.sh` in `workspace/latex_output/`:

```bash
#!/bin/bash

echo "==================================="
echo "Scientific PDF Translator"
echo "LaTeX Compilation Process"
echo "==================================="

# Clean previous compilation files
echo "🧹 Cleaning previous compilation files..."
rm -f *.aux *.log *.out *.toc *.lof *.lot

# First compilation
echo "📄 First compilation pass..."
pdflatex -interaction=nonstopmode translated_document.tex > compile_1.log 2>&1
if [ $? -eq 0 ]; then
    echo "✅ First pass complete"
else
    echo "❌ First pass failed - check compile_1.log"
    exit 1
fi

# Second compilation
echo "📄 Second compilation pass..."
pdflatex -interaction=nonstopmode translated_document.tex > compile_2.log 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Second pass complete"
else
    echo "❌ Second pass failed - check compile_2.log"
    exit 1
fi

# Third compilation
echo "📄 Third compilation pass..."
pdflatex -interaction=nonstopmode translated_document.tex > compile_3.log 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Third pass complete"
else
    echo "❌ Third pass failed - check compile_3.log"
    exit 1
fi

# Check if PDF was created
if [ -f "translated_document.pdf" ]; then
    SIZE=$(ls -lh translated_document.pdf | awk '{print $5}')
    PAGES=$(pdfinfo translated_document.pdf | grep Pages | awk '{print $2}')
    echo ""
    echo "==================================="
    echo "✅ Compilation successful!"
    echo "==================================="
    echo "📄 File: translated_document.pdf"
    echo "📊 Size: $SIZE"
    echo "📖 Pages: $PAGES"
    echo ""
else
    echo "❌ PDF creation failed!"
    exit 1
fi
```

Make it executable:
```bash
chmod +x compile.sh
./compile.sh
```

## Troubleshooting Common Errors

### 1. Missing Image Files

**Error**: `File 'workspace/extracted_pages/page_001.png' not found`

**Solution**:
- Check if path is correct
- Use absolute paths if needed
- Verify all images exist

### 2. Undefined Control Sequence

**Error**: `Undefined control sequence \somecommand`

**Solution**:
- Check for typos in LaTeX commands
- Ensure required packages are loaded
- Look for unescaped special characters

### 3. Missing $ Inserted

**Error**: `Missing $ inserted`

**Solution**:
- Check math mode delimiters
- Ensure all math content is in math mode
- Look for unmatched $ symbols

### 4. Font Encoding Issues

**Error**: `Unicode char not set up for use with LaTeX`

**Solution**:
- Ensure `\usepackage[utf8]{inputenc}` is included
- Check for special Unicode characters
- Replace problematic characters

### 5. Overfull/Underfull Boxes

**Warning**: `Overfull \hbox (15.0pt too wide)`

**Solution**:
- Usually can be ignored for figures
- For text, check long URLs or formulas
- Consider using `\sloppy` for problem paragraphs

## Post-Compilation Verification

### Visual Inspection

1. **Open the PDF**:
   ```bash
   open translated_document.pdf  # macOS
   xdg-open translated_document.pdf  # Linux
   start translated_document.pdf  # Windows
   ```

2. **Check each section**:
   - Title page formatting
   - Page headers with original page numbers
   - Figure placement and quality
   - Mathematical formula rendering
   - Table alignment
   - Overall readability

### Automated Checks

```python
#!/usr/bin/env python3
"""
PDF validation script
"""

import subprocess
import sys
from pathlib import Path

def check_pdf(pdf_path):
    """Validate PDF properties"""
    
    if not Path(pdf_path).exists():
        print(f"❌ PDF not found: {pdf_path}")
        return False
    
    try:
        # Get PDF info
        result = subprocess.run(
            ['pdfinfo', pdf_path],
            capture_output=True,
            text=True
        )
        
        if result.returncode != 0:
            print(f"❌ Error reading PDF info")
            return False
        
        # Parse info
        info = {}
        for line in result.stdout.split('\n'):
            if ':' in line:
                key, value = line.split(':', 1)
                info[key.strip()] = value.strip()
        
        # Display info
        print(f"✅ PDF Validation Results:")
        print(f"   Pages: {info.get('Pages', 'Unknown')}")
        print(f"   File size: {Path(pdf_path).stat().st_size / 1024 / 1024:.2f} MB")
        print(f"   Producer: {info.get('Producer', 'Unknown')}")
        
        return True
        
    except Exception as e:
        print(f"❌ Error validating PDF: {e}")
        return False

if __name__ == "__main__":
    check_pdf("translated_document.pdf")
```

## Final Quality Checklist

- [ ] All pages present and in order
- [ ] Original page numbers visible in headers
- [ ] Figures properly rendered
- [ ] Mathematical formulas correct
- [ ] French text properly displayed (accents, etc.)
- [ ] No missing content warnings
- [ ] Professional appearance

## Optimization (Optional)

### Reduce File Size

```bash
# Using GhostScript (if installed)
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
   -dNOPAUSE -dQUIET -dBATCH -sOutputFile=translated_document_compressed.pdf \
   translated_document.pdf
```

### Add Metadata

```latex
% Add to preamble
\usepackage[
    pdfauthor={Translated by Scientific PDF Translator},
    pdftitle={Document Title - French Translation},
    pdfsubject={Scientific Translation},
    pdfkeywords={translation, scientific, French}
]{hyperref}
```

## Delivery

Final files to preserve:
1. `translated_document.tex` - Source LaTeX
2. `translated_document.pdf` - Final PDF
3. `compile_3.log` - Final compilation log
4. All source materials in workspace/

Congratulations! You've completed a professional scientific document translation.