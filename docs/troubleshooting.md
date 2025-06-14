# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### Tesseract Not Found

**Problem**: `tesseract: command not found`

**Solutions**:
- **macOS**: Run `brew install tesseract`
- **Linux**: Run `sudo apt-get install tesseract-ocr` (Ubuntu/Debian)
- **Windows**: Download from [GitHub](https://github.com/UB-Mannheim/tesseract/wiki)

#### Python Version Issues

**Problem**: `Python 3.11+ required`

**Solutions**:
- Install Python 3.11 or higher
- Use pyenv to manage Python versions
- Check `python3 --version` or `python --version`

#### LaTeX Not Installing

**Problem**: LaTeX installation fails or takes too long

**Solutions**:
- **macOS**: Use `brew install --cask basictex` for smaller installation
- **Linux**: Install `texlive-base` first, then add packages as needed
- **Windows**: Download MiKTeX directly from website

### OCR Quality Issues

#### Poor Text Recognition

**Symptoms**:
- Garbled characters
- Missing text sections
- Incorrect special characters

**Solutions**:
1. Increase image resolution (zoom factor 3.0 or higher)
2. Pre-process images:
   ```python
   from PIL import Image, ImageEnhance
   
   # Enhance contrast
   image = Image.open("page.png")
   enhancer = ImageEnhance.Contrast(image)
   enhanced = enhancer.enhance(2.0)
   ```
3. Try different Tesseract PSM modes
4. Consider manual transcription for critical pages

#### Mathematical Formula Recognition

**Problem**: Formulas are not recognized correctly

**Solution**: This is a known Tesseract limitation. During translation:
1. Identify formula locations in original image
2. Manually reconstruct formulas in LaTeX
3. Use the original image as reference

### Translation Challenges

#### Context Loss Between Pages

**Problem**: Losing context when translating page by page

**Solutions**:
1. Read ahead 1-2 pages for context
2. Maintain a glossary of terms
3. Keep previous translations open for reference
4. Note continuing sentences in TODO.md

#### Technical Terminology Consistency

**Problem**: Same term translated differently

**Solution**: Create a terminology file:
```markdown
# terminology.md
- earthquake -> séisme (NOT tremblement de terre)
- soil pressure -> pression du sol
- retaining wall -> mur de soutènement
```

### LaTeX Compilation Errors

#### Image Not Found

**Error**: `! LaTeX Error: File 'page_001.png' not found.`

**Solutions**:
1. Use absolute paths
2. Check file exists: `ls workspace/extracted_pages/page_001.png`
3. Verify path in LaTeX: `\includegraphics{../../extracted_pages/page_001.png}`

#### Unicode/Encoding Errors

**Error**: `Unicode character not set up for use with LaTeX`

**Solutions**:
1. Ensure UTF-8 encoding in LaTeX:
   ```latex
   \usepackage[utf8]{inputenc}
   \usepackage[T1]{fontenc}
   ```
2. Replace problematic characters:
   - Smart quotes → Regular quotes
   - Em dash → Double hyphen
   - Special spaces → Regular spaces

#### Memory Exceeded

**Error**: `TeX capacity exceeded`

**Solutions**:
1. Split document into chapters
2. Compile chapters separately
3. Increase TeX memory limits
4. Reduce image resolutions

### Performance Issues

#### Slow OCR Processing

**Problem**: OCR takes hours for large documents

**Solutions**:
1. Process in parallel (if system allows)
2. Use lower resolution for text-only pages
3. Skip blank pages
4. Run overnight

#### Large File Sizes

**Problem**: Final PDF is too large

**Solutions**:
1. Compress images before including
2. Use PDF compression tools
3. Include only necessary figure pages
4. Reduce image resolution in LaTeX:
   ```latex
   \includegraphics[width=0.8\textwidth]{image.png}
   ```

### Claude-Specific Issues

#### Interruption Recovery

**Problem**: Claude stopped mid-process

**Solution**:
1. Ask: "Please read TODO.md and continue where we left off"
2. Check last completed file
3. Verify partial work saved
4. Resume from last checkpoint

#### Memory Limitations

**Problem**: Claude forgets earlier context

**Solution**:
1. Regularly save progress
2. Use TODO.md as external memory
3. Break work into smaller sessions
4. Remind Claude of critical information

### Quality Assurance

#### Detecting Missing Content

**Problem**: Some content not translated

**Solutions**:
1. Compare page counts
2. Check file sizes
3. Random spot checks
4. Use diff tools on OCR vs translation

#### Verification Strategy

For every 50 pages:
1. Random check 5 pages
2. Verify complex pages (formulas, tables)
3. Check figure inclusions
4. Test PDF navigation

### Emergency Procedures

#### Complete System Failure

If everything fails:
1. Preserve all work in workspace/
2. Document stopping point
3. Create recovery checklist
4. Consider alternative approaches

#### Partial Success

If only some parts work:
1. Identify working components
2. Manual workarounds for failures
3. Hybrid approach (automated + manual)
4. Document limitations

## Getting Help

If you encounter issues not covered here:

1. **Check logs**: All scripts generate detailed logs
2. **Community**: Open an issue on the GitHub repository
3. **Documentation**: Re-read relevant phase guides
4. **Manual fallback**: Some tasks may require manual intervention

Remember: This tool prioritizes quality over automation. Manual intervention is sometimes the best solution.