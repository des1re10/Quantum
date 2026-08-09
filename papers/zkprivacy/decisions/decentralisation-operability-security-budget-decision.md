# Decentralisation, Operability, and Security-Budget Decision

**Status:** Recorded research direction; named owner and independent reviewer
signatures required before implementation; not a protocol, monetary-policy,
security, benchmark, or release approval<br>
**Decision revision:** 0.3.1-research<br>
**Decision date:** 2026-08-09<br>
**Applies to protocol design:** 0.5.2-research<br>
**Applies to:** R3–R12, T001, T004–T005, T204, T306, T501–T510,
T603–T605, T701, and Gates G5, G7, G10–G13<br>
**Evidence cut-off:** 2026-08-09<br>
**Accountable owner:** Unassigned<br>
**Independent reviewer:** Unassigned<br>
**Required specialist reviewers:** Proof systems, consensus, data availability
and storage, mining and pool incentives, monetary economics, performance, and
legal counsel for any change to the public monetary commitment<br>
**Approval status:** PENDING

## Decision

Quantum will promote independent operability, current-data availability,
trustless recovery, producer contestability, transaction-selection incentives,
and long-run proof-of-work funding from implicit design concerns to explicit
research requirements and release gates.

This record does not claim that a protocol can prevent concentration of energy,
hardware, capital, bandwidth, storage, or proving capacity. It separates the
capabilities a concentrated role may obtain and requires each to be measured:

1. accepting an invalid state transition;
2. withholding current or recovery data;
3. selecting, delaying, or censoring valid transactions;
4. controlling pooled miners' block templates;
5. making independent validation institutionally expensive; and
6. weakening the security budget as issuance changes.

The following directions are recorded:

- add R9/G10 for a versioned executing-validator operability profile paired
  with the throughput gate;
- add R10/G11 for current-data availability and recovery without a trusted sole
  provider;
- add R11/G12 for miner-controlled template construction, non-custodial pooled
  mining research, and ordering/censorship incentives;
- add R12/G13 for an explicit monetary-security decision with exact accounting
  and independently reviewed assumptions;
- evaluate witness-carrying state and accumulated-validity proofs as
  **candidates**, not as already selected protocol mechanisms; and
- evaluate proof-of-work candidates for hardware contestability before the PoW
  profile is selected.

The existing 21,000,000 QTM **lifetime gross-issuance cap remains the current
requirement**. A tail emission, burn/reissuance policy, outstanding-supply cap,
demurrage rule, or other replacement is not selected by this record. Any such
change requires a separately versioned product decision, exact public wording,
monetary-economics review, consensus review, and legal review.

## 1. Problem and acceptance boundary

The 0.4.0 research design made at least 1,000 accepted layer-1 transactions per
second a hard release target. It required resource reporting and recognised
that parallel block production does not reduce validator work, but it did not
place a separately failing ceiling on the cost of independent operation.
Consequently, the throughput gate could be made easier by choosing more
expensive reference hardware after observing results.

The acceptance boundary is therefore:

- G7 and G10 are evaluated as a pair;
- current block validity and current data availability are separate claims;
- proof soundness and recovery availability are separate claims;
- deterministic consensus and transaction-selection incentives are separate
  claims; and
- a non-zero token reward, finite issuance cap, or projected fee market is not
  by itself evidence of adequate economic security.

No gate in this record has been run. Failure to satisfy a gate is a design
result, not permission to rename a node role, increase the hardware profile, or
move required work to an unreported service.

## 2. D1 — Operability profile and paired gate

**Status:** Requirement draft; independent review pending.

Every named release candidate and benchmark campaign must freeze one executing-
validator resource profile before results are interpreted. The profile must
state at least CPU architecture and physical cores, memory, sustained disk I/O
and endurance, operational storage, network capacity, power measurement,
accelerator policy, bootstrap time and bytes, retail availability, and cost
method.

The specification deliberately does not invent the numeric ceilings. T005 must
derive and pre-register them from dated evidence for hardware and connectivity
that are independently obtainable in multiple regions. Preliminary calibration
runs may inform a later profile version, but they cannot be reused as the
passing campaign for that version.

