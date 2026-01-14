# Quantum - Project Structure

Post-Quantum Cryptography Research by Phexora AI.

**URL**: https://quantum.phexora.ai

## Directory Layout

```
Quantum/
├── index.html                    # Landing page (static HTML)
├── papers/                       # Research papers and specifications
│   └── zkprivacy/               # ZKPrivacy: Quantum-Secure Privacy Blockchain
│       ├── zkprivacy-quantum-spec-v1.md      # Full specification
│       ├── zkprivacy-verification-guide.md   # Implementation & verification guide
│       └── figures/                          # Diagrams and figures
├── assets/
│   ├── css/
│   │   └── style.css            # Main stylesheet
│   └── images/
│       └── favicon.svg          # Site favicon
├── Documentation/
│   ├── ProjectStructure.md      # This file
│   └── ReleaseNotes.md          # Version history
├── tools/
│   └── Scripts/
│       └── Startup/
│           ├── quantum_deploy_script.sh  # Deployment from pCloud to server
│           └── run_quantum.sh            # Nginx/SSL setup
├── README.md                    # Project documentation
├── CLAUDE.md                    # Claude Code guidance
└── .gitignore                   # Git ignore rules
```

## Tech Stack

- **Type**: Static documentation website
- **Frontend**: Pure HTML/CSS (no JavaScript framework)
- **Hosting**: Nginx serving static files
- **Papers**: Markdown format (future: LaTeX for PDF generation)

## URLs

- **Production**: https://quantum.phexora.ai
- **Test**: https://test.quantum.phexora.ai
- **Local Dev**: http://localhost:8080 (via Python http.server)

## Deployment Flow

1. **Windows**: Run `deploy_testing.bat` to sync to pCloud
2. **Server**: Run `quantum_deploy_script.sh` to deploy from pCloud
3. **Server**: Deploy script automatically runs `run_quantum.sh` for nginx setup

## Scripts

### Deployment Script (`quantum_deploy_script.sh`)
- Uses shared `deploy_functions.sh` + `deploy_common.sh`
- Syncs files from pCloud to server
- Copies to `/var/www/quantum/`
- Calls startup script for nginx configuration

### Startup Script (`run_quantum.sh`)
- Uses shared `common_functions.sh`
- Creates maintenance page
- Configures nginx
- Manages SSL certificates (Let's Encrypt)
- No backend server (static site only)

## Paper Format

Research papers are stored in Markdown format for:
- Easy version control
- Readable diffs
- Simple collaboration
- Future conversion to LaTeX/PDF

## Adding New Papers

1. Create a new directory under `papers/`
2. Add Markdown files for the paper content
3. Update `index.html` to include links to the new paper
4. Commit on Windows, deploy to server
