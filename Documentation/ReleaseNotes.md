# Quantum - Release Notes

## Unreleased

- Advanced both papers to research design <code>0.3.0-research</code> and
  narrowed the initial product boundary to private post-quantum cash and
  settlement rather than a general-purpose smart-contract platform.
- Added the Phexora AI author URL to both paper title pages and PDF metadata
  sources.
- Added a mandatory, complete 2-input/2-output proof feasibility gate before
  wallet, node, or GHOSTDAG integration, with separate client-latency,
  verifier, wire-size, memory, parallel-prover, and aggregation budgets.
- Defined least-privilege incoming, full-wallet, transaction-specific, and
  auditor-scoped disclosure capabilities without a universal viewing key.
- Added a finite, proof-bounded payment-policy direction and separated private
  assets and cross-chain adapters into later profiles with their own trust and
  claim boundaries.
- Expanded the verification plan from 29 to 31 tasks with T305 and T405, added
  adversarial disclosure/policy cases, and synchronized the landing page,
  README, market thesis, and research brief.
- Switched both research papers to DocWizard's scientific-manuscript style.
- Added publication metadata, abstracts, keywords, and a proper document
  heading hierarchy while removing the duplicated title/status block from the
  rendered first page.
- Regenerated both PDF artifacts through the canonical DocWizard/Pandoc/XeLaTeX
  pipeline.

## Version History

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

### v1.2.0 (2026-06-11)

**Specification Soundness Revision (Draft; superseded by v1.3.0)**

The entries below record the intent of that historical draft. They are not
current conformance or security evidence; v1.3.0 withdrew the unsupported
constructions and claims.

- Fixed emission schedule: defined for the DAG block rate (0.01 QTM initial
  reward, 1.05B-block halving interval, ~66-year emission), reward formula
  now in satoshi; the previous Bitcoin-copied schedule would have emitted
  the full supply within days and summed to only 20.37M QTM
- Fixed value encoding: amounts committed as 4×16-bit limbs (a single
  coefficient mod q ≈ 2^23 silently wrapped amounts above ~0.08 QTM)
- Closed spend-authority gap: note commitments now bind the recipient's
  SpendPK hash and NullifierPK; spend authorization (now standardized as
  SLH-DSA) over sighash
  is verified in-circuit, so a note's creator can no longer re-spend or
  re-nullify it; on-chain signatures removed (~110 KB transactions, down
  from ~205 KB)
- Proposed an ML-KEM transport direction; v1.3.0 later withdrew the unsupported
  custom Noise-pattern claim and made exact authenticated composition a gate
- Removed fabricated test vectors; v1.3.0 replaces placeholders with a
  reproducible evidence plan and checked domain-wrapper vectors
- Reconciled performance/hardware requirements (R6.1/R6.2 vs Section 19.2
  vs Appendix G.1); batch proof verification required at target throughput
- Fixed difficulty-adjustment direction, FRI parameter/security mismatch,
  genesis difficulty estimate, address encoding (Bech32m unusable at
  1.6 KB payloads), range-check constraint degree, and size/fee figures
- Verification guide aligned with all spec changes; acceptance-criteria
  checkboxes unchecked (no implementation exists yet)
- Documentation: ProjectStructure.md brought up to date;
  SystemArchitecture.html Markdown conversion artifacts fixed

### v1.3.0 (2026-07-09)

**Research Design and Evidence-Gate Revision**

- Reclassified the protocol as research design <code>0.2.0-research</code>;
  removed unsupported “specification complete,” achieved security, anonymity,
  and throughput claims
- Kept post-quantum security, anonymity by default, and at least 1,000 accepted
  L1 TPS as hard, joint release requirements
- Closed the specification-level inflation gap: proofs must bind every input
  and output value to a commitment opening and enforce balance with bounded
  integer limbs and carries
- Withdrew the unsupported commitment formula, biased sampler, incomplete
  STARK security calculation, self-declared PoW target, wall-clock/float DAA,
  and ambiguous DAG reward/genesis rules
- Updated standardized terminology to FIPS 205 SLH-DSA and made authenticated
  ML-KEM transport plus network anonymity separate blocking gates
- Replaced autonomous-AI implementation guidance with a human-owned,
  29-task verification plan, independent review, honest NOT_STARTED reports,
  and reproducible evidence requirements
- Migrated the market thesis to durable HTML, centralized internal document
  styling, and corrected static-site build/deployment boundaries
- Aligned README, landing page, research brief, structure documentation, and
  legal/CC0 wording with the actual evidence state
- Added explicit gates for quantum digest-length analysis and recipient-key
  privacy in encrypted note delivery
- Defined fee transfer, subsidy issuance, burn, reward-maturity, and supply-cap
  accounting as one consensus invariant
- Included the research license in staging and public deployment, fixed narrow
  navigation, and removed duplicated or stale documentation structures