The profile is immutable for the named release candidate and campaign. Any
change creates a new profile and new release evidence. The failed campaign
remains failed for the old profile.

For G12, T005 must also freeze the named metrics, adversarial scenarios,
pass/fail thresholds, and STOP conditions for custom-template latency and
revenue penalty, direct publication, inclusion under censorship, pooled-mining
overhead, specialised-hardware efficiency, and relevant concentration. The
decision records the required dimensions, not fabricated numerical values.

**Pass:** G7 reaches the target without exceeding the frozen profile, including
current validation, restart, reorganisation, pruning, bootstrap, wallet
maintenance, and required recovery traffic.

**Reject:** a cloud-only service is called non-institutional without an
availability and cost argument; required proving or state services are hidden
outside the role being measured; reference hardware is raised after a result;
or throughput is published without its operability profile.

## 3. D2 — Roles and proof boundary

**Status:** Candidate architecture; T306 and T505 are blocking research tasks.

The design must distinguish at least:

- an **executing validator**, which obtains the complete current block body and
  required current-state data or authenticated transition witnesses, validates
  them, and derives the current consensus state;
- a **succinct verifier**, which checks a compact accumulated-validity artifact
  but does not inherit the executing-validator claim;
- a **block producer** and miner-controlled **Template Provider/Job Declarator**;
- a **prover or aggregator**;
- a **state or witness provider**; and
- an **archive and recovery provider**.

Proof recursion remains permitted by R7.2 and is an important candidate. T306
measures only the generic proof-system accumulation capability, post-quantum
composition loss, verifier-in-circuit or equivalent cost, prover availability,
and degraded path. It must not freeze the exact Quantum consensus/state
relation before T503 and T504 define canonical ordering and monetary state.

A sound accumulated-validity proof can prevent acceptance of an invalid proved
transition under its stated assumptions. It does not by itself establish:

- publication of current block or state data;
- availability of wallet membership witnesses;
- selection of the canonical GHOSTDAG history unless canonicality is part of
  the proved relation;
- absence of censorship or selective proving; or
- recovery after all relevant data providers withhold service.

T505 must select the exact consensus-bound state-validity and bootstrap profile
after T306, T405, T503, and T504. It owns GHOSTDAG canonicality, ordered
accepted transactions, note/nullifier/policy state, rewards, fees, burns, issuance,
protocol version, checkpoint identity, and reorganisation semantics. It may
instantiate the T306 capability, another reviewed mechanism, or an
authenticated checkpoint/replay design. A rejected recursion candidate is not
itself a release failure if another profile satisfies R3, R9, and R10.

## 4. D3 — Current data and recovery

**Status:** Requirement draft; G11 blocking.

An executing validator must possess and validate the complete current block
body, proof representation, and data required by the selected state-transition
profile before accepting the block. Sampling alone is not executing
validation.

Pruning is allowed, but no trusted sole archive, snapshot signer, state
provider, foundation, or company may be required for validator bootstrap,
state recovery, wallet recovery, or reconstruction of protocol-required data.
The selected design must specify commitments, encoding, reconstruction,
repair, selective-withholding behaviour, eclipse resistance, and incentive or
retention assumptions.

The protocol cannot prevent an observer from retaining every public header,
commitment, nullifier, ciphertext, or block body. Distributed storage is an
availability property, not a privacy guarantee. Non-consensus metadata such as
first-seen time, IP address, peer route, RPC identity, and operator logs remains
inside the R2/T602 network-privacy threat model.

Kaspa KIP-15 and KIP-21 are relevant sequencing-commitment precedents, not a
complete Quantum solution. KIP-15 describes a specialised Accepted
Transactions Archival Node and assumes a bootstrapping client has access to a
Kaspa full node. KIP-21 specifies partitioned sequencing commitments intended
to make lane-local proving proportional to lane activity, while its proving
companion was still marked **Reserved** at the evidence cut-off. Neither fact
establishes Quantum data availability, state reconstruction, or proof cost.

## 5. D4 — Miner-controlled templates and pooled mining

**Status:** Requirement draft; G12 blocking.

