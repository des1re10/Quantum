---
title: "Standardised Hash-Based Authorisation Inside a Private-Transaction STARK"
subtitle: "Reproducible feasibility protocol for the Quantum 2-input/2-output gate"
author: "Phexora AI · [phexora.ai](https://phexora.ai)"
date: "2026-07-23"
version: "0.1.0-research-protocol"
status: "Research protocol — no implementation, benchmark result, security proof, or feasibility claim"
license: "CC0-1.0; see repository LICENSE"
lang: "en-GB"
papersize: "a4"
documentclass: "article"
docwizard-style: "scientific"
keywords:
  - post-quantum private payments
  - SLH-DSA
  - STARK
  - transaction feasibility
  - reproducible benchmarking
abstract: |
  This manuscript pre-registers the first blocking experiment in the Quantum
  research programme: a complete private note transaction with exactly two
  inputs and two outputs, including commitment openings, membership,
  nullifiers, encrypted-note binding, 64-bit integer conservation, and full
  SLH-DSA-SHAKE-256f verification inside a transparent zero-knowledge STARK.
  It defines the novelty boundary against published post-quantum RingCT,
  hash-signature aggregation, note-discovery, and anonymous-payment work;
  fixes the statement and witness boundary; and specifies reproducibility,
  security-analysis, measurement, and stop/go requirements. It reports no
  implementation or result. A later revision may claim feasibility only after
  two independent implementations meet thresholds frozen before measurement.

  **Keywords:** post-quantum private payments; SLH-DSA; STARK; transaction
  feasibility; reproducible benchmarking.
---

# 1. Status and claim boundary

This is a **research protocol**, not a result paper. At version
<code>0.1.0-research-protocol</code>:

- no complete Quantum transaction prover or verifier exists in this repository;
- no proof-system, commitment, or note-encryption profile has been frozen;
- no benchmark threshold has been approved under task T004;
- no benchmark described here has been run;
- no composed post-quantum security proof has been completed; and
- no feasibility, throughput, anonymity, audit, testnet, or production claim is
  made.

The manuscript exists to make the experiment falsifiable before implementation
begins. Empty threshold fields, missing evidence, or an unimplemented relation
are **not** passing results.

The authoritative protocol requirements remain the
[Quantum research design](zkprivacy-quantum-spec-v1.md). The authoritative
task dependencies and evidence gates remain the
[verification plan](zkprivacy-verification-guide.md). If this protocol
conflicts with either document, the conflict must be resolved explicitly; an
implementation must not choose the more convenient interpretation.

## 1.1 Decision owned by this paper

The paper owns one decision:

> Can two independent implementations prove and verify the complete,
> representative Quantum 2-input/2-output private transaction on frozen
> desktop and constrained-client profiles while meeting every pre-registered
> security, latency, memory, proof-size, wire-size, and aggregation threshold?

A positive answer permits research to proceed to wallet, node, and consensus
integration. A negative answer returns the signature, commitment, transaction
relation, or proof profile to research, or stops the project. It is not
relabelled as a future node optimisation.

## 1.2 Decisions not owned by this paper

This experiment does not establish:

- scalable or private wallet note discovery;
- network-origin anonymity;
- deterministic private-state application under GHOSTDAG;
- full-node storage, pruning, recovery, or denial-of-service resistance;
- sustained end-to-end throughput of 1,000 accepted layer-1 transactions per
  second;
- production security; or
- legal, economic, or market readiness.

Those questions have different adversaries, measurements, and failure modes.
They are therefore separate manuscripts or later system evidence, not extra
sections appended to a successful proving benchmark.

# 2. Why a separate paper is necessary

The transaction relation is the earliest point where the selected standards,
open cryptographic choices, privacy model, and client-performance target must
work together. Testing the components separately cannot answer the decision in
Section 1.1.

The representative relation includes all of the following at once:

1. two committed input notes and their openings;
2. two authenticated Merkle membership paths;
3. two correctly derived, locally distinct public nullifiers;
4. two output notes and their public commitment openings;
5. binding between each output and its public encrypted-note payload;
6. complete verification of input authorisation under the selected
   <code>SLH-DSA-SHAKE-256f</code> profile;
7. canonical 64-bit values, limb ranges, carries, a public fee, and exact
   integer conservation;
