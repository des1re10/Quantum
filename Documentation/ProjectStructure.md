# Project Structure

*Last Updated: January 2026*

```
Quantum/
├── CLAUDE.md                         # Development guidelines for Claude Code
├── README.md                         # Project overview and quick start
├── index.html                        # Landing page (static HTML)
├── .gitignore                        # Git ignore rules
│
├── Documentation/
│   ├── ProjectStructure.md           # This file
│   ├── SystemArchitecture.md         # System design and deployment
│   └── ReleaseNotes.md               # Version history
│
├── papers/                           # Research papers and specifications
│   └── zkprivacy/                    # Quantum: Privacy-Preserving DAG Blockchain
│       ├── zkprivacy-quantum-spec-v1.md      # Full specification
│       ├── zkprivacy-quantum-spec-v1.pdf     # PDF export
│       ├── zkprivacy-verification-guide.md   # Implementation guide
│       ├── zkprivacy-verification-guide.pdf  # PDF export
│       └── figures/                          # Diagrams and images
│
├── assets/
│   ├── css/
│   │   └── style.css                 # Main stylesheet
│   └── images/
│       └── favicon.svg               # Site favicon
│
├── tools/
│   └── Scripts/
│       ├── Startup/                  # Deployment and startup scripts
│       │   ├── quantum_deploy_script.sh  # Deploy from pCloud to server
│       │   └── run_quantum.sh            # Nginx/SSL configuration
│       └── deploy_testing.bat        # Windows deployment to pCloud
│
├── build-pdfs.sh                     # PDF generation (Linux)
├── build-pdfs.bat                    # PDF generation (Windows)
├── start-local.sh                    # Local dev server (Linux)
├── start-local.bat                   # Local dev server (Windows)
├── deploy_testing.bat.lnk            # Shortcut to deploy script
└── converter.log                     # PDF converter log (generated)
```