Quantum must not require pooled miners to delegate transaction selection to the
pool. The mining protocol must support a miner-controlled full node or Job
Declarator constructing and committing to its own candidate template while a
separate pool/share aggregator accounts for work.

The protocol must define how a miner can publish a valid found block, how a pool
acknowledges a custom job, how shares bind to that job, and how private reward
outputs and payout accounting work. A non-custodial pooled-mining design is a
required comparator, not a claim that an existing P2Pool protocol can be copied
unchanged.

Protocol permission does not guarantee operator adoption. T507 must measure
latency, bandwidth, variance, privacy, payout, and revenue overhead against
pool-selected templates. Any statement that delegated selection is not
materially cheaper requires a threshold frozen by T005.

## 6. D5 — Ordering, censorship, and extraction incentives

**Status:** Blocking research gate.

The core privacy profile reduces value-aware application-layer ordering
opportunities by hiding amounts, recipients, and direct transaction-graph
relationships. It does not eliminate public fees, nullifier conflicts,
transaction and proof sizes, anchor or expiry context, arrival time, mempool
visibility, censorship, data withholding, reorganisation, or
transaction-selection incentives.

No fee bucket, deterministic tie-breaker, encrypted mempool, batch auction, or
inclusion rule is selected by this record. T508 must compare candidates and
measure the value that remains extractable when transaction semantics are
hidden. At minimum it must cover:

- fee and fee-density selection;
- conflicting-nullifier selection;
- transaction-identifier and timing grinding;
- duplicate inclusion across parallel blocks;
- self-fees and fee sniping;
- selective and blanket censorship;
- reorganisation incentives; and
- incentives for independent deviators to form a shared pool.

The PHANTOM/GHOSTDAG transaction-selection preprint is evidence that this gate
cannot be replaced by an assumption. It is not, by itself, proof that the same
strategy is profitable under Quantum's final ordering, fee, privacy, and block
rules.

The G12 campaign must fail if no candidate meets the T005 metrics, scenarios,
thresholds, and STOP conditions registered before results are viewed. A risk
description cannot convert a failed custom-template, publication, inclusion,
hardware, or concentration result into a pass.

## 7. D6 — Monetary policy and security budget

**Status:** Blocking research gate; product-level decision.

The monetary work is split into four separate questions:

1. **cap semantics:** lifetime gross issuance, maximum outstanding supply, or
   another explicitly worded commitment;
2. **issuance schedule:** the exact integer subsidy as a function of canonical
   DAG time/score;
3. **fee and burn policy:** which existing value is transferred or destroyed;
   and
4. **security model:** the resulting miner revenue, entry/exit, attack cost,
   concentration, and sensitivity under stated assumptions.

The current baseline remains a 21,000,000 QTM lifetime gross-issuance cap.
Under that baseline, a permanently positive newly issued subsidy is impossible
in discrete units. T506 must therefore compare at least:

- the current lifetime cap with a smoothed finite schedule and long-run fee
  funding;
- a perpetual fixed-absolute or fixed-percentage tail emission, which changes
  the lifetime-cap promise;
- an outstanding-supply cap with explicitly defined burn and reissuance, which
  permits lifetime gross issuance above the outstanding cap; and
- other non-oracle funding rules proposed with exact accounting.

No candidate may be selected merely because it copies Bitcoin, Kaspa, Monero,
or another network. A tail subsidy guarantees only a positive token-denominated
flow, not adequate fiat-denominated security. A hard cap does not prove that a
future fee market is adequate.

Accounting must distinguish:

~~~text
claimed_fees          = min(reward_outputs, collected_fees)
claimed_subsidy       = reward_outputs - claimed_fees
foregone_subsidy      = authorised_subsidy - claimed_subsidy
burned_existing_value = collected_fees - claimed_fees

next_gross_issuance   = gross_issuance + claimed_subsidy
next_outstanding      = previous_outstanding
                        - collected_fees
                        + reward_outputs
~~~

Foregone subsidy was never issued and is not burned existing value. Under the
current lifetime-cap baseline, burned existing value does not restore issuance
headroom. More use creates more fees, not necessarily more burn.