8. one frozen transparent STARK transcript and zero-knowledge profile; and
9. the proposed individual-proof and, if retained, aggregate-proof wire modes.

Omitting any item answers an easier question and does not satisfy Quantum task
T305.

# 3. Prior work and non-duplication boundary

## 3.1 Search scope

The novelty screen was refreshed on 23 July 2026. It reviewed primary material
from NIST, the IACR Cryptology ePrint Archive and linked proceedings, author
manuscripts, the Zcash Improvement Proposal repository, and the original
PHANTOM/GHOSTDAG work. Search themes included:

- post-quantum confidential transactions and private payments;
- lattice RingCT with multiple inputs and outputs;
- transparent proofs and hash-signature verification or aggregation;
- anonymous KEMs and encrypted-note delivery;
- oblivious payment detection and light-client note discovery;
- transaction-origin anonymity; and
- GHOSTDAG ordering and state consistency.

This is a scoped novelty review, not proof that no related manuscript exists.
It must be repeated before submission and recorded with queries, dates, and
screening decisions in the evidence manifest.

## 3.2 Work that already addresses adjacent problems

| Prior work | What it establishes or investigates | Why this paper must not repeat its claim |
|---|---|---|
| Lattice RingCT v1.0 [LRCT1] and v2.0 [LRCT2] | Post-quantum linkable-ring-signature transactions; v2.0 adds multiple inputs, multiple outputs, and a balance model | A generic claim to be the first post-quantum private or multi-input/multi-output payment protocol is unavailable |
| MatRiCT [MATRIX] and MatRiCT+ [MATRIXPLUS] | Concrete lattice-based RingCT designs and implementation measurements | Quantum must compare against their model, proof sizes, latency, anonymity scope, and assumptions rather than presenting post-quantum RingCT as an open invention |
| Gao et al. [GAO] | More efficient lattice-based zero-knowledge balance proofs and ring signatures, applied to RingCT | A new balance proof or ring-signature efficiency claim requires direct comparison and an actual construction |
| ZK-STARK [STARK], DEEP-FRI [DEEPFRI], and later zero-knowledge analysis [STARKZK] | Transparent proof foundations, proximity testing, and explicit zero-knowledge treatment | Selecting the STARK family does not itself constitute novelty or prove that the Quantum profile is sound or zero knowledge |
| Khaburzaniya et al. [HASHAGG] | STARK-based aggregation and thresholdisation of hash-based signatures with concrete experiments | “Hash signatures can be put behind a STARK” is already established in another relation and parameter regime |
| Sphinx-in-the-Head [SPHINXHEAD] | Modifies a SPHINCS+-style credential to make its verification practical in a different zero-knowledge group-signature setting | Its redesign reinforces that exact standard SLH-DSA verification is a real measurement gate; results for a custom credential cannot be reused as Quantum evidence |
| Post-Quantum Privacy Pass [PQPP] | A STARK-friendly post-quantum credential design with concrete token trade-offs | General-purpose post-quantum proofs of authorisation are not unique to Quantum |
| GeT a CAKE [KEMANON] | Uses KEM anonymity and fuzziness in black-box KEM-to-PAKE transformations and analyses Kyber for those properties | Ordinary KEM confidentiality and ML-KEM standardisation alone cannot support a receiver-anonymity claim |
| Oblivious Message Retrieval [OMR], PerfOMR [PERFOMR], and OCash [OCASH] | Private recipient detection/retrieval and anonymous light-client payments | Scalable private note discovery is substantial prior work and remains a separate Quantum integration question |
| Dandelion++ [DANDELION] and later P2P-anonymity analysis [P2PANON] | Transaction-origin routing and attacks/limits in cryptocurrency P2P networks | A generic transaction-origin anonymity paper would duplicate a mature line of work |
| PHANTOM/GHOSTDAG [GHOSTDAG] | A blockDAG ordering protocol and security analysis | GHOSTDAG selection alone does not solve Quantum's nullifier, anchor, reward, and private-state semantics |

## 3.3 Candidate contribution

The candidate contribution is deliberately narrower than the works above:

1. a fully specified note/nullifier relation rather than a generic
   confidential-transaction label;
2. standardised <code>SLH-DSA-SHAKE-256f</code> verification as private witness
   work inside that complete relation;
