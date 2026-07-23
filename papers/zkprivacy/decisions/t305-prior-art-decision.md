# T305 Prior-Art and Reuse Decision

**Status:** Recorded research direction; named owner and reviewer signatures
required before implementation; not a protocol, security, licensing, or release
approval<br>
**Decision revision:** 1.0-research<br>
**Decision date:** 2026-07-23<br>
**Applies to:** T103, T104, T202, T203, T301–T305, and Paper 1<br>
**Evidence cut-off:** 2026-07-23<br>
**Accountable owner:** Unassigned<br>
**Independent reviewer:** Unassigned<br>
**Approval status:** PENDING

## Decision

Quantum will **not** claim or reimplement a generic post-quantum private-payment
protocol as if that problem were unsolved.

The closest public engineering baseline identified in the scoped review at the
evidence cut-off is TzEL. Its whitepaper and public testnet already combine a
note/commitment/nullifier ledger, ML-KEM note delivery, hash-based one-time
spend authorisation verified inside a recursive STARK, delegated proving,
viewing capabilities, and proof-bearing private transfers. Published Lattice
RingCT, MatRiCT, MatRiCT+, Gao et al., and LACT+ also cover major post-quantum
confidential-transaction, balance, anonymity, and aggregation subproblems.

The recorded path is therefore:

1. **Adopt definitions and test questions, not code.** Reuse published security
   games, negative cases, benchmark dimensions, and interface lessons where
   their assumptions match Quantum.
2. **Adapt the architecture only where Quantum has a measured requirement that
   prior work does not meet.** The current candidates are standardised
   authorisation, local rather than witness-revealing delegated proving, direct
   layer-1 bandwidth without a separate data-availability layer, and
   deterministic GHOSTDAG state application.
3. **Replicate before claiming improvement.** Paper 1 is a comparative
   feasibility and standardisation study. It is not a “first post-quantum
   private payment” or “first STARK private transaction” paper.
4. **Do not reuse TzEL source code under the current repository terms.** At the
   recorded snapshot its repository states “All rights reserved.” Any source
   reuse requires a later compatible licence or explicit permission and a
   documented legal review. Public descriptions may inform an independently
   specified baseline, but clean-room and patent questions remain for counsel.

This decision does not approve any candidate primitive. It narrows the work
that may proceed to implementation.

## Evidence snapshot

| Work | Publication or artifact status at the cut-off | Material result | Boundary for Quantum |
|---|---|---|---|
| Lattice RingCT v2.0 | ACISP 2019 publication | Post-quantum MIMO RingCT, refined balance/anonymity models; estimated 2-in/2-out signatures around 5.1 MB for ring size 1 and 8 MB for ring size 5 | Rules out a generic MIMO post-quantum RingCT claim; no implementation result |
| MatRiCT | ACM CCS 2019 publication and implementation | At anonymity 1/10, reported 2-in/2-out proof 110 KB, generation 375 ms, verification 23 ms at 3 GHz | Supplies a concrete lattice RingCT baseline and reusable security definitions |
| MatRiCT+ | IEEE S&P 2022 publication and implementation | At anonymity 1/11 and 2-in/2-out, reported 47 KB proof or 29 KB estimated with compression; at anonymity 1/10, 100 ms generation and 2 ms verification at 3 GHz | Stronger RingCT baseline; still a decoy-ring model rather than a hidden-note membership proof |
| Gao et al. | PKC 2025 publication and Go prototype | Removes corrector values and binary-proof work; reports reductions against MatRiCT and MatRiCT+ | Rules out presenting a new lattice balance or ring-signature optimisation without a direct construction and comparison |
| LACT+ | Peer-reviewed open-access journal article, 2023, with public C implementation referenced by the paper | Aggregable lattice confidential transactions with many inputs/outputs at logarithmic cost and 5.7 KB confidential coin records | Supplies an aggregation and confidential-value comparator; it does not provide Quantum's full sender/recipient/network privacy model |
| TzEL | Public whitepaper, public source repository, and experimental Tezos testnet; explicitly not production-safe or audited | Full note/nullifier/ML-KEM/WOTS-like-in-STARK transaction path. The repository reports about 289–301 KiB recursive proofs, 32–34 ms verification, and, for a two-input transfer, 5.235 s proving with 16.66 GiB peak RSS on AWS c8g.16xlarge | Closest architectural baseline. It removes generic full-stack novelty but leaves direct-L1 size, constrained-client proving, standardised authorisation, independent reproduction, and GHOSTDAG integration open |

Numbers above are contextual values reported by their respective authors. They
were produced on different hardware, workloads, security profiles, and protocol
models and are not a ranking.

The TzEL source snapshot reviewed for this decision is
`0288c1cd3ff48b88b8ca99dac212235511af19bf` on its `main` branch. Its
whitepaper describes a depth-16 authorisation tree with WOTS-like leaves, while
the Quantum incumbent uses stateless FIPS 205
`SLH-DSA-SHAKE-256f`. These are different security and state-management
contracts, not interchangeable labels for the same primitive.

## Architecture comparison

| Surface | Closest prior baseline | Quantum incumbent | Required decision evidence |
|---|---|---|---|
| Ledger privacy | TzEL note commitments, historical roots, position-bound nullifiers, hidden authorisation artifacts | Same high-level note/nullifier shape | Treat the shape as prior art; specify only the exact relation and measured delta |
| Spend authorisation | TzEL WOTS-like one-time key under an XMSS-style tree; key reuse and exhaustion require state discipline | Stateless FIPS 205 `SLH-DSA-SHAKE-256f` bound inside the note and verified in-proof | Compare proof trace, latency, memory, key state, recovery, misuse resistance, and concrete security; include NIST SP 800-208 stateful profiles as a standards comparator |
| Amount integrity | MatRiCT/MatRiCT+/Gao lattice balance proofs; LACT+ confidential-value aggregation; TzEL in-circuit range and balance | Bounded 64-bit values, carries, and exact 2-in/2-out conservation in a STARK | Reuse negative cases and compare complete wire/prover cost; do not claim balance-proof novelty |
| Recipient delivery | TzEL ML-KEM-768 plus authenticated encryption and separate detection/view paths | ML-KEM-1024 candidate plus authenticated encryption and explicit receiver-key privacy | Compare exact games, ciphertext bytes, detection leakage, and KEM parameter rationale |
| Proof architecture | TzEL Cairo AIR plus Stwo recursive STARK and DAL carriage | Unfrozen transparent STARK intended for direct Quantum L1 carriage | Demonstrate a materially different size/local-proving result or adopt a data-availability/delegation trade-off explicitly |
| Consensus | TzEL Tezos smart rollup and DAL | Native GHOSTDAG-based layer 1 | Keep deterministic private-state semantics in Paper 4; it is not evidence of transaction-cryptography novelty |
| Reproducibility | TzEL public implementation and self-reported benchmarks; no production audit claim | Two independent implementations and pre-registered thresholds required | Reproduce comparable workloads and publish raw artifacts before making comparative claims |
| Reuse rights | TzEL repository says “All rights reserved” at the snapshot | Quantum-authored research text is CC0; future implementation licence unresolved | No TzEL code copying without compatible permission and legal review |

## Authorisation experiment arms

Paper 1 must keep the authorisation choice falsifiable rather than treating the
incumbent as already justified:

| Arm | Purpose | Minimum evidence |
|---|---|---|
| A — TzEL-shaped one-time baseline | Measure the proof-native stateful approach that closest prior work uses | Independently specified WOTS/XMSS-style relation, explicit key-reuse/exhaustion model, trace and benchmark artifacts |
| B — NIST stateful comparator | Determine whether an approved XMSS/XMSSMT or LMS/HSS profile can supply a standards boundary without full stateless cost | Exact NIST SP 800-208 parameter set, hardware/state requirements, in-proof cost, and applicability decision |
| C — Quantum incumbent | Test exact FIPS 205 `SLH-DSA-SHAKE-256f` verification | Official KATs, complete in-proof relation, concrete multi-target rationale, and full benchmark |

NIST SP 800-208 stateful schemes are not general-purpose drop-in replacements:
their safety depends on state management and the NIST profile imposes controlled
key-generation requirements. NIST SP 800-230 was only an initial public draft
at the evidence cut-off; its limited-signature SLH-DSA parameter sets must not
be treated as final standards.

## Stop/go classification

Paper 1 may continue only as the comparison above.

- **GO — retain the stateless profile:** Arm C meets every frozen threshold and
  its state-management, interoperability, or security benefit is material
  enough to justify its extra cost over Arms A and B.
- **ADAPT — select a stateful profile:** A reviewed Arm A or B meets the
  complete requirements while Arm C fails or adds no material benefit. The
  normative specification must then change before node work begins.
- **REPLICATE — publish a comparative or negative result:** No arm establishes
  a new construction, but the independent measurements or failure analysis are
  reproducible and useful. The manuscript must be labelled accordingly.
- **STOP — redesign the system:** No arm meets the frozen direct-layer-1,
  constrained-client, security, and privacy budgets. Delegated proving, a data
  availability layer, weaker parameters, or a different throughput target may
  be evaluated only through an explicit requirements decision, not as a hidden
  fallback.

A generic protocol novelty claim is rejected regardless of benchmark outcome.

## Paper count

This record does not add a fifth paper. The programme remains:

1. comparative private-transaction feasibility and authorisation
   standardisation;
2. private post-quantum note discovery;
3. network-origin anonymity;
4. deterministic GHOSTDAG private-state semantics.

The present file is an architecture and reuse decision that gates Paper 1 and
the implementation tasks.

## Sources

- TzEL contributors,
  [TzEL whitepaper](https://tzel.tezos.com/whitepaper.pdf), 2026.
- Trilitech,
  [TzEL source snapshot](https://github.com/trilitech/tzel/tree/0288c1cd3ff48b88b8ca99dac212235511af19bf),
  accessed 2026-07-23.
- Torres et al.,
  [Lattice RingCT v2.0](https://eprint.iacr.org/2019/569), 2019.
- Esgin et al.,
  [MatRiCT](https://eprint.iacr.org/2019/1287), 2019.
- Esgin, Steinfeld and Zhao,
  [MatRiCT+](https://eprint.iacr.org/2021/545), 2022.
- Gao et al.,
  [Lattice-based Zero-knowledge Proofs for Blockchain Confidential
  Transactions](https://eprint.iacr.org/2021/1674), PKC 2025 revision.
- Alupotha, Boyen and McKague,
  [LACT+](https://doi.org/10.3390/cryptography7020024), 2023.
- NIST,
  [SP 800-208: Recommendation for Stateful Hash-Based Signature
  Schemes](https://csrc.nist.gov/pubs/sp/800/208/final), 2020.
- NIST,
  [SP 800-230 initial public draft](https://csrc.nist.gov/pubs/sp/800/230/ipd),
  2026; non-final at the evidence cut-off.
- NIST,
  [FIPS 205: Stateless Hash-Based Digital Signature
  Standard](https://csrc.nist.gov/pubs/fips/205/final), 2024.
