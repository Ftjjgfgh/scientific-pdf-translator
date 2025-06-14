# Phase 1: PDF to PNG Extraction Guide

## Objective
Extract every page of the PDF document as high-resolution PNG images for accurate OCR processing and visual reference.

## Python Script Template

```python
#!/usr/bin/env python3
"""
PDF to PNG extraction script
Extracts all pages from a PDF as high-resolution PNG images
"""

import fitz  # PyMuPDF
from pathlib import Path
import sys

def extract_pdf_pages(pdf_path, output_dir, zoom_factor=2.0):
    """
    Extract all pages from a PDF as PNG images
    
    Args:
        pdf_path: Path to the input PDF
        output_dir: Directory to save PNG images
        zoom_factor: Zoom factor for image quality (2.0 = 200% zoom)
    """
    # Ensure output directory exists
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Open PDF
    try:
        pdf_document = fitz.open(pdf_path)
    except Exception as e:
        print(f"Error opening PDF: {e}")
        return False
    
    total_pages = len(pdf_document)
    print(f"PDF contains {total_pages} pages")
    
    # Process each page
    for page_num in range(total_pages):
        # Get page
        page = pdf_document[page_num]
        
        # Create transformation matrix for zoom
        mat = fitz.Matrix(zoom_factor, zoom_factor)
        
        # Render page to image
        pix = page.get_pixmap(matrix=mat)
        
        # Save as PNG
        output_path = output_dir / f"page_{page_num + 1:03d}.png"
        pix.save(str(output_path))
        
        # Progress indicator
        print(f"Extracted page {page_num + 1}/{total_pages}: {output_path.name}")
    
    pdf_document.close()
    print(f"\nExtraction complete! {total_pages} pages saved to {output_dir}")
    return True

if __name__ == "__main__":
    # Configuration
    pdf_file = "workspace/document.pdf"  # Update with actual filename
    output_folder = "workspace/extracted_pages"
    
    # Check if PDF exists
    if not Path(pdf_file).exists():
        print(f"Error: PDF file not found: {pdf_file}")
        print("Please place your PDF in the workspace directory")
        sys.exit(1)
    
    # Extract pages
    success = extract_pdf_pages(pdf_file, output_folder, zoom_factor=2.0)
    
    if success:
        print("\n✅ Extraction successful!")
        print(f"Next step: Run OCR on the extracted images")
    else:
        print("\n❌ Extraction failed!")
        sys.exit(1)
```

## Quality Considerations

1. **Zoom Factor**: Use 2.0 (200%) minimum for good OCR results
   - For dense text: 2.5-3.0
   - For poor quality scans: 3.0-4.0

2. **Memory Usage**: Large PDFs with high zoom may use significant memory
   - Process in batches if needed
   - Monitor system resources

3. **Storage Space**: High-resolution PNGs require substantial disk space
   - Estimate: ~1-5 MB per page at 200% zoom
   - Ensure adequate free space

## Verification Steps

After extraction, verify:

1. **File Count**: Number of PNGs matches PDF page count
   ```bash
   ls workspace/extracted_pages/*.png | wc -l
   ```

2. **Image Quality**: Spot-check several images
   - Text should be clear and readable
   - No missing portions of pages
   - Proper orientation

3. **File Naming**: Consistent naming pattern
   - page_001.png, page_002.png, etc.
   - Leading zeros for proper sorting

## Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| Out of memory | Reduce zoom factor or process in batches |
| Slow extraction | Normal for large PDFs; be patient |
| Rotated pages | Add rotation correction in script |
| Missing content | Check PDF security settings |

## Important Notes

- **DO NOT** skip pages or process selectively
- **DO NOT** compress or resize images after extraction
- **ALWAYS** verify extraction completeness before proceeding
- **SAVE** extraction log for troubleshooting