Any change to cap semantics or the public 21-million statement requires a
named Product Owner, monetary-economics reviewer, consensus reviewer, and Legal
Counsel to sign the exact revision and public wording. Engineering review alone
cannot approve it.

Before candidate results are interpreted, T506 must register its scenario
sets, metrics, pass/fail thresholds, and STOP conditions for fee and miner-
revenue cases, price and energy shocks, entry/exit and hashrate response,
security-expenditure or attack-cost proxies, and concentration. If no policy
meets those registered conditions, T506 stops or starts a new reviewed campaign;
it must not select a policy by describing the failed result as residual risk.

## 8. D7 — Proof-of-work hardware contestability

**Status:** Candidate comparison; no PoW algorithm selected.

Quantum will not claim ASIC resistance. T509 must compare candidate proof-of-
work functions before T502 selects the consensus PoW profile. The evidence must
include verification cost, commodity CPU/GPU performance, plausible
specialised-hardware advantage, memory and chip-area requirements, energy,
open miner implementations, manufacturing and supplier concentration, cloud
and botnet exposure, and compatibility with the proposed block rate.

The result may select a specialised-hardware-friendly, memory-hard, or other
profile only with its residual concentration model stated. The objective is
measured contestability, not an unprovable hardware label.

## 9. D8 — Post-quantum upgrade governance

**Status:** Blocking research gate; no authorisation or activation mechanism
selected.

R7.3 cannot be discharged by release review alone. T510 owns the exact post-
quantum principals, authorisation rule, canonical proposal and activation
encodings, key generation and lifecycle, compromise recovery, normal and
emergency state machines, timelocks or thresholds, replay/downgrade protection,
and persistent-split analysis.

The task may select a voting, threshold-signature, constitution-like, or other
model only after its exact trust and failure boundaries are stated. Social
coordination may remain part of incident response, but it is not a substitute
for deterministic consensus activation rules. No hidden unilateral key,
classical fallback, or unspecified emergency bypass may activate a release.

Passing T510 does not prove governance decentralisation or prevent capture by
a formally authorised quorum. The threat model must cover principal
concentration, bribery, collusion, strategic abstention, veto power, and control
of client distribution. It must also keep deterministic protocol activation
separate from voluntary social adoption: an on-chain or signed activation rule
cannot prevent users from declining a client release or choosing a social fork.

## 10. Task-graph decision

The verification guide owns the executable task graph. The required ordering
is:

~~~text
T004 Benchmark and artifact harness                      <- T001, T002
T005 Operability-profile freeze                          <- T001, T002, T004

T306 Proof-system accumulation capability               <- T303, T304, T005

T501 Versioned GHOSTDAG consensus profile                <- T001, T002
T509 PoW hardware contestability study                   <- T001, T004, T005, T201, T501
T502 Header, selected PoW and deterministic DAA          <- T201, T501, T509
T510 Post-quantum upgrade governance and activation      <- T001, T002, T202, T501, T502
T503 Canonical DAG-to-state ordering                     <- T403, T501, T502
T506 Monetary-security decision                          <- T001, T004, T005, T501, T509
T504 Rewards, selected supply policy and genesis         <- T503, T506
T505 Consensus-bound state validity and bootstrap        <- T306, T405, T503, T504
T507 Miner-template and pooled-mining profile            <- T501, T502, T503, T504
T508 Ordering, censorship and incentive gate             <- T005, T503, T507

T605 Current-data availability, snapshot and recovery    <- T002, T004, T005, T505, T601
T603 Full node, pruning and recovery                      <- T305, T403, T505, T601, T605
T604 End-to-end system validation                        <- T405, T508, T602, T603
~~~

T004 owns the method and artifact harness. T005 freezes the profile before any
later result is interpreted; there is no dependency in the reverse direction.
T509 precedes PoW selection. T306 owns only generic proof-system capability;
T405, T503, and T504 precede T505 so that the exact Quantum relation cannot
omit payment-policy state, canonical ordering, rewards, fees, burns, or
issuance. T510 owns post-quantum upgrade authorisation and activation before
release review.

## 11. What this decision does not establish

- It does not establish that 1,000 accepted tx/s and an independently obtainable
  validator profile are jointly achievable.
