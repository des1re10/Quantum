# Quantum - Project Structure

Post-Quantum Cryptography Research by Phexora AI.

**URL**: https://quantum.phexora.ai

---

## About This Project

**Quantum** is Phexora AI's research initiative addressing one of the most significant upcoming challenges in blockchain security: the threat posed by quantum computers.

### Why This Project Exists

Current blockchain systems rely on elliptic curve cryptography (ECC) for signatures and key exchange. When sufficiently powerful quantum computers become available, Shor's algorithm will break these cryptographic primitives, potentially compromising billions of dollars in digital assets. This isn't a distant theoretical concern---adversaries can already harvest encrypted data today to decrypt later when quantum capabilities mature ("harvest now, decrypt later" attacks).

**Quantum** is our response: a research specification for a blockchain that is:

- **High-throughput L1**: DAG-based consensus (GhostDAG) targeting 1,000+ TPS with parallel block creation
- **Privacy-by-default**: Every transaction is private, with no opt-out mechanism---Monero-level anonymity
- **Quantum-secure**: Lattice-based cryptography, hash-based signatures, and STARKs---all resistant to known quantum attacks
- **Truly decentralized**: No trusted setup ceremonies, no privileged parties, permissionless PoW mining
- **AI-verifiable**: Designed to be formally verified and implemented by advanced AI systems

**The core research challenge**: No existing blockchain combines DAG-based consensus with full transaction privacy. Kaspa achieves high throughput but lacks privacy. Monero provides privacy but is limited to ~10 TPS. Quantum aims to solve both.

### Current Status

This is an active research project. The specifications are in draft form and open for community review and feedback.

---

## Directory Layout

```
Quantum/
├── index.html                    # Landing page (static HTML)
├── papers/                       # Research papers and specifications
│   └── zkprivacy/               # Quantum: Quantum-Secure Privacy Blockchain
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