3. binding of an authenticated, recipient-private post-quantum note-delivery
   payload to the same output proved by the transaction;
4. a transparent STARK profile with explicit zero-knowledge and quantum-random-
   oracle soundness accounting;
5. pre-registered client, verifier, proof, transaction, and aggregation budgets;
   and
6. two independently implemented, interoperable evidence pipelines.

Whether this combination contains a publishable technical contribution beyond
systems integration and negative or positive feasibility evidence is itself an
open review question. The paper must not use “first” or “novel” until a refreshed
literature review and independent specialist review support the exact wording.

## 3.4 Non-duplication gate before implementation

The project must not begin from a blank private-payment construction merely
because Quantum currently names different components. Before the T301–T305
profile is frozen, a signed architecture record must compare at least Lattice
RingCT v2.0, MatRiCT, MatRiCT+, Gao et al., and the proposed Quantum relation
across:

- sender, recipient, amount, and transaction-graph privacy definitions;
- input/output multiplicity, balance, range, and double-spend models;
- post-quantum assumptions and use of standardised primitives;
- setup, commitment, authorisation, and disclosure properties;
- proof, signature, key, and complete wire sizes;
- proving, verification, memory, and batching measurements;
- note delivery, recipient discovery, and light-client implications; and
- available implementations, vectors, audits, licences, and reproducibility.

That record must choose one of three honest paths:

1. adopt or adapt a published construction where it meets the Quantum
   requirements;
2. retain the STARK relation and identify the exact missing property or measured
   trade-off that justifies new work; or
3. treat the work as a replication/comparative feasibility study rather than a
   new protocol contribution.

If the comparison cannot identify a material Quantum-specific research question,
the correct action is to reuse prior work and not write a redundant protocol
paper.

# 4. Research questions and hypotheses

## 4.1 Research questions

**RQ1 — Completeness.** Can the exact public statement and private witness in
Section 6 express every required Quantum relation without an unchecked value,
key, index, payload, or context?

**RQ2 — Authorisation cost.** What trace length, proving time, peak memory,
proof-size contribution, and verifier cost result from two complete
<code>SLH-DSA-SHAKE-256f</code> verifications inside the selected STARK?

**RQ3 — Composition.** Can commitment openings, membership, nullifiers,
authorisation, encrypted-note binding, and carry-safe balance be composed
without lowering the declared post-quantum security target below 128 bits or
introducing witness leakage?

**RQ4 — Client feasibility.** Does the complete prover meet every frozen
single-wallet p50, p95, and p99 latency and memory threshold on both reference
hardware profiles?

**RQ5 — Wire feasibility.** Do the individual and proposed aggregate modes meet
their frozen proof-size, transaction-size, verifier, latency, and amortisation
thresholds without transmitting the proofs that an aggregate claims to replace?

**RQ6 — Reproducibility.** Can an independent implementation reproduce the
statement encoding, accepted/rejected vectors, proofs, and reported metrics
within the pre-registered tolerance?

## 4.2 Falsifiable hypotheses

Threshold symbols below are intentionally unresolved until T004 freezes their
numeric values. They must be replaced by signed, versioned values before the
first measured feasibility run.

| ID | Hypothesis | Required threshold owner |
|---|---|---|
| H1 | Both implementations accept every valid canonical vector and reject every invalid vector identically | T003/T004 |
| H2 | Complete desktop proving p95 and p99 do not exceed <code>L_desktop_p95</code> and <code>L_desktop_p99</code> | T004 |
| H3 | Complete constrained-client proving p95 and p99 do not exceed <code>L_client_p95</code> and <code>L_client_p99</code> | T004 |
| H4 | Peak and steady resident memory remain below the frozen hardware-specific budgets | T004 |
| H5 | Individual proof and complete wire-transaction bytes remain below <code>B_proof</code> and <code>B_tx</code> | T004 |
| H6 | Verifier latency, memory, and malformed-proof work remain below their frozen budgets | T004 |
| H7 | Aggregate mode meets size and latency budgets and omits replaced individual proofs | T004/T304 |
| H8 | Concrete composed soundness and privacy analysis reaches at least 128 post-quantum bits under the declared model | T001/T303/T701 |
| H9 | The second implementation reproduces metrics within the frozen tolerance and no semantic mismatch remains | T004/T305 |

