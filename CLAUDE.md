# CLAUDE.md - Quantum

> CRITICAL: Apply audit prompts from the `CRITICAL: Audit Prompt Compliance (Mandatory)` section before any code/review work.

**Project**: Quantum - Post-Quantum Cryptography Research
**Version**: 1.0.0
**Purpose**: Static documentation website for post-quantum cryptography research papers
**URL**: https://quantum.phexora.ai

---

## Common Development Guidelines

@~/.claude/CLAUDE.md

---

## Project Overview

**Quantum** is Phexora AI's research initiative for post-quantum cryptography. This repository hosts research papers, specifications, and documentation for cryptographic protocols designed to be secure against quantum computer attacks.

### Current Papers

1. **Quantum** - Privacy-Preserving DAG Blockchain
   - Research specification for the first blockchain combining DAG consensus with full privacy
   - Targets 1,000+ TPS on L1 using GhostDAG consensus
   - Post-quantum security: SPHINCS+, ML-KEM, STARKs, lattice commitments
   - Designed for AI-verifiable implementation
   - Core research challenge: privacy-preserving proofs over parallel block structures

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
  Styling: Custom CSS (light academic theme)

Papers:
  Format: Markdown with YAML frontmatter
  PDF Generation: DocWizard-Pro (Pandoc-based)

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

See `AGENTS.md` for local start commands.

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

- **Background**: Light (#ffffff, #f8f9fa)
- **Primary Accent**: RoyalBlue (#4169E1)
- **Secondary Accent**: Light Blue (#5a7fd4)
- **Tertiary Accent**: Dark Blue (#2c4a8c)
- **Text**: Dark grays (#1a1a2e, #4a4a5a)
- **Borders**: Light gray (#dee2e6)

### Typography

- **Headings**: Inter (sans-serif)
- **Body Text**: Crimson Pro (serif)
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

## CRITICAL: Audit Prompt Compliance (Mandatory)
- Load the canonical index first: `/mnt/d/workspace/VisualStudio/Libraries/Scripts/audit_prompts/README.md`.
- Use the full prompt set directory as source of truth: `/mnt/d/workspace/VisualStudio/Libraries/Scripts/audit_prompts/`.

### Baseline Audits (Always Apply)
- `02_architecture_principles.md`.
- `03_defensive_programming_violations.md`.
- `05_security_patterns.md`.
- `06_logger_patterns.md` (especially Rule 5: static `warning/error` + dynamic `debug` details).
- `19_path_and_structure_audit.md`.
- `26_techstack_consistency.md`.

### Change-Type Audits (Apply When Relevant)
- Backend Python/FastAPI/Tkinter: `04_interface_validation.md`, `07_async_patterns.md`, `12_testing_standards.md`, `17_redis_backup_audit.md`, `18_redis_storage_consistency.md`, `20_url_endpoint_audit.md`, `25_shutdown_reason_tracking.md`.
- Bash/Deployment/Startup scripts: `21_bash_script_consistency.md`, `22_deployment_script_consistency.md`.
- Frontend/UI work: `14_frontend_visuals_and_mobile_standards.md`, `16_language_quality_no_ai_tone.md`.
- Docs/Marketing/Legal text: `13_documentation_audit.md`, `15_marketing_claims_and_conversion_audit.md`, `27_legal_compliance_audit.md`, `28_prompt_scope_cleanup.md`.
- Payments/Email workflows: `23_payment_integration_audit.md`, `24_email_services_audit.md`.
- Additional domain prompts when touched: `01_code_redundancies.md`, `08_enum_signal_patterns.md`, `09_dead_code_detection.md`, `10_complexity_analysis.md`, `11_naming_and_comment_standards.md`.

### Mandatory Execution Rule
- In every substantial implementation/review response, explicitly list the audit prompt files applied.
- If a prompt is not applicable, state why it is out of scope.
