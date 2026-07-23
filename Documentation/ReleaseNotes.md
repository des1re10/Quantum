# Quantum - Release Notes

## Unreleased

**Prior-Art Decision and Comparative Authorization Gate**

- Added a versioned T305 prior-art and reuse decision. It identifies TzEL as
  the closest public engineering baseline, rejects a generic post-quantum
  private payment novelty claim, and records an ADAPT + REPLICATE path. Named
  owner and reviewer signatures remain required before implementation.
- Documented Lattice RingCT, MatRiCT/MatRiCT+, Gao et al., LACT+, TzEL, NIST
  SP 800-208, and the non-final SP 800-230 draft as explicit comparison
  boundaries.
- Reframed Paper 1 as a same-relation comparison between the FIPS 205
  <code>SLH-DSA-SHAKE-256f</code> stateless incumbent, an independently
  specified TzEL-shaped one-time baseline, and an applicable NIST stateful
  profile.
- Added state-management failure cases, a pre-registered material-benefit
  rule, source-licence restrictions, and GO/ADAPT/REPLICATE/STOP outcomes.
- Advanced the specification and verification guide to
  <code>0.4.0-research</code> and synchronized public and internal status
  surfaces. The architecture decision is evidence for Paper 1, not a fifth
  paper.

**Research Publication Programme**

- Added a pre-registered T305 research protocol for the complete
  2-input/2-output private-transaction STARK feasibility experiment. It reports
  no implementation, benchmark, proof, or feasibility result.
- Documented the prior-work boundary against Lattice RingCT, MatRiCT and
  MatRiCT+, STARK-based hash-signature aggregation, private note retrieval,
  network-origin anonymity, and GHOSTDAG research.
- Split the remaining research into three templates: private note discovery,
  network-origin anonymity, and deterministic GHOSTDAG private-state semantics.
- Defined a four-manuscript programme and explicit promotion gates so templates
  cannot be presented as completed papers.
- Updated Linux and Windows PDF builders to discover every active root-level
  Markdown paper while excluding the template directory.
- Updated both local-preview launchers to detect a missing or stale PDF for any
  active root-level paper instead of checking a hard-coded pair, and to fail
  closed instead of serving a preview with missing or outdated publications.
- Synchronized the landing page, README, architecture, market thesis, project
  structure, and contributor guidance with the new publication contract.

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

### v1.3.1 (2026-07-22)

**Private Settlement Research and Publication Revision**

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
- Switched both research papers to DocWizard's scientific-manuscript style,
  added publication metadata, abstracts, keywords, and a proper document
  heading hierarchy, and removed the duplicated rendered title/status block.
- Regenerated both PDF artifacts through the canonical DocWizard/Pandoc/XeLaTeX
  pipeline.
- Hardened Windows preview startup, normalized launcher line endings, and
  aligned deployment wrappers with the shared publication contract.
- Release packaging update: annotated repository tag advanced to `v1.3.1`.
