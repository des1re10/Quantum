# Quantum

**Open post-quantum privacy and scalability research by Phexora AI**

[![Website](https://img.shields.io/badge/Website-quantum.phexora.ai-6366f1)](https://quantum.phexora.ai)
[![Research text: CC0 1.0](https://img.shields.io/badge/Research%20text-CC0--1.0-success)](LICENSE)

## What Quantum is

Quantum is a research program for a private note-based DAG protocol. A
releasable design must satisfy three requirements together:

- **post-quantum security:** at least 128 bits of composed post-quantum security
  across every security-critical layer, without classical fallbacks;
- **privacy and network anonymity by default:** no transparent transfer mode,
  with sender, recipient, amount, graph relationship, and origin metadata
  protected within a published threat model;
- **scalability:** at least 1,000 accepted layer-1 transactions per second in a
  reproducible end-to-end test with all privacy and validation work enabled.

These are release requirements, not achieved capabilities.

## Current status

**Research design 0.2.0-research — not implementation-ready or production-safe.**

This repository currently contains a static documentation website, a research
design, and a verification plan. It does not contain a node, wallet,
blockchain implementation, testnet, external security audit, or completed
performance benchmark.

| Area | Status |
|---|---|
| SHAKE256, ML-KEM-1024, SLH-DSA-SHAKE-256f | Standards selected; integration not verified |
| Lattice commitment | Blocking research gate |
| STARK validity proof | Blocking research gate |
| GHOSTDAG and private state ordering | Blocking research gate |
| Network anonymity | Blocking research gate |
| ≥1,000 accepted L1 TPS | Acceptance target; not yet benchmarked |

The project must stop before production if any of the three core requirements
cannot be demonstrated.

## Research documents

- [Research design specification](papers/zkprivacy/zkprivacy-quantum-spec-v1.md)
- [Implementation and verification plan](papers/zkprivacy/zkprivacy-verification-guide.md)
- [Market and claim thesis](Documentation/Quantum_Market_Thesis.html)
- [Static-site system architecture](Documentation/SystemArchitecture.html)

The specification filename retains “v1” for link compatibility. The normative
revision is declared inside the document.

## Candidate protocol directions

| Responsibility | Candidate direction | Evidence boundary |
|---|---|---|
| Hash/XOF | SHAKE256, NIST FIPS 202 | Standard selected |
| Authorization | SLH-DSA-SHAKE-256f, NIST FIPS 205 | In-proof cost and integration open |
| Key encapsulation | ML-KEM-1024, NIST FIPS 203 | Authenticated composition open |
| Validity proof | Transparent STARK | Exact AIR/FRI/ZK profile open |
| Note commitment | Reviewed lattice construction | Construction and parameters open |
| Consensus | Versioned GHOSTDAG-based PoW profile | State ordering, DAA and finality open |
| Origin privacy | Dedicated anonymous transport layer | Protocol and analysis open |

Selecting a standardized primitive does not prove the security, anonymity, or
performance of the composed protocol.

## Local documentation site

~~~bash
git clone https://github.com/des1re10/Quantum.git
cd Quantum
./start-local.sh
# Open http://localhost:9180
~~~

On Windows, use <code>start-local.bat</code>.

## PDF generation

The Markdown papers are the authoritative sources. PDF files are generated
through the adjacent DocWizard-Pro repository:

~~~bash
./build-pdfs.sh
# On Windows: build-pdfs.bat
~~~

Both PDFs must be regenerated after material paper changes.

The papers select DocWizard's `scientific` style in their front matter. Their
section titles already contain normative numbers, so the build deliberately
does not add DocWizard's automatic section numbering.

The build scripts use the adjacent DocWizard-Pro repository's prepared
`.venv` runtime and fail if that exact runtime, Pandoc, or XeLaTeX is missing.

## Contributing

Useful contributions include:

- corrections to the threat model or validity relation;
- concrete, cited commitment or STARK analyses;
- deterministic GHOSTDAG/state-ordering models;
- anonymous-network threat analysis;
- independent implementations and interoperability vectors;
- reproducible performance and storage budgets.

Do not describe an open gate as verified. Cryptographic, consensus, anonymity,
and release approvals require independent human specialist review.

## License and legal boundary

Repository-authored research text and documentation are dedicated under
[CC0 1.0 Universal](LICENSE). That dedication does not cover repository scripts,
styles, company or product identifiers, or third-party material unless a
separate notice says otherwise. CC0 does not grant patent or trademark rights.

This research is not legal, tax, financial, or investment advice and is not an
offer to sell a token, security, or network service.