- It does not select recursion, witness-carrying state, a data-availability
  code, fee buckets, a pool protocol, a PoW algorithm, an emission schedule, or
  a replacement cap semantic or upgrade-governance mechanism.
- It does not make a concentrated producer, prover, state provider, or archive
  harmless.
- It does not prove a minimum real-world attack cost.
- It does not prove governance decentralisation, prevent capture by an
  authorised quorum, or remove the boundary between protocol activation and
  voluntary social adoption.
- It does not approve implementation, testnet, token issuance, or production.

## 12. Evidence snapshot and sources

The Kaspa KIP repository snapshot used for KIP-15 and KIP-21 was master commit
`e4ae2332117b5cb68bd6188e065ef885b6d17939` on 2026-08-09.

1. Perešíni et al., [DAG-Oriented Protocols PHANTOM and GHOSTDAG under
   Incentive Attack via Transaction Selection Strategy](https://arxiv.org/abs/2109.01102),
   arXiv preprint, 2021.
2. Mike Zak and Ro Ma, [KIP-15: Canonical Transaction Ordering and
   SelectedParent Accepted Transactions Commitment](https://github.com/kaspanet/kips/blob/e4ae2332117b5cb68bd6188e065ef885b6d17939/kip-0015.md).
3. Michael Sutton, Maxim Biryukov and Hans Moog,
   [KIP-21: Partitioned Sequencing Commitment with O(activity) Proving](https://github.com/kaspanet/kips/blob/e4ae2332117b5cb68bd6188e065ef885b6d17939/kip-0021.md),
   including the [reserved proving companion](https://github.com/kaspanet/kips/blob/e4ae2332117b5cb68bd6188e065ef885b6d17939/kip-0021/proving-spec.md).
4. Stratum V2,
   [Job Declaration Protocol](https://stratumprotocol.org/specification/06-job-declaration-protocol/).
5. Thaddeus Dryja,
   [Utreexo: A dynamic hash-based accumulator optimized for the Bitcoin UTXO set](https://eprint.iacr.org/2019/611).
6. Al-Bassam, Sonnino and Buterin,
   [Fraud and Data Availability Proofs](https://arxiv.org/abs/1809.09044).
7. Carlsten et al.,
   [On the Instability of Bitcoin Without the Block Reward](https://www.cs.princeton.edu/~arvindn/publications/mining_CCS.pdf),
   CCS 2016.

These sources provide prior art, threat questions, or comparator mechanisms.
They do not verify the Quantum design.

## 13. Revision record

### 0.3.1-research — 2026-08-09

- aligned this independently versioned decision with protocol design
  0.5.2-research without selecting a replacement monetary policy;
- made T505 depend on T405 before binding bounded payment-policy state into the
  exact consensus relation; and
- added principal-capture, client-distribution, and voluntary-social-adoption
  boundaries to D8 without presenting deterministic activation as governance
  decentralisation.

### 0.3.0-research — 2026-08-09

- separated T306 generic proof-system accumulation capability from the exact
  consensus/state relation owned by T505 after T503 and T504;
- added T510 as the owner of post-quantum upgrade authorisation, activation,
  key lifecycle, compromise recovery, and emergency behaviour;
- made G12 and G13 depend on metrics, scenarios, thresholds, and STOP conditions
  registered before candidate results are interpreted; and
- aligned monetary evidence with the selected policy invariant and prevention
  of unauthorised issuance without selecting a replacement for the current
  lifetime gross-issuance cap.

### 0.2.0-research — 2026-08-09

- added R9–R12/G10–G13 research directions without marking a gate passed;
- kept recursion, witness-carrying state, ordering rules, PoW, and monetary
  replacements as candidates rather than silently selecting them;
- preserved the existing lifetime gross-issuance cap pending a separately
  signed product decision;
- separated validity, current data, recovery, censorship, pool control,
  hardware contestability, and economic security;
- corrected fee, foregone-subsidy, and burned-existing-value accounting; and
- recorded primary-source boundaries for GHOSTDAG incentives, sequencing
  commitments, job declaration, accumulators, data availability, and long-run
  fee-funded security.
