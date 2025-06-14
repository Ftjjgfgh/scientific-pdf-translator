# Phase 4: LaTeX Document Generation Guide

## Objective
Transform translated text into a professionally formatted LaTeX document that preserves the original's academic structure while providing reference tracking.

## LaTeX Document Structure

### Initial Setup

```latex
\documentclass[12pt,letterpaper]{report}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}
\usepackage{geometry}
\usepackage{graphicx}
\usepackage{amsmath,amssymb}
\usepackage{float}
\usepackage{fancyhdr}
\usepackage{setspace}

% Page geometry
\geometry{
    top=1in,
    bottom=1in,
    left=1.25in,
    right=1in
}

% Line spacing
\onehalfspacing

% Original page tracking
\newcommand{\origpage}[1]{\def\currentorigpage{#1}}
\origpage{1}

% Header setup with original page reference
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\thepage}
\fancyhead[R]{\small\textit{Page originale : \currentorigpage}}
\renewcommand{\headrulewidth}{0.4pt}

\begin{document}
```

## Page-by-Page Construction Process

### For EACH Page:

#### Step 1: Read Original Page Image
```python
# View the original page
image_path = "workspace/extracted_pages/page_XXX.png"
# Understand layout, structure, and special elements
```

#### Step 2: Read Translated Text
```python
# Get the translated content
translation_path = "workspace/translations/page_XXX_fr.txt"
```

#### Step 3: Add to LaTeX Document

##### Basic Page Template
```latex
% PAGE XXX
\origpage{XXX}

[Page content here with appropriate LaTeX formatting]

\newpage
```

##### For Title Pages
```latex
% PAGE 1
\origpage{1}
\thispagestyle{empty}
\begin{center}
\vspace*{2in}
{\Large\textbf{TITRE DU DOCUMENT}}\\
\vspace{1in}
{\large Auteur}\\
\vspace{0.5in}
Date
\end{center}
\newpage
```

##### For Text Content
```latex
% PAGE XXX
\origpage{XXX}

\section{Titre de Section}

Paragraphe de texte avec \textbf{mise en évidence} et 
\emph{italiques} selon l'original.

\subsection{Sous-section}

Contenu avec formules inline $F = ma$ et display :

\begin{equation}
\sigma = E \epsilon
\label{eq:XXX}
\end{equation}

où $\sigma$ est la contrainte, $E$ est le module de Young, 
et $\epsilon$ est la déformation.

\newpage
```

##### For Figure Pages
```latex
% PAGE XXX  
\origpage{XXX}

\begin{figure}[H]
\centering
\includegraphics[width=\textwidth]{workspace/extracted_pages/page_XXX.png}
\caption{Légende de la figure traduite}
\label{fig:XXX}
\end{figure}

\newpage
```

##### For Tables
```latex
% PAGE XXX
\origpage{XXX}

\begin{table}[H]
\centering
\caption{Titre du tableau}
\begin{tabular}{lcc}
\hline
Paramètre & Symbole & Valeur \\
\hline
Module de cisaillement & $G$ & 10 MPa \\
Coefficient de Poisson & $\nu$ & 0.3 \\
\hline
\end{tabular}
\label{tab:XXX}
\end{table}

\newpage
```

## Special Formatting Cases

### Mathematical Equations

#### Simple Equations
```latex
L'équation du mouvement est :
\[
M\ddot{u} + C\dot{u} + Ku = F(t)
\]
```

#### Numbered Equations
```latex
\begin{equation}
\nabla^2 u = \frac{1}{c^2}\frac{\partial^2 u}{\partial t^2}
\label{eq:wave}
\end{equation}
```

#### Equation Arrays
```latex
\begin{align}
\sigma_{xx} &= \lambda(\epsilon_{xx} + \epsilon_{yy}) + 2\mu\epsilon_{xx} \\
\sigma_{yy} &= \lambda(\epsilon_{xx} + \epsilon_{yy}) + 2\mu\epsilon_{yy} \\
\tau_{xy} &= 2\mu\epsilon_{xy}
\end{align}
```

### Lists and Enumerations

```latex
Les hypothèses principales sont :
\begin{enumerate}
\item Comportement élastique linéaire
\item Petites déformations
\item Milieu homogène et isotrope
\end{enumerate}
```

### Citations and References

```latex
Selon \cite{author1970}, la théorie prédit...

Les recherches récentes \cite{smith2020,jones2021} montrent...
```

## Figure Integration Strategy

### When to Include Full Page Image

Include the full page image when:
1. Page contains complex diagrams
2. Mathematical derivations with special layouts
3. Tables with complex formatting
4. Any visual element beyond simple text

### Image Inclusion Code
```latex
\begin{figure}[H]
\centering
\includegraphics[width=0.9\textwidth]{workspace/extracted_pages/page_XXX.png}
\end{figure}
```

## Building Process

### Step-by-Step Approach

1. **Initialize Document**
   - Create `workspace/latex_output/translated_document.tex`
   - Add preamble and setup

2. **Process Each Page**
   ```
   For page 1 to N:
     - Read original image
     - Read translated text
     - Determine page type
     - Apply appropriate LaTeX template
     - Add \origpage{} marker
     - Include content/image
     - Add \newpage
   ```

3. **Finalize Document**
   - Add `\end{document}`
   - Save file

### Quality Checks

After every 10 pages:
- [ ] Verify LaTeX syntax (try compilation)
- [ ] Check original page markers
- [ ] Confirm figure references
- [ ] Validate special characters

## Common LaTeX Issues and Solutions

| Issue | Solution |
|-------|----------|
| Special characters (&, %, #) | Escape with backslash: \&, \%, \# |
| Accented characters | Ensure UTF-8 encoding and babel french |
| Figure placement | Use [H] flag with float package |
| Page breaks | Use \newpage explicitly |
| Math mode errors | Check $ pairs and equation environments |

## Final Document Structure

```
workspace/latex_output/
├── translated_document.tex  # Main LaTeX file
├── compile.log             # Compilation log
└── translated_document.pdf # Final output
```

## Important Reminders

- **ALWAYS** include \origpage{} for EVERY page
- **NEVER** skip pages or combine content
- **PRESERVE** original structure and layout
- **INCLUDE** page images for complex content
- **MAINTAIN** consistent formatting throughout

This systematic approach ensures a professional document that serves both as a translation and a reference tool.