A hypothesis with an unset threshold is **not evaluated**. A run performed
before threshold freeze is exploratory and cannot be relabelled as the
acceptance run.

# 5. Fixed design pressures from selected standards

The following figures are standard encodings, not benchmark results.

FIPS 205 specifies a 49,856-byte signature for
<code>SLH-DSA-SHAKE-256f</code>. Two independently authorised inputs therefore
place 99,712 signature bytes in the private witness before keys, notes,
membership paths, or proving-system data are counted. These bytes need not be
on the public transaction wire if verification is proved in zero knowledge,
but all required hash work remains part of the proved computation.

FIPS 203 specifies a 1,568-byte ciphertext for <code>ML-KEM-1024</code>. A
one-ciphertext-per-output profile would place at least 3,136 KEM ciphertext
bytes on a 2-output transaction before authenticated payloads, commitments,
nullifiers, proof data, and framing. At 1,000 such transactions per second,
the KEM ciphertexts alone would be 270,950,400,000 bytes per day. This is a
design-pressure calculation, not a prediction of the final wire format.

These values make three shortcuts invalid:

- measuring a mock or smaller signature profile;
- reporting only prover throughput while hiding single-wallet latency; or
- treating note delivery and wallet scanning as negligible because the proof
  itself is compact.

# 6. Frozen experiment statement

## 6.1 Public inputs

The canonical public input must contain exactly:

~~~text
PublicTransaction {
    protocol_version
    chain_id
    anchor_root
    anchor_context
    nullifiers[2]
    output_commitments[2]
    encrypted_note_payloads_or_digests[2]
    fee_u64
    expiry_context
    proof_mode
}
~~~

Every integer and byte string must have one canonical encoding and one maximum
length. Vector counts are fixed to two for this experiment. The statement must
reject unknown versions, trailing data, duplicate nullifiers, duplicate output
commitments, and non-canonical encodings before expensive verification work.

## 6.2 Private witness

For each input:

~~~text
InputWitness {
    note_plaintext
    commitment_randomness
    membership_path
    membership_index
    nullifier_secret
    authorisation_public_key
    slh_dsa_signature
}
~~~

For each output:

~~~text
OutputWitness {
    note_plaintext
    commitment_randomness
    note_encryption_witness
}
~~~

The witness also contains only the proof-system randomness and auxiliary trace
data required by the frozen profile. Hidden preprocessing, trusted witness
services, and omitted input or output openings are forbidden.

## 6.3 Required constraints

The AIR or equivalent relation must establish:

1. canonical version, chain, asset, and domain context;
2. both input commitment openings;
3. both complete membership paths against the public anchor;
4. both nullifiers derived from the corresponding opened notes and bound keys;
5. local nullifier uniqueness;
6. both authorisation keys bound by their opened input notes;
7. two complete <code>SLH-DSA-SHAKE-256f</code> verifications over the same
   canonical transaction-authorisation digest;
8. both output commitment openings;
9. both encrypted-note bindings to the same output plaintext, output index,
   transaction context, chain, and version;
10. canonical unsigned 64-bit ranges for all values and the fee;
11. carry-constrained integer equality
    <code>input_0 + input_1 = output_0 + output_1 + fee</code>;
12. output-commitment uniqueness; and
13. agreement of counts, ordering, flags, expiry, and proof mode across the
    statement, signed digest, encryption binding, and proof.

Global nullifier freshness, current-anchor admissibility, expiry, and
version-activation checks remain external state checks. Their absence from the
AIR must not be represented as proof that the transaction is globally
admissible.

# 7. Cryptographic profiles that must be frozen

## 7.1 Commitment

The report must identify one reviewed construction, exact parameters, setup
rules, randomness sampler, encodings, hiding and binding definitions, and
concrete post-quantum estimates. A family name such as Module-LWE/Module-SIS or
BDLOP is insufficient.

If the commitment cannot efficiently bind every note field required by the
specification inside the selected proof system, the experiment fails its
completeness condition.

## 7.2 Authorisation

The report must pin:

- the exact FIPS 205 parameter set and errata state;
- interface, context string, randomised or deterministic signing choice;
- key and signature encodings;
- transaction-authorisation digest;
- handling of the FIPS 205 message-bound signature caveat;
- in-circuit SHAKE256 and address/domain encodings; and
- malformed-key and malformed-signature behaviour.

