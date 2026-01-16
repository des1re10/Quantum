# System Architecture

*Last Updated: January 2026*

---

## Overview

Quantum is a **static documentation website** for post-quantum cryptography research. Unlike full-stack applications, it has no backend server, database, or dynamic content generation.

```
Static HTML/CSS → Nginx → Browser
       ↑
  Research Papers (Markdown/PDF)
```

---

## Technology Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Frontend | Pure HTML/CSS | Landing page and navigation |
| Papers | Markdown + PDF | Research documentation |
| Hosting | Nginx | Static file serving |
| SSL | Let's Encrypt | HTTPS certificates |
| Deployment | pCloud sync | Windows → Cloud → Server |

---

## Site Structure

### Landing Page (`index.html`)

Single-page website with:
- Project introduction and mission statement
- Paper cards linking to research documents
- Technology overview
- Navigation to papers

### Research Papers (`papers/`)

Each paper is contained in its own directory:
```
papers/
└── zkprivacy/
    ├── zkprivacy-quantum-spec-v1.md      # Full specification
    ├── zkprivacy-quantum-spec-v1.pdf     # PDF export
    ├── zkprivacy-verification-guide.md   # Implementation guide
    ├── zkprivacy-verification-guide.pdf  # PDF export
    └── figures/                          # Diagrams and images
```

### Assets (`assets/`)

Static resources:
- `css/style.css` - Main stylesheet
- `images/` - Site images and favicon

---

## Design System

### Brand Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#ffffff`, `#f8f9fa` | Page background |
| Primary | `#4169E1` (RoyalBlue) | Links, buttons, accents |
| Secondary | `#5a7fd4` | Hover states |
| Tertiary | `#2c4a8c` | Active states |
| Text | `#1a1a2e`, `#4a4a5a` | Body text, headings |
| Border | `#dee2e6` | Dividers, card borders |

### Typography

| Purpose | Font Family |
|---------|-------------|
| Headings | Inter (sans-serif) |
| Body | Crimson Pro (serif) |
| Code | JetBrains Mono (monospace) |

---

## Deployment Architecture

### Environments

| Environment | URL | Purpose |
|-------------|-----|---------|
| Production | https://quantum.phexora.ai | Public site |
| Test | https://test.quantum.phexora.ai | Staging |
| Local | http://localhost:8080 | Development |

### Deployment Flow

```
Windows Development
       │
       ▼
deploy_testing.bat ──► pCloud (sync)
                           │
                           ▼
                    quantum_deploy_script.sh (server)
                           │
                           ▼
                    /var/www/quantum/
                           │
                           ▼
                    run_quantum.sh (nginx config)
```

### Server Configuration

The `run_quantum.sh` script:
1. Creates maintenance page
2. Manages SSL certificates via Let's Encrypt
3. Generates nginx configuration
4. Reloads nginx service

---

## Paper Format

### Why Markdown?

Research papers are written in Markdown for:
- **Version control**: Clean diffs, easy collaboration
- **Portability**: Convert to PDF, LaTeX, HTML
- **Simplicity**: Focus on content, not formatting
- **Accessibility**: Readable in any text editor

### PDF Generation

PDFs are generated using DocWizard-Pro (Pandoc-based):
```bash
./build-pdfs.sh    # Linux
build-pdfs.bat     # Windows
```

---

## Content Principles

1. **Academic but accessible** - Rigorous content, clear explanations
2. **Technical accuracy** - Correct over simplified
3. **Structured** - Clear headers, logical flow
4. **Self-contained** - Each paper stands alone

---

## Infrastructure Dependencies

### Shared Libraries

| Library | Path | Usage |
|---------|------|-------|
| Deploy Functions | `Libraries/Scripts/deploy_functions.sh` | Deployment utilities |
| Deploy Common | `Libraries/Scripts/deploy_common.sh` | Common deployment logic |
| Common Functions | `Libraries/Scripts/common_functions.sh` | Shared bash utilities |

### No Backend Dependencies

Unlike other Phexora projects, Quantum has:
- No Python backend
- No database (Redis/PostgreSQL)
- No authentication system
- No API endpoints

---

## Related Projects

| Project | Relationship |
|---------|-------------|
| TheLastLight | Similar static site architecture |
| PhexoraAI | Parent organization website |
| Libraries/Scripts | Shared deployment infrastructure |

---

*This document describes the technical architecture of the Quantum static site.*
