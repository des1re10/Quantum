# Quantum

**Post-Quantum Cryptography Research by Phexora AI**

[![Website](https://img.shields.io/badge/Website-quantum.phexora.ai-6366f1)](https://quantum.phexora.ai)
[![License](https://img.shields.io/badge/License-CC0-success)](https://creativecommons.org/publicdomain/zero/1.0/)

---

## Overview

Quantum is Phexora AI's research initiative focused on developing cryptographic protocols that remain secure against quantum computer attacks. Our approach combines established post-quantum primitives (NIST-standardized algorithms) with innovative protocol design.

## Research Papers

### ZKPrivacy: Quantum-Secure Privacy Blockchain

A complete, formally verifiable specification for a quantum-secure, privacy-by-default blockchain.

**Key Features:**
- Privacy by default - no transparent transaction mode
- Post-quantum security using SPHINCS+, ML-KEM, STARKs
- No trusted setup required
- Designed for AI-verifiable implementation

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
git clone https://github.com/phexora/quantum.git
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