Replacing SLH-DSA with a proof-friendly research signature answers a different
question and requires a revised specification and threat model before it can
be benchmarked.

## 7.3 Recipient encryption and binding

The report must pin the ML-KEM interface, KDF, authenticated encryption, nonce
rules, associated data, decapsulation-failure behaviour, replay rules, key
separation, and the receiver-anonymity game. The binding proved inside the
transaction must cover the actual output plaintext and public payload or
payload digest.

ML-KEM IND-CCA security does not by itself imply that a public ciphertext hides
which eligible recipient key was used.

## 7.4 STARK

The report must pin:

- base and extension fields and encodings;
- AIR columns, constraints, degrees, and trace padding;
- commitment hashes and digest lengths;
- Fiat–Shamir transcript order and domain tags;
- challenge sampling and rejection rules;
- FRI or DEEP-FRI variant, blow-up, queries, grinding, and batching;
- zero-knowledge masks and leakage argument;
- quantum-random-oracle and multi-proof soundness accounting;
- proof and public-input encoding; and
- verifier resource limits before attacker-controlled allocation.

The analysis must account for the full composed experiment. A nominal field
size, a count of queries multiplied by “bits”, or a failure-free test run is
not a soundness proof.

# 8. Independent implementation protocol

## 8.1 Separation

Two teams must implement the frozen profile from the public documents and
canonical vectors. They may share:

- specifications;
- generated external-standard KATs with provenance;
- the canonical wire schema; and
- a language-neutral vector corpus.

They must not share the same prover/verifier core, parser implementation, AIR
generator, or expected-value code path. Wrapping the same library in two
languages does not create independent implementations.

## 8.2 Required vectors

The corpus must include:

- minimum, typical, and maximum valid 64-bit values;
- zero and maximum permitted fees;
- carry boundaries including 65,535 + 1;
- distinct valid membership positions;
- deterministic output-encryption test fixtures;
- both proof modes, if aggregate mode remains;
- every malformed canonical encoding class; and
- every negative relation in Section 8.3.

Every vector must record its schema version, generator revision, provenance,
expected result, and independent confirmation.

## 8.3 Required negative relations

At minimum, each implementation must reject a proof attempt or proof for:

1. an altered input value with the original commitment;
2. an altered input commitment with the original path;
3. an unconstrained or wrong membership index;
4. a nullifier derived from a different note or key;
5. duplicate input nullifiers;
6. an authorisation key not bound by the input note;
7. a valid signature over a partial or differently ordered transaction;
8. a malformed SLH-DSA key or signature;
9. an altered output plaintext with the original commitment;
10. an encrypted payload bound to another output index or transaction;
11. values equal only after proof-field wraparound;
12. an unconstrained 16-bit limb or carry;
13. an omitted or altered fee, chain identifier, version, or expiry;
14. duplicate output commitments;
15. transcript domain or proof-mode confusion; and
16. an aggregate proof bound to a different ordered transaction set.

# 9. Benchmark protocol

## 9.1 Pre-registration

Before acceptance measurements, T004 must publish and sign:

- exact hardware identifiers, CPU features, memory, storage, and power mode;
- operating systems, kernels, compilers, dependencies, and revisions;
- clock source and measurement tooling;
- cold/warm cache policy and preprocessing policy;
- workload seeds and number of samples;
- allowed parallelism and thread affinity;
- p50, p95, p99, memory, verifier, proof, wire, and aggregate thresholds;
- reproduction tolerance; and
- rules for exclusions, crashes, retries, and failed proofs.

Any change after viewing acceptance results creates a new experiment version
and requires a new pre-registration.

## 9.2 Measurements

The raw record for every run must include:

- end-to-end proof-generation latency;
- per-component trace rows or cycles;
- peak and steady resident memory;
- proof bytes and full canonical transaction bytes;
- verifier wall time, CPU time, and peak memory;
- malformed-proof rejection time and allocation;
- parallel-prover scaling and saturation;
- aggregate creation latency, size, verifier cost, and amortisation;
- preprocessing time and bytes; and
- all warnings, failures, retries, and outliers.

Single-wallet measurements run with only the frozen wallet parallelism.
Separate throughput experiments may use additional workers, but their results
must not be substituted for wallet latency.

## 9.3 Environments

At least two named classes are required:

