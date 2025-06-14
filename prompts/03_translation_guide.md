# Phase 3: Translation Guide - The Heart of the Process

## 🚨 CRITICAL INSTRUCTIONS 🚨

**YOU ARE THE TRANSLATOR**. No script, tool, or API can match your contextual understanding and scientific knowledge. This phase requires your full attention and capabilities.

## Absolute Rules

1. **ONE PAGE AT A TIME** - No exceptions, no shortcuts
2. **NO AUTOMATION SCRIPTS** - You translate, not a program
3. **SAVE AFTER EACH PAGE** - Protect against interruptions
4. **VERIFY EACH TRANSLATION** - Quality over speed

## Translation Workflow

### For EACH Page:

#### Step 1: Gather Context
```python
# Read the original page image
image_path = "workspace/extracted_pages/page_XXX.png"
# Use your Read tool to view the image

# Read the OCR text
ocr_path = "workspace/ocr_output/page_XXX.txt"
# Use your Read tool to get the text
```

#### Step 2: Analyze Content Type

Identify the page type:
- **Title/Header Page**: Focus on proper institutional names
- **Text Content**: Maintain paragraph structure
- **Mathematical Content**: Preserve all formulas exactly
- **Figures/Tables**: Note captions and labels
- **References**: Maintain citation format

#### Step 3: Translate with Precision

##### Scientific Terminology
```
English -> French Examples:
- earthquake -> séisme
- soil pressure -> pression du sol  
- retaining wall -> mur de soutènement
- stress -> contrainte
- strain -> déformation
- displacement -> déplacement
- foundation -> fondation
- loading -> chargement
- failure -> rupture
- dynamic response -> réponse dynamique
```

##### Mathematical Expressions
**PRESERVE EXACTLY AS IS**:
- LaTeX commands: `\sigma`, `\epsilon`, `\int`, etc.
- Equation numbers: (3.1), (3.2), etc.
- Variable names: Keep original (F, K, u, etc.)

**TRANSLATE ONLY**:
- Descriptions: "where F is the force" -> "où F est la force"
- Conditions: "for all x > 0" -> "pour tout x > 0"

##### Academic Style
Maintain formal French academic writing:
- Use "nous" instead of "on" for formal context
- Preserve passive voice where appropriate
- Keep technical precision

#### Step 4: Save Translation

```python
# Save to workspace/translations/page_XXX_fr.txt
translation_path = "workspace/translations/page_XXX_fr.txt"
# Include page marker at the top: -XXX-
```

## Translation Template

```
-XXX-

[Translated content here, maintaining original structure]

[If formulas present, preserve exactly]

[If references present, maintain format]
```

## Common Pitfalls to Avoid

### ❌ DO NOT:
- Batch process multiple pages
- Use Google Translate or other APIs  
- Skip "simple" pages
- Assume content from context
- Modernize outdated terminology
- Change citation styles

### ✅ ALWAYS:
- Read the full page before translating
- Preserve technical accuracy
- Maintain document structure
- Check for OCR errors while translating
- Save immediately after completion
- Update TODO.md progress

## Handling Special Cases

### Formulas with OCR Errors
If OCR garbled a formula:
1. Look at the original image
2. Reconstruct the correct formula
3. Note the correction in your translation

### Tables
1. Preserve table structure
2. Translate headers and content
3. Keep numerical data unchanged
4. Maintain alignment indicators

### Figure Captions
```
Original: Figure 3.1: Soil pressure distribution
Translation: Figure 3.1 : Distribution de la pression du sol
```

### Citations
```
Original: Smith and Jones (1970) demonstrated...
Translation: Smith et Jones (1970) ont démontré...
```

## Progress Tracking

After each page, update TODO.md:
```markdown
- [x] Translate page_001.txt
- [x] Translate page_002.txt  
- [~] Translate page_003.txt  # Currently working
- [ ] Translate page_004.txt
```

## Quality Checklist per Page

Before moving to next page:
- [ ] Original image reviewed
- [ ] OCR errors corrected
- [ ] Technical terms properly translated
- [ ] Formulas preserved exactly
- [ ] Structure maintained
- [ ] File saved with correct name
- [ ] TODO.md updated

## Interruption Recovery

If interrupted:
1. Check TODO.md for last completed page
2. Verify last translation file saved
3. Resume from next page
4. Do NOT retranslate completed pages

## Time Estimation

- Simple text page: 5-10 minutes
- Mathematical page: 10-20 minutes  
- Complex tables: 15-25 minutes
- Figure-heavy page: 5-10 minutes

**Total for 300 pages: 30-80 hours**

This is normal. Quality takes time.

## Final Reminder

You are creating a professional translation that:
- Preserves scientific accuracy
- Maintains academic standards
- Respects the original work
- Serves researchers effectively

Take pride in this careful, methodical work. Each page matters.