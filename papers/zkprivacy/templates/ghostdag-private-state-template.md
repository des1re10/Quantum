---
title: "Deterministic Private-State Semantics for GHOSTDAG"
subtitle: "Research-paper template"
author: "Phexora AI · [phexora.ai](https://phexora.ai)"
date: "2026-07-23"
version: "template-0.1"
status: "Template only — no consensus profile, proof, implementation, or result"
license: "CC0-1.0; see repository LICENSE"
lang: "en-GB"
---

# Template status

Do not cite this outline as a completed paper. Promote it only after the
transaction/state transition and the versioned GHOSTDAG candidate are frozen.

# Working decision

Can all honest Quantum implementations derive the same commitment tree,
nullifier set, accepted transaction set, fee/reward state, anchor set, and
pruning/recovery commitments from the same GHOSTDAG under concurrency,
reorganisations, and adversarial conflicts?

# Mandatory non-duplication review

At minimum, compare against:

- Sompolinsky, Wyborski and Zohar,
  [PHANTOM and GHOSTDAG](https://eprint.iacr.org/2018/104.pdf);
- the current Kaspa consensus implementation and research notes for selected
  order, accepted transactions, DAA score, pruning, and finality;
- [A Transaction-Level Model for Blockchain
  Privacy](https://eprint.iacr.org/2023/1902) and other formal models of UTXO,
  nullifier-based, and privacy-preserving state transitions; and
- concurrent-block and reorganisation handling in deployed note-based private
  ledgers.

The paper must not claim GHOSTDAG, total transaction ordering, UTXO conflict
resolution, or nullifier sets as new. Its candidate contribution is the exact
deterministic composition of GHOSTDAG with Quantum's private note, anchor,
nullifier, reward, and proof semantics, plus formal and differential evidence.

# Entry artifacts

- Frozen canonical transaction and proof encoding.
- Frozen commitment/nullifier state transition.
- Versioned GHOSTDAG block ordering and parameter candidate.
- Exact DAA, finality, reward, maturity, and supply rules.
- Snapshot, pruning, and recovery requirements.

# Research questions

1. What exact order is applied to blocks and transactions, including
   deterministic tie-breaking?
2. Which transactions are accepted when parallel blocks reveal conflicting
   nullifiers or incompatible anchors?
3. How are anchor admissibility and witness refresh defined across
   reorganisations?
4. How are fees, rewards, red/blue block treatment, maturity, burns, and supply
   cap derived without wall-clock or floating-point ambiguity?
5. Which state commitments are placed in blocks and snapshots, and how are they
   validated during pruning and recovery?
6. What finality statement can the implementation actually support?

# Required invariants

- Determinism: identical ordered DAG input produces byte-identical state.
- No double spend: no accepted history consumes one nullifier twice.
- Conservation: ordinary transfers cannot create value.
- Issuance cap: rewards cannot exceed the frozen schedule and cap.
- Anchor safety: accepted proofs use only anchors admissible under one rule.
- Reorganisation safety: rollback and replay produce the same post-state as
  clean evaluation of the selected order.
- Recovery safety: a verified snapshot plus retained history reconstructs the
  same state root.
- Liveness: honest non-conflicting transactions are not indefinitely excluded
  under the declared network and adversary assumptions.

# Required hypotheses and thresholds

Freeze before experiments:

- DAG parameters, block rate, delay and adversarial hash-power profiles;
- maximum reorganisation and anchor windows;
- finality error target and observation rule;
- state-application and rollback latency budgets;
- snapshot size, creation, verification, and recovery budgets;
- pruning retention and archival assumptions; and
- maximum work allocated to old-context or malformed blocks.

# Formal and experimental plan

## Executable model

Build a small deterministic reference model before the optimised node. Model
parallel blocks, selected order, conflicts, anchor windows, rewards, finality,
rollback, pruning points, and snapshots.

## Properties

Use model checking or theorem proving where feasible, and state exactly which
bounded or unbounded properties were established. Tests and simulations are
not formal proofs.

## Differential implementation

Require two independent state engines to consume the same generated DAG
corpus. Compare accepted transactions, state roots, nullifier sets, commitment
roots, rewards, finality markers, and snapshots after every event.

## Adversarial cases

Include conflicting nullifiers in anticone blocks, stale anchors, reordered
transactions, deep old-context blocks, timestamp manipulation, DAA edge cases,
reward overflow, duplicate rewards, finality conflict, snapshot corruption,
and crash/recovery at every state-commit boundary.

# Planned paper outline

1. Status and claim boundary
2. GHOSTDAG and Quantum state model
3. Prior work and novelty boundary
4. Deterministic protocol profile
5. Safety and liveness properties
6. Formal model
7. Independent implementations
8. Adversarial and performance evaluation
9. Results
10. Limitations
11. Reproducibility
12. Stop/go decision