1. **reference desktop**, representing the intended proving environment; and
2. **constrained client**, representing the weakest client that the release
   requirements claim can construct a private transaction locally.

Cloud hardware may provide supplemental throughput data but cannot silently
replace either frozen client profile.

# 10. Security-analysis deliverables

The feasibility report must be accompanied by:

1. a formal relation and traceability map to every constraint in Section 6.3;
2. commitment correctness, hiding, and binding analyses;
3. transaction unforgeability and no-inflation arguments;
4. recipient-key privacy and encrypted-note integrity analyses;
5. STARK completeness, knowledge soundness, and zero-knowledge analyses;
6. Fiat–Shamir/QROM treatment for the exact adaptive and multi-proof setting;
7. concrete post-quantum security accounting across all relevant targets and
   the intended protocol lifetime;
8. side-channel scope and constant-time review for secret-dependent work; and
9. a list of assumptions and properties not covered.

The benchmark may show that an implementation is fast enough. It cannot prove
any item in this list by measurement alone.

# 11. Evidence package

A complete package contains:

~~~text
evidence/t305/<experiment-id>/
├── preregistration/
│   ├── thresholds.json
│   ├── hardware.json
│   └── signatures/
├── profile/
│   ├── relation.md
│   ├── encodings.md
│   ├── cryptographic-profile.md
│   └── dependency-locks/
├── vectors/
│   ├── manifest.json
│   ├── positive/
│   └── negative/
├── implementation-a/
├── implementation-b/
├── raw/
├── reports/
│   ├── security-analysis.pdf
│   ├── benchmark-report.pdf
│   ├── interoperability-report.md
│   └── unresolved-risks.md
└── decision/
    ├── stop-go.md
    └── approvals/
~~~

The real implementation repository may choose a different root, but the
manifest must map every logical artifact above to an immutable digest and
revision. This documentation repository does not pretend that those artifacts
already exist.

# 12. Stop/go rules

The decision is **GO** only if all of the following are true:

- the frozen relation contains every required constraint;
- two genuinely independent implementations interoperate;
- every positive and negative vector has the expected result;
- every pre-registered desktop and constrained-client threshold passes;
- individual and aggregate wire modes meet their separate thresholds;
- the composed security analysis reaches the required target;
- no critical or high unresolved review finding remains;
- all raw artifacts and reproduction commands are public; and
- accountable human reviewers sign their respective boundaries.

The decision is **STOP/REVISE** if any condition fails. The report must identify
which of these design surfaces returns to research:

- authorisation profile;
- commitment construction;
- transaction relation;
- note-encryption composition;
- proof-system profile;
- client-support claim; or
- aggregate mode.

Removing a required relation, weakening privacy, adding a classical fallback,
or changing a threshold after measurement is not an optimisation.

# 13. Interfaces to the remaining research papers

If T305 passes, three separate research questions remain:

1. **Private post-quantum note discovery:** use the frozen output format and
   measured output rate to evaluate local scanning, compact broadcast, OMR,
   OCash-like, or another explicitly modelled design.
2. **Network-origin anonymity:** use the frozen transaction size and target
   rate to evaluate a named observer model, cover traffic, delay, reliability,
   and denial-of-service behavior.
3. **GHOSTDAG private-state semantics:** define deterministic anchor,
   nullifier, commitment, reward, reorganisation, and finality behavior under
   the exact selected order.

Templates for these manuscripts live in
[the research-template directory](templates/README.md). They are not results
and must not be promoted to active papers until their entry criteria are met.

# 14. Limitations

This protocol fixes the shape of a decisive experiment but does not supply the
missing cryptographic profiles or implementations. Its 2-input/2-output shape
is representative, not proof that all future vector lengths or payment
policies have the same costs. A successful laboratory result does not establish
side-channel security, network anonymity, consensus safety, operational
stability, or production readiness.

The literature screen may miss unpublished, non-indexed, differently
terminologised, or newly released work. Before external submission, authors
must refresh the search, obtain specialist review, and narrow all originality
claims to demonstrated differences.

# References

- **[FIPS203]** NIST, [FIPS 203: Module-Lattice-Based Key-Encapsulation
  Mechanism Standard](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.203.pdf),
  2024.
- **[FIPS205]** NIST, [FIPS 205: Stateless Hash-Based Digital Signature
  Standard](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.205.pdf), 2024.
- **[LRCT1]** Torres et al.,
  [Post-Quantum One-Time Linkable Ring Signature and Application to Ring
  Confidential Transactions](https://eprint.iacr.org/2018/379), 2018.
- **[LRCT2]** Torres et al.,
  [Lattice RingCT v2.0 with Multiple Input and Multiple Output
  Wallets](https://eprint.iacr.org/2019/569.pdf), 2019.
- **[MATRIX]** Esgin, Zhao, Steinfeld, Liu and Liu,
  [MatRiCT: Efficient, Scalable and Post-Quantum Blockchain Confidential
  Transactions Protocol](https://eprint.iacr.org/2019/1287.pdf), 2019.
- **[MATRIXPLUS]** Esgin, Steinfeld and Zhao,
  [MatRiCT+: More Efficient Post-Quantum Private Blockchain
  Payments](https://eprint.iacr.org/2021/545.pdf), 2022.
- **[GAO]** Gao et al.,
  [Lattice-based Zero-knowledge Proofs for Blockchain Confidential
  Transactions](https://eprint.iacr.org/2021/1674), revised 2025.
- **[STARK]** Ben-Sasson et al.,
  [Scalable, Transparent, and Post-Quantum Secure Computational
  Integrity](https://eprint.iacr.org/2018/046.pdf), 2018.
- **[DEEPFRI]** Ben-Sasson et al.,
  [DEEP-FRI: Sampling Outside the Box Improves
  Soundness](https://eprint.iacr.org/2019/336.pdf), 2019.
- **[STARKZK]** Haböck and Al Kindi,
  [A Note on Adding Zero Knowledge to
  STARKs](https://eprint.iacr.org/2024/1037.pdf), 2024.
- **[HASHAGG]** Khaburzaniya, Chalkias, Lewi and Malvai,
  [Aggregating and Thresholdizing Hash-based Signatures Using
  STARKs](https://eprint.iacr.org/2021/1048.pdf), 2022.
- **[SPHINXHEAD]** Chen, Dong, Newton and Wang,
  [Sphinx-in-the-Head: Group Signatures from Symmetric
  Primitives](https://eprint.iacr.org/2024/649), 2024.
- **[PQPP]** Policharla, Westerbaan, Faz-Hernández and Wood,
  [Post-Quantum Privacy Pass via Post-Quantum Anonymous
  Credentials](https://eprint.iacr.org/2023/414), 2023.
- **[BDLOP]** Baum et al.,
  [More Efficient Commitments from Structured Lattice
  Assumptions](https://eprint.iacr.org/2016/997.pdf), 2016.
- **[KEMANON]** Beguinet, Chevalier, Pointcheval, Ricosset and Rossi,
  [GeT a CAKE: Generic Transformations from Key Encapsulation Mechanisms to
  Password Authenticated Key Exchanges](https://eprint.iacr.org/2023/470),
  2023.
- **[OMR]** Liu and Tromer,
  [Oblivious Message Retrieval](https://eprint.iacr.org/2021/1256.pdf), 2021.
- **[PERFOMR]** Liu et al.,
  [PerfOMR: Oblivious Message Retrieval with Reduced Communication and
  Computation](https://eprint.iacr.org/2024/204.pdf), 2024.
- **[OCASH]** Hansen, Nielsen and Simkin,
  [OCash: Fully Anonymous Payments between Blockchain Light
  Clients](https://eprint.iacr.org/2024/246), revised 2025.
- **[ZIP307]** Zcash Improvement Proposals,
  [ZIP 307: Light Client Protocol for Payment
  Detection](https://zips.z.cash/zip-0307), current specification.
- **[DANDELION]** Fanti et al.,
  [Dandelion++: Lightweight Cryptocurrency Networking with Formal Anonymity
  Guarantees](https://arxiv.org/abs/1805.11060), 2018.
- **[P2PANON]** Sharma, Gosain and Diaz,
  [On the Anonymity of Peer-To-Peer Network Anonymity Schemes Used by
  Cryptocurrencies](https://arxiv.org/abs/2201.11860), 2022.
- **[GHOSTDAG]** Sompolinsky, Wyborski and Zohar,
  [PHANTOM and GHOSTDAG](https://eprint.iacr.org/2018/104.pdf), 2018.
