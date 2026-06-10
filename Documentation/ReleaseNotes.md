# Quantum - Release Notes

## Version History

### v1.2.0 (2026-06-11)

**Specification Soundness Revision (Draft)**

- Fixed emission schedule: defined for the DAG block rate (0.01 QTM initial
  reward, 1.05B-block halving interval, ~66-year emission), reward formula
  now in satoshi; the previous Bitcoin-copied schedule would have emitted
  the full supply within days and summed to only 20.37M QTM
- Fixed value encoding: amounts committed as 4×16-bit limbs (a single
  coefficient mod q ≈ 2^23 silently wrapped amounts above ~0.08 QTM)
- Closed spend-authority gap: note commitments now bind the recipient's
  SpendPK hash and NullifierPK; spend authorization (SPHINCS+ over sighash)
  is verified in-circuit, so a note's creator can no longer re-spend or
  re-nullify it; on-chain signatures removed (~110 KB transactions, down
  from ~205 KB)
- Transport layer now mandates a post-quantum Noise handshake (ML-KEM);
  X25519 removed (violated R2.1)
- Replaced fabricated test vectors with explicit placeholders
- Reconciled performance/hardware requirements (R6.1/R6.2 vs Section 19.2
  vs Appendix G.1); batch proof verification required at target throughput
- Fixed difficulty-adjustment direction, FRI parameter/security mismatch,
  genesis difficulty estimate, address encoding (Bech32m unusable at
  1.6 KB payloads), range-check constraint degree, and size/fee figures
- Verification guide aligned with all spec changes; acceptance-criteria
  checkboxes unchecked (no implementation exists yet)
- Documentation: ProjectStructure.md brought up to date;
  SystemArchitecture.html Markdown conversion artifacts fixed

### v1.1.0 (2026-01-16)

**Major Architecture Update: DAG-Native Design**

- Renamed ZKPrivacy to Quantum
- Adopted GhostDAG consensus as core architecture (1,000+ TPS target)
- Added comprehensive documentation:
  - Abstract, Introduction, Design Philosophy sections
  - Project Status and Research Phases with milestones
  - Alternative scaling approaches comparison (Leios, Sharding, Solana)
  - Core research challenges (privacy-preserving DAG proofs)
  - Bitcoin foundations: UTXO model, Nakamoto consensus, fair launch
- Updated requirements (R8: Scalability) for DAG-native design
- Updated landing page with research project positioning
- Added honest assessment of proven vs unproven components
- Emphasized fair launch model (no premine, no ICO, no founder's reward)

### v1.0.0 (2026-01-14)

**Initial Release**

- Created project structure for post-quantum cryptography research
- Added Quantum specification:
  - `zkprivacy-quantum-spec-v1.md` - Full specification for privacy-preserving DAG blockchain
  - `zkprivacy-verification-guide.md` - AI implementation and verification guide
- Landing page with paper listing
- Responsive design with light academic theme

**Papers Included:**
- Quantum: Privacy-Preserving DAG Blockchain (Draft v1.0)

---

## Roadmap

### Planned Features

- [ ] LaTeX versions of papers for PDF generation
- [ ] Additional research papers
- [ ] Interactive cryptographic demos
- [ ] Reference implementation links
- [ ] Community discussion integration

### Future Papers (Planned)

- Post-Quantum Key Exchange Protocols
- Privacy-Preserving Smart Contracts
- Quantum-Resistant Identity Systems
