# Phase 2: OCR Processing Guide

## Objective
Extract text from PNG images using Tesseract OCR, maintaining accuracy for scientific content including formulas, symbols, and technical terminology.

## Python Script Template

```python
#!/usr/bin/env python3
"""
OCR processing script using Tesseract
Extracts text from PNG images with verification
"""

import pytesseract
from PIL import Image
from pathlib import Path
import sys
import re

# Configure Tesseract path if needed
# pytesseract.pytesseract.tesseract_cmd = '/usr/local/bin/tesseract'  # macOS with Homebrew
# pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'  # Windows

def process_image_ocr(image_path, output_path, lang='eng'):
    """
    Process a single image with OCR
    
    Args:
        image_path: Path to input PNG image
        output_path: Path to save OCR text
        lang: OCR language (default: English)
    """
    try:
        # Open image
        image = Image.open(image_path)
        
        # Perform OCR with custom configuration
        custom_config = r'--oem 3 --psm 6'
        text = pytesseract.image_to_string(image, lang=lang, config=custom_config)
        
        # Save extracted text
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(text)
        
        return True, len(text)
    
    except Exception as e:
        print(f"Error processing {image_path}: {e}")
        return False, 0

def verify_ocr_output(text_path, min_chars=100):
    """
    Basic verification of OCR output
    
    Args:
        text_path: Path to OCR text file
        min_chars: Minimum expected characters
    """
    try:
        with open(text_path, 'r', encoding='utf-8') as f:
            text = f.read()
        
        # Basic checks
        char_count = len(text.strip())
        word_count = len(text.split())
        
        # Check for common OCR errors
        suspicious_patterns = [
            r'[|]{5,}',  # Multiple pipe characters
            r'[_]{10,}',  # Long underscores
            r'[\x00-\x1F\x7F-\x9F]',  # Control characters
        ]
        
        issues = []
        if char_count < min_chars:
            issues.append(f"Low character count: {char_count}")
        
        for pattern in suspicious_patterns:
            if re.search(pattern, text):
                issues.append(f"Suspicious pattern found: {pattern}")
        
        return {
            'valid': len(issues) == 0,
            'char_count': char_count,
            'word_count': word_count,
            'issues': issues
        }
    
    except Exception as e:
        return {
            'valid': False,
            'char_count': 0,
            'word_count': 0,
            'issues': [f"Error reading file: {e}"]
        }

def process_all_pages():
    """Process all extracted PNG images with OCR"""
    
    input_dir = Path("workspace/extracted_pages")
    output_dir = Path("workspace/ocr_output")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Get all PNG files
    png_files = sorted(input_dir.glob("page_*.png"))
    
    if not png_files:
        print("No PNG files found in extracted_pages directory!")
        return False
    
    print(f"Found {len(png_files)} pages to process")
    
    # Process each page
    successful = 0
    failed = 0
    verification_log = []
    
    for png_file in png_files:
        page_num = png_file.stem
        output_file = output_dir / f"{page_num}.txt"
        
        print(f"\nProcessing {page_num}...")
        
        # Perform OCR
        success, char_count = process_image_ocr(png_file, output_file)
        
        if success:
            # Verify output
            verification = verify_ocr_output(output_file)
            
            if verification['valid']:
                print(f"✅ {page_num}: {char_count} characters extracted")
                successful += 1
            else:
                print(f"⚠️  {page_num}: OCR completed but with issues:")
                for issue in verification['issues']:
                    print(f"   - {issue}")
                successful += 1  # Still count as successful
                
            verification_log.append({
                'page': page_num,
                'status': 'success',
                'details': verification
            })
        else:
            print(f"❌ {page_num}: OCR failed")
            failed += 1
            verification_log.append({
                'page': page_num,
                'status': 'failed',
                'details': None
            })
    
    # Summary
    print(f"\n{'='*50}")
    print(f"OCR Processing Complete")
    print(f"{'='*50}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")
    print(f"Total: {len(png_files)}")
    
    # Save verification log
    log_path = output_dir / "ocr_verification.log"
    with open(log_path, 'w', encoding='utf-8') as f:
        for entry in verification_log:
            f.write(f"{entry['page']}: {entry['status']}\n")
            if entry['details'] and entry['details']['issues']:
                for issue in entry['details']['issues']:
                    f.write(f"  - {issue}\n")
    
    return failed == 0

if __name__ == "__main__":
    # Check Tesseract installation
    try:
        version = pytesseract.get_tesseract_version()
        print(f"Tesseract version: {version}")
    except Exception as e:
        print(f"Error: Tesseract not found or not properly configured")
        print(f"Details: {e}")
        sys.exit(1)
    
    # Process all pages
    if process_all_pages():
        print(f"\n✅ All pages processed successfully!")
        print(f"OCR output saved in: workspace/ocr_output/")
        print(f"\nIMPORTANT: Manually verify OCR quality before translation!")
    else:
        print(f"\n⚠️  Some pages failed to process")
        print(f"Check the verification log for details")
```

## OCR Configuration Tips

### For Scientific Documents

1. **Page Segmentation Mode (PSM)**:
   - `--psm 6`: Uniform block of text (default, good for most pages)
   - `--psm 3`: Fully automatic page segmentation
   - `--psm 11`: Sparse text (for pages with scattered formulas)

2. **OCR Engine Mode (OEM)**:
   - `--oem 3`: Default, uses both legacy and LSTM engines

3. **Language Settings**:
   - English: `lang='eng'`
   - Multiple languages: `lang='eng+fra'`

### Handling Mathematical Content

Tesseract has limitations with mathematical formulas. For pages with heavy math content:

1. **Note formula locations** during verification
2. **Flag pages** that need special attention
3. **Plan to manually correct** formulas during translation

## Verification Protocol

### After OCR completion, YOU MUST:

1. **Use your Read tool** to compare OCR output with original images
2. **Check for**:
   - Missing sections of text
   - Garbled characters in formulas
   - Incorrect special characters
   - Lost formatting indicators

3. **Document issues** in TODO.md for correction during translation

### Common OCR Errors in Scientific Text

| Original | OCR Error | Notes |
|----------|-----------|-------|
| α (alpha) | a or α | Often misread |
| ∑ (sum) | Σ or E | Context needed |
| ∫ (integral) | J or | | Vertical line |
| subscripts | Regular text | Position lost |
| superscripts | Regular text | Position lost |

## Quality Assurance Checklist

- [ ] All pages have OCR output files
- [ ] No empty or near-empty files
- [ ] Spot-checked 10% of pages manually
- [ ] Documented problematic pages
- [ ] Saved verification log
- [ ] Ready for translation phase

## Important Reminders

- **DO NOT** rely solely on automated verification
- **DO NOT** proceed without manual spot-checks
- **ALWAYS** use Read tool to verify critical pages
- **DOCUMENT** all issues for translation phase