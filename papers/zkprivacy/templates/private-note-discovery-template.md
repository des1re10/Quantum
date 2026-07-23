---
title: "Private Post-Quantum Note Discovery at High Throughput"
subtitle: "Research-paper template"
author: "Phexora AI · [phexora.ai](https://phexora.ai)"
date: "2026-07-23"
version: "template-0.1"
status: "Template only — no construction, implementation, result, or novelty claim"
license: "CC0-1.0; see repository LICENSE"
lang: "en-GB"
---

# Template status

Do not cite this outline as a completed paper. Promote it only after the
complete-transaction paper freezes the output format, encrypted payload,
transaction size, and measured output rate.

# Working decision

Can a Quantum wallet discover and retrieve its post-quantum encrypted notes at
the target ledger rate without revealing its recipient keys, notes, scan range,
or access pattern to the serving nodes, while meeting frozen client bandwidth,
latency, compute, storage, and false-positive budgets?

# Mandatory non-duplication review

At minimum, compare the proposed design against:

- Zcash compact-block trial decryption and its privacy boundary
  ([ZIP 307](https://zips.z.cash/zip-0307));
- Liu and Tromer,
  [Oblivious Message Retrieval](https://eprint.iacr.org/2021/1256.pdf);
- [PerfOMR](https://eprint.iacr.org/2024/204.pdf);
- Hansen, Nielsen and Simkin,
  [OCash](https://eprint.iacr.org/2024/246); and
- the exact receiver-anonymity or anonymous-KEM definition used by the
  transaction paper.

The paper must not claim that private payment detection, OMR, ORAM-based
retrieval, or full-node-oblivious light-client payments are new. Its candidate
contribution must be the measured and analysed Quantum-specific composition,
or a genuinely new construction proven and compared against those baselines.

# Entry artifacts

- Frozen public output and encrypted-payload encoding.
- Measured outputs per second and bytes per output from T305.
- Frozen ML-KEM/KDF/AEAD and receiver-anonymity profile.
- Wallet recovery and viewing-capability requirements.
- Named desktop, mobile/constrained, and serving-node profiles.

# Research questions

1. Which baseline—full local scan, compact broadcast, private detection,
   OMR/ORAM, or another reviewed design—meets the declared threat model?
2. Does the public clue, tag, ciphertext, or query leak recipient identity or
   create cross-output linkability?
3. What are client and server costs at typical and worst-case recipient counts?
4. How are false positives, missed notes, reorgs, recovery, and malicious
   serving nodes handled?
5. What metadata remains visible even when retrieval content is private?
6. Does the design remain post-quantum secure after multi-user composition?

# Required hypotheses and thresholds

Freeze before measurement:

- maximum client download bytes per day and per recovery;
- p50/p95/p99 detection latency;
- client CPU, memory, energy, and storage;
- server compute, memory, storage, and amplification per recipient;
- false-positive and false-negative bounds;
- availability under malformed clues, queries, and denial-of-service load; and
- the permitted recipient-inference advantage in the exact security game.

Unset thresholds are not passing thresholds.

# Experiment outline

## Threat model

Define full-node visibility, collusion, adaptive chosen-key and
chosen-ciphertext behavior, traffic observation, compromised wallets, query
timing, and recovery observation. Separate ledger privacy from network-origin
privacy.

## Candidate designs

Implement at least one transparent baseline and every claimed improvement under
the same workload. Record setup assumptions, clue/key sizes, query sizes,
server preprocessing, online work, trust, and availability trade-offs.

## Adversarial cases

Include targeted outputs, malicious clues, malformed ciphertexts, selective
response, timing correlation, query replay, cross-wallet correlation, recovery
from genesis, deep reorganisation, and receiver-key guessing.

## Evidence

Publish formal games or reductions where claimed, canonical vectors, two
interoperable implementations for the selected profile, raw benchmarks, and an
honest leakage statement.

# Planned paper outline

1. Status and claim boundary
2. Problem and threat model
3. Prior work and novelty boundary
4. Quantum output and recovery requirements
5. Candidate construction or evaluated profiles
6. Security definitions and analysis
7. Implementation
8. Pre-registered evaluation
9. Results
10. Limitations and residual metadata
11. Reproducibility
12. Conclusion and stop/go decision
