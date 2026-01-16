# Quantum

**Post-Quantum Cryptography Research by Phexora AI**

[![Website](https://img.shields.io/badge/Website-quantum.phexora.ai-6366f1)](https://quantum.phexora.ai)
[![License](https://img.shields.io/badge/License-CC0-success)](https://creativecommons.org/publicdomain/zero/1.0/)

---

## Overview

Quantum is Phexora AI's research initiative aimed at solving an unsolved problem: **combining high-throughput DAG consensus with full transaction privacy**.

No existing blockchain achieves both. Kaspa has speed (10+ blocks/sec) but transparent transactions. Monero has privacy but limited throughput (~10 TPS). Quantum aims to be the first to achieve both, with quantum-secure cryptography.

**This is a research project.** The core challenge—privacy-preserving proofs over DAG structures—is novel and unproven. We publish openly and honestly about what works and what doesn't.

## Research Specification

### Quantum: Privacy-Preserving DAG Blockchain

A research specification targeting Kaspa-level throughput with Monero-level privacy.

**Targets:**
- 1,000+ TPS on L1 via GhostDAG consensus
- 10-32 blocks per second
- 100% private transactions (no transparent mode)
- Post-quantum security (SPHINCS+, ML-KEM, STARKs)
- No trusted setup required

**Bitcoin Foundations:**
- UTXO model (proven secure, privacy-friendly)
- Nakamoto consensus (PoW, permissionless, no validators)
- Fair launch (no premine, no ICO, no founder's reward)

**Status:** Phase 1 (Specification) complete. Formal security analysis in progress.

**Documents:**
- [Full Specification](papers/zkprivacy/zkprivacy-quantum-spec-v1.md)
- [Verification Guide](papers/zkprivacy/zkprivacy-verification-guide.md)

## Technology Stack

| Component | Technology |
|-----------|------------|
| Signatures | SPHINCS+-256f (hash-based) |
| Key Encapsulation | ML-KEM-1024 (Kyber) |
| Zero-Knowledge Proofs | STARKs (transparent, hash-based) |
| Commitments | Lattice-based (Module-LWE) |
| Hash Functions | SHAKE256 (SHA-3 family) |

## Security Assumptions

All cryptographic primitives are based on:
- **Hash function security** (collision resistance, preimage resistance)
- **Module-LWE hardness** (lattice problems)
- **Module-SIS hardness** (short integer solutions)

No reliance on:
- Elliptic curve discrete logarithm problem
- Integer factorization
- Any problem vulnerable to Shor's algorithm

## Local Development

```bash
# Clone the repository
git clone https://github.com/des1re10/Quantum.git
cd quantum

# Start local server
./start-local.sh
# Or on Windows: start-local.bat

# Open in browser
# http://localhost:8080
```

## Contributing

We welcome feedback from:
- Cryptographers
- Security researchers
- Blockchain developers
- Anyone interested in post-quantum security

Please open an issue or pull request for:
- Technical corrections
- Clarifications
- Suggestions for improvements

## License

All research papers in this repository are released under [CC0 (Public Domain)](https://creativecommons.org/publicdomain/zero/1.0/).

You are free to:
- Copy, modify, and distribute the work
- Use it for commercial purposes
- Without asking permission

## About Phexora AI

[Phexora AI](https://phexora.ai) is a technology company focused on privacy-preserving solutions and blockchain technology.

---

**Quantum** - Building cryptography for the post-quantum era.
