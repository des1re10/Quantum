# CLAUDE.md - Quantum

**Project**: Quantum - Post-Quantum Cryptography Research
**Version**: 1.0.0
**Purpose**: Static documentation website for post-quantum cryptography research papers
**URL**: https://quantum.phexora.ai

---

## Common Development Guidelines

@~/.claude/CLAUDE.md

---

## Project Overview

**Quantum** is Phexora's research initiative for post-quantum cryptography. This repository hosts research papers, specifications, and documentation for cryptographic protocols designed to be secure against quantum computer attacks.

### Current Papers

1. **ZKPrivacy** - Quantum-Secure Privacy Blockchain
   - Full specification for a privacy-by-default blockchain using post-quantum cryptography
   - Designed for AI-verifiable implementation
   - Uses SPHINCS+, ML-KEM, STARKs, and lattice-based commitments

### Project Type

This is a **static documentation website**, NOT a full-stack application:
- No Python backend
- No React frontend
- No database
- Pure HTML/CSS with Markdown papers

---

## Technology Stack

```yaml
Frontend:
  Type: Static HTML/CSS
  Framework: None (vanilla)
  Styling: Custom CSS (dark theme)

Papers:
  Format: Markdown
  Future: LaTeX for PDF generation

Hosting:
  Server: Nginx (static files)
  Domain: quantum.phexora.ai
  SSL: Let's Encrypt (auto-managed by run_quantum.sh)
```

---

## Project Structure

```
Quantum/
├── index.html                    # Landing page
├── papers/                       # Research papers
│   └── zkprivacy/
│       ├── zkprivacy-quantum-spec-v1.md
│       └── zkprivacy-verification-guide.md
├── assets/
│   ├── css/style.css
│   └── images/
├── Documentation/
│   ├── ProjectStructure.md
│   └── ReleaseNotes.md
├── tools/Scripts/Startup/
│   ├── quantum_deploy_script.sh  # Deployment from pCloud
│   └── run_quantum.sh            # Nginx/SSL setup
├── README.md
├── CLAUDE.md
└── .gitignore
```

---

## Scripts

### Deployment Script (`quantum_deploy_script.sh`)

Uses shared libraries: `deploy_functions.sh` + `deploy_common.sh`

```bash
# On Linux server (not WSL)
~/Quantum/Quantum/tools/Scripts/Startup/quantum_deploy_script.sh
```

What it does:
1. Syncs files from pCloud to server
2. Copies to `/var/www/quantum/`
3. Sets permissions
4. Calls `run_quantum.sh` for nginx setup

### Startup Script (`run_quantum.sh`)

Uses shared library: `common_functions.sh`

```bash
# Called automatically by deploy script, or manually:
~/Quantum/Quantum/tools/Scripts/Startup/run_quantum.sh
```

What it does:
1. Creates maintenance page
2. Checks/renews SSL certificate
3. Generates nginx configuration
4. Reloads nginx

---

## Development Workflow

### Local Testing

```bash
# Simple Python server for local preview
cd /mnt/d/workspace/VisualStudio/Quantum
python3 -m http.server 8080
# Open: http://localhost:8080
```

### Deployment

1. **On Windows**: Commit changes, run `deploy_testing.bat`
2. **On Server**: Run `quantum_deploy_script.sh`

---

## Editing Papers

### Paper Format

Papers are written in Markdown for:
- Easy version control and diffs
- Collaboration via pull requests
- Future conversion to LaTeX/PDF

### Adding a New Paper

1. Create directory: `papers/new-paper-name/`
2. Add Markdown files for content
3. Add figures to `papers/new-paper-name/figures/`
4. Update `index.html` with paper card
5. Update `Documentation/ReleaseNotes.md`

### Paper Card Template (for index.html)

```html
<article class="paper-card">
    <div class="paper-header">
        <span class="paper-status">Draft v1.0</span>
        <span class="paper-date">Month Year</span>
    </div>
    <h3>Paper Title</h3>
    <p class="paper-abstract">
        Brief description of the paper...
    </p>
    <div class="paper-tech">
        <span class="tech-tag">Technology 1</span>
        <span class="tech-tag">Technology 2</span>
    </div>
    <div class="paper-links">
        <a href="papers/paper-name/main.md" class="btn btn-primary">
            Read Paper
        </a>
    </div>
</article>
```

---

## Design Guidelines

### Brand Colors

- **Background**: Dark (#0a0a0f, #12121a)
- **Primary Accent**: Indigo (#6366f1)
- **Secondary Accent**: Purple (#8b5cf6)
- **Tertiary Accent**: Cyan (#06b6d4)
- **Text**: Light grays (#e8e8f0, #a0a0b0)

### Typography

- **Headings**: Inter (sans-serif)
- **Code/Technical**: JetBrains Mono (monospace)

### Content Principles

- Academic but accessible tone
- Technical accuracy over marketing speak
- Clear structure with headers
- Code examples where relevant

---

## Code Style

- Use semantic HTML5 elements
- CSS in external stylesheet (not inline)
- No JavaScript unless absolutely necessary
- Mobile-first responsive design
- Optimize images before adding

---

## Important Notes

- This is a **static site** - no server-side processing
- All content updates are done by editing files directly
- Papers should be self-contained in their directories
- The site is hosted as a subdomain of phexora.ai
- No user authentication or dynamic features
- Nginx config is auto-generated by `run_quantum.sh` (not manually edited)

---

## Related Projects

- **SupplyShield-Pro**: Uses Midnight Network ZK proofs (production implementation)
- **TheLastLight**: Similar static site structure (event website)
- **Libraries/Python**: Shared infrastructure (not used by this project)
- **Libraries/Scripts**: Shared bash functions (used by deployment/startup scripts)

---

*This document should be updated when new papers are added or site structure changes.*
