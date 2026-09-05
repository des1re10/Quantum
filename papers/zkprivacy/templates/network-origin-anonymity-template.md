---
title: "Network-Origin Anonymity for a High-Throughput BlockDAG"
subtitle: "Research-paper template"
author: "Phexora AI · [phexora.ai](https://phexora.ai)"
date: "2026-09-05"
version: "template-0.2"
status: "Template only — no protocol, implementation, anonymity result, or novelty claim"
license: "CC0-1.0; see repository LICENSE"
lang: "en-GB"
---

# Template status

Do not cite this outline as a completed paper. Promote it only after the
transaction propagation format, target workload, and observer model are frozen.

T006 in the [verification guide](../zkprivacy-verification-guide.md) first
screens candidate packet sizes, latency, batching, mixing, cover traffic,
idle-client cost and correlated retries against a named observer. Modelled
proof/transport components must be explicit. NOT_RULED_OUT permits T305;
it does not establish R2/G6 or promote this template to a result paper.

# Working decision

Can Quantum hide the network origin of private transactions under a precisely
bounded observer model while sustaining its frozen transaction rate and
meeting latency, bandwidth, availability, and denial-of-service budgets?

# Mandatory non-duplication review

At minimum, compare against:

- [Dandelion](https://arxiv.org/abs/1701.04439);
- [Dandelion++](https://arxiv.org/abs/1805.11060);
- Sharma, Gosain and Diaz,
  [On the Anonymity of Peer-To-Peer Network Anonymity Schemes Used by
  Cryptocurrencies](https://arxiv.org/abs/2201.11860);
- [Are Continuous Stop-and-Go Mixnets Provably
  Secure?](https://eprint.iacr.org/2023/1311.pdf) and other mixnet analyses
  relevant to the selected observer;
- [Shorter Lattice-based Zero-Knowledge Proofs for the Correctness of a
  Shuffle](https://eprint.iacr.org/2021/488) if a post-quantum verifiable
  mixnet is proposed; and
- current attacks on the exact Tor, I2P, mixnet, or peer-routing composition
  selected by the paper.

The paper must not claim that stem/fluff routing, transaction-origin attacks,
mixnets, cover traffic, or global-observer resistance are new. A contribution
must be a new construction or a reproducible Quantum/BlockDAG-specific
composition and result.

# Entry artifacts

- Frozen public transaction size and propagation encoding.
- Measured target submission and accepted-state-transition workload.
- Versioned peer handshake and link-cryptography candidate.
- Explicit acceptable-latency and availability requirements.
- A named observer model approved by the network-privacy reviewer.

# Research questions

1. Which adversary is addressed: local peers, colluding peers, autonomous
   systems, entry/exit observation, or a global passive/active observer?
2. What anonymity metric is used: precision/recall, entropy, guessing
   advantage, differential privacy, or a composable definition?
3. How do BlockDAG concurrency and rapid block publication affect timing and
   intersection attacks?
4. What cover traffic, delay, batching, mixing, route churn, and bandwidth are
   required at the frozen rate?
5. How does the protocol fail under route capture, Sybil peers, dropping,
   tagging, replay, flooding, and partial network partition?
6. Which users or deployment modes fall outside the guarantee?

# Required hypotheses and thresholds

Freeze before measurement:

- adversarial node/edge/AS fractions and observation capabilities;
- maximum origin-inference advantage or minimum anonymity metric;
- p50/p95/p99 added submission and inclusion latency;
- client, relay, and full-node bandwidth amplification;
- cover-traffic ratio and idle-user cost;
- delivery probability under honest and adversarial load;
- route-establishment and recovery cost; and
- denial-of-service resource ceilings.

No protocol may be described as resistant to a “global observer” unless that
observer and the quantitative guarantee are formalised and tested.

# Experiment outline

## Threat model

Separate passive from active observation, peer compromise from network-path
observation, transaction creation from later wallet queries, and network
anonymity from ledger unlinkability.

## Baselines

Evaluate ordinary diffusion, Dandelion++, and every selected mix/anonymous
transport profile under the same topology, workload, churn, and adversary.

## Adversarial cases

Include first-spy inference, route capture, Sybil concentration, timing
correlation, message tagging, selective dropping, eclipse, intersection over
repeated use, cover-traffic distinguishers, partitions, and overload.

## Evidence

Publish simulator and topology revisions, raw event traces with privacy-safe
handling, analytical model, sensitivity analysis, live-test limits, and exact
reproduction commands.

# Planned paper outline

1. Status and claim boundary
2. Observer and network model
3. Prior work and novelty boundary
4. Quantum/BlockDAG workload
5. Protocol
6. Anonymity analysis
7. Implementation and simulator
8. Pre-registered experiments
9. Results
10. Availability and denial-of-service trade-offs
11. Limitations
12. Reproducibility and stop/go decision
