# Project Structure

*Last Updated: July 2026*

```
Quantum/
├── CLAUDE.md                         # Development guidelines for Claude Code
├── AGENTS.md                         # Agent instructions (local start commands)
├── README.md                         # Project overview and quick start
├── LICENSE                           # CC0 dedication and rights boundary
├── index.html                        # Landing page (static HTML)
├── impressum.html                    # Legal notice (Impressum)
├── privacy.html                      # Privacy policy
├── terms.html                        # Terms of use
├── .gitignore                        # Git ignore rules
│
├── Documentation/
│   ├── ProjectStructure.md           # This file
│   ├── SystemArchitecture.html       # System design and deployment
│   ├── InvestorOnePager.html         # Evidence-based research brief
│   ├── Quantum_Market_Thesis.html    # Market and claim thesis
│   ├── assets/
│   │   └── documentation.css         # Shared internal-document styles
│   └── ReleaseNotes.md               # Version history
│
├── papers/                           # Research papers and specifications
│   └── zkprivacy/                    # Quantum: Privacy-Preserving DAG Blockchain
│       ├── zkprivacy-quantum-spec-v1.md      # Research design and requirements
│       ├── zkprivacy-quantum-spec-v1.pdf     # PDF export
│       ├── zkprivacy-verification-guide.md   # Implementation and evidence plan
│       └── zkprivacy-verification-guide.pdf  # PDF export
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
