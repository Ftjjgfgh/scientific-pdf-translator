# Scientific PDF Translator - Project Structure

```
scientific-pdf-translator/
│
├── README.md                 # Project overview and quick start guide
├── CLAUDE.md                # Detailed instructions for Claude
├── LICENSE                  # MIT License with additional terms
├── PROJECT_STRUCTURE.md     # This file
├── .gitignore              # Git ignore configuration
│
├── scripts/                 # Installation and utility scripts
│   ├── install_macos.sh    # macOS installation script
│   ├── install_linux.sh    # Linux installation script
│   └── install_windows.ps1 # Windows PowerShell installation script
│
├── prompts/                 # Phase-by-phase guides for Claude
│   ├── 01_extraction_guide.md    # PDF to PNG extraction
│   ├── 02_ocr_guide.md          # OCR processing
│   ├── 03_translation_guide.md   # Translation process (most critical)
│   ├── 04_latex_guide.md        # LaTeX document generation
│   └── 05_compilation_guide.md   # PDF compilation
│
├── docs/                    # Additional documentation
│   ├── troubleshooting.md  # Common issues and solutions
│   └── sample_workflow.md  # Example translation workflow
│
└── workspace/              # Working directory (git-ignored)
    ├── .gitkeep           # Ensures directory is tracked
    ├── document.pdf       # User's PDF document (not tracked)
    ├── extracted_pages/   # PNG images of each page
    ├── ocr_output/       # Raw OCR text files
    ├── translations/     # Translated text files
    └── latex_output/     # Final LaTeX and PDF output
```

## File Purposes

### Root Files
- **README.md**: Entry point for new users, project philosophy
- **CLAUDE.md**: Core instructions that Claude must follow
- **LICENSE**: Legal framework for usage
- **.gitignore**: Prevents user data from being committed

### Scripts Directory
Platform-specific installation scripts that:
- Install required system packages
- Set up Python environment
- Configure necessary tools
- Create workspace structure

### Prompts Directory
Detailed guides for each translation phase:
1. **Extraction**: Converting PDF pages to images
2. **OCR**: Extracting text from images
3. **Translation**: The core translation process
4. **LaTeX**: Building the formatted document
5. **Compilation**: Creating the final PDF

### Docs Directory
Supporting documentation:
- **Troubleshooting**: Solutions for common problems
- **Sample Workflow**: Real-world usage example

### Workspace Directory
User's working area containing:
- Input PDF document
- All intermediate files
- Final translated output

## Design Principles

1. **Clarity**: Every file has a clear, single purpose
2. **Modularity**: Each phase is self-contained
3. **Guidance**: Extensive documentation at every step
4. **Safety**: User data isolated in workspace/
5. **Quality**: Focus on accuracy over automation

## Usage Flow

1. User clones repository
2. Runs installation script
3. Places PDF in workspace/
4. Launches Claude with CLAUDE.md
5. Claude follows phase guides
6. User monitors progress
7. Final PDF produced

This structure ensures a systematic, high-quality translation process.