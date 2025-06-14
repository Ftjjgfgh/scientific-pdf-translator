# Scientific PDF Translator

A high-quality scientific document translation system powered by Claude Code Max, designed to translate scanned PDF documents from English to French while preserving academic rigor, formatting, and mathematical expressions.

## 🎯 Project Philosophy

This project represents a deliberate choice for **quality over speed**. Unlike industrial translation solutions, this approach leverages the advanced understanding capabilities of Claude, an LLM, to produce translations that maintain scientific accuracy and proper context. While the process may take several hours for large documents, the result is a professionally formatted, accurately translated scientific document.

## 🌟 Key Features

- **Page-by-page precision**: Each page is carefully processed to maintain layout and context
- **OCR integration**: Handles scanned PDFs with high-quality text extraction
- **LaTeX output**: Professional typesetting for academic documents
- **Figure preservation**: Original figures are maintained with translated captions
- **Reference tracking**: Original page numbers are preserved for easy cross-referencing
- **Human-in-the-loop**: Requires user oversight to ensure quality and accuracy

## 🚀 What This Tool Demonstrates

This project showcases the remarkable capabilities of modern AI tools when applied thoughtfully to complex tasks. It demonstrates:
- The power of LLMs in understanding scientific context
- The importance of systematic approaches in document processing
- The value of human oversight in AI-assisted tasks
- The potential for creating beautiful, professionally formatted translations

## 📋 Prerequisites

- **macOS** (tested on MacBook Pro)
- **Claude Code Max** subscription
- **Python 3.11+**
- **Tesseract OCR**
- **MacTeX** (for LaTeX compilation)
- A scanned PDF document in English

## 🛠️ Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/Hugues-DTANKOUO/scientific-pdf-translator.git
   cd scientific-pdf-translator
   ```

2. **Place your PDF**
   ```bash
   cp /path/to/your/document.pdf ./workspace/
   ```

3. **Review installation scripts**
   ```bash
   cat scripts/install_macos.sh
   # Review the commands before executing
   ```

4. **Run installation (if needed)**
   ```bash
   chmod +x scripts/install_macos.sh
   ./scripts/install_macos.sh
   ```

5. **Launch Claude Code**
   ```bash
   claude
   ```

6. **Start the translation process**
   Ask Claude: "Please read the CLAUDE.md file and follow the instructions to translate my PDF document."

## ⚠️ Important Legal Notice

**This tool is provided for personal and educational use only.**

- The generated translations must be used strictly for personal purposes unless you are the original author
- Always respect the copyright and usage policies of the original document
- I am not responsible for any irresponsible or illegal use of this tool
- This is not an invitation to violate copyright for testing purposes
- For any conflicts regarding document usage, strictly refer to the policies described by the authors or owners

## 🔄 Process Overview

1. **Document Analysis**: Claude examines your PDF structure
2. **Page Extraction**: Each page is converted to high-resolution images
3. **OCR Processing**: Text is extracted using Tesseract
4. **Translation**: Claude translates each page individually, maintaining context
5. **LaTeX Generation**: A professional document is created with proper formatting
6. **PDF Compilation**: The final translated document is generated

## 💡 Why This Approach?

While automated translation tools exist, they often fail to capture the nuances of scientific writing. This approach ensures:
- **Contextual accuracy**: Mathematical formulas and technical terms are properly handled
- **Formatting preservation**: The academic structure is maintained
- **Quality assurance**: Each page is individually verified
- **Flexibility**: The process can be paused and resumed

## 🤝 Contributing

This project welcomes contributions! If you have ideas for improvements:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## 📬 Contact

**Hugues DTANKOUO**
- 📧 Email: [huguesdtankouo@gmail.com](mailto:huguesdtankouo@gmail.com)
- 🔗 LinkedIn: [Hugues Dtankouo](https://www.linkedin.com/in/dtankouo)
- 🔗 GitHub: [Hugues-DTANKOUO](https://github.com/Hugues-DTANKOUO)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*This is a personal project and is not affiliated with any employer or organization.*