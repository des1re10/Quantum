# Decentralisation, Operability, and Security-Budget Decision

**Status:** Recorded research direction; named owner and independent reviewer
signatures required before implementation; not a protocol, monetary-policy,
security, benchmark, or release approval<br>
**Decision revision:** 0.3.3-research<br>
**Decision date:** 2026-09-05<br>
**Applies to protocol design:** 0.5.4-research<br>
**Applies to:** R1, R3–R12, T001, T004–T006, T204, T302, T306, T402–T403,
T501–T510, T603–T605, T701, and Gates G3B, G5, G7, G10–G13<br>
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
- compare a bounded, non-oracle dynamic-fee and finalised reward-window design
  inside the retained lifetime cap without claiming that it guarantees miner
  revenue or real-world attack cost;
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

T005 also pre-registers the early receiving and transport envelope for T006.
T006 uses actual T401/T402 encrypted-output artifacts, explicitly modelled
proof/transport components and frozen offline/client/provider workloads. Its
NOT_RULED_OUT result only permits T305; it passes no privacy or capacity gate.
Actual T305 sizes outside the envelope require a new reviewed screen before
integration. Missing required evidence cannot pass the screen.

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

The bounded dynamic-fee candidate adds controller-specific strategies to this
gate. T508 must test whether miners or pools can omit transactions, create self-
fees, alter accepted weight, time publication, duplicate high-fee transactions,
or coordinate reward-window work to move a later resource or security rate. It
must adversarially test the exact T506-frozen payout, pool, burn, and resource/
security/priority charge-to-destination allocation for inclusion, free-riding,
fee-sniping, censorship, variance, and pool-formation effects.

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

Within the lifetime-cap comparator, T506 must now include a bounded dynamic-fee
candidate. For each fee/reward epoch derived from canonical DAA score, it
separates:

- a **resource rate** driven by finalised canonical utilisation and transaction
  weight;
- a **security rate** driven by the gap between a pre-registered QTM-denominated
  sustainable-miner-budget objective and finalised authorised subsidy plus
  newly miner-eligible fees; burned fees, non-miner allocations, and old fee-
  pool withdrawals are excluded, while total accepted fees, claimed miner
  revenue, payout capacity, and pool balance remain separately reported; and
- an optional bounded priority amount or class whose public privacy and
  selection effects remain inside T508.

Transactions must know and commit to their fee epoch before authorisation. The
next controller state may use only canonical data finalised before the next
epoch, with exact integer rounding, update lag, minimum and maximum rates,
per-window change bounds, one explicit zero-accepted-weight transition, and an
exact expiry and epoch-admission/grace rule for delayed transactions. No
fiat-price, energy-price, local-mempool, arrival-order, wall-clock, or current-
candidate-block input is permitted.

T402 freezes the canonical static/dynamic fee-context encoding and a weight
computable before signing. Variable proof-envelope size or later aggregate
membership cannot reprice signed effects; the profile must use fixed lengths
or enforce conservative bounds and reject oversize envelopes. T506 instantiates
the dynamic context without a silent fallback to static fees. If it changes
the proved relation or cost envelope, dependent T305 evidence must be rebuilt.

The selected allocation must decompose every canonically accepted total fee by
both charge class—resource, security, and optional priority—and destination—new
miner-eligible pool value, explicit burn on acceptance, and a named non-miner
output. Those sums must be equal. Any allocation matrix between the two views is
an exact T506 parameter, not a miner or implementation choice. Miner-eligible
new fees exclude value already designated for burn or a non-miner output; an
expiry burn may occur only after the frozen maturity/claim opportunity and is
reported separately from sustainable and claimed miner revenue.

The controller is a pricing and variance-management candidate, not a source of
funds. When transaction demand is absent, fee revenue remains zero. Missing a
target records an underfunded G13 result and never authorises extra issuance,
restores issuance headroom, or changes the 21-million commitment. T506 must
reject a controller that reaches a miner-revenue threshold only by breaching a
pre-registered user-cost, stability, concentration, or censorship threshold.
The controller must use sustainable miner budget—authorised subsidy plus only
new miner-eligible fees—rather than total fees, burns, non-miner outputs, reward
outputs, or an old fee-pool balance. This prevents destroyed value or delayed
payout from masquerading as new miner revenue and prevents a producer from
raising a later rate merely by foregoing an authorised reward. Claimed revenue
remains part of the G13 evidence. Payout capacity includes only authorised
subsidy and matured claimable miner-fee-pool value.

Each fee enters exactly one canonical acceptance interval on the selected
history. A reorganisation atomically reverses its old assignment, pool change,
burn, and output before any exactly-once assignment on the new history.
T506 must compare direct allocation to the first-including eligible work,
partial and full delayed pooling, partial payout plus explicit burn, and
different treatment of the resource-fee and security-fee components. It must
freeze one exact rule before T504. The exact work weights, pool maturity,
maximum retention, rounding, remainder, burn, and optional-priority treatment
remain unselected until that decision. T508 then tests the frozen rule against
its adversarial thresholds; it does not edit monetary policy in place.

No candidate may be selected merely because it copies Bitcoin, Kaspa, Monero,
or another network. A tail subsidy guarantees only a positive token-denominated
flow, not adequate fiat-denominated security. A hard cap does not prove that a
future fee market is adequate.

Accounting must distinguish:

~~~text
accepted_total_fees = accepted_resource_fees
                      + accepted_security_fees
                      + accepted_priority_fees
accepted_total_fees = miner_eligible_new_fees
                      + fees_burned_on_acceptance
                      + other_explicit_fee_outputs
available_miner_fee_pool = previous_miner_fee_pool
                           + miner_eligible_new_fees
0 <= matured_claimable_fee_pool <= available_miner_fee_pool
0 <= claimed_fees <= matured_claimable_fee_pool
0 <= claimed_subsidy <= authorized_subsidy
reward_outputs = claimed_fees + claimed_subsidy
foregone_subsidy = authorized_subsidy - claimed_subsidy
0 <= fees_burned_from_pool <= available_miner_fee_pool - claimed_fees
burned_existing_value = fees_burned_on_acceptance
                        + fees_burned_from_pool
next_miner_fee_pool = available_miner_fee_pool
                      - claimed_fees
                      - fees_burned_from_pool
next_cumulative_issuance = cumulative_issuance + claimed_subsidy
next_note_supply = previous_note_supply
                   - accepted_total_fees
                   + reward_outputs
                   + other_explicit_fee_outputs
previous_outstanding_supply = previous_note_supply
                              + previous_miner_fee_pool
next_outstanding_supply = next_note_supply + next_miner_fee_pool
next_outstanding_supply = previous_outstanding_supply
                          + claimed_subsidy
                          - burned_existing_value
~~~

All values and intermediates are non-negative. The miner fee pool is a consensus
liability containing already-issued value. It counts toward outstanding supply
but never gross issuance; miner-eligible value that is not yet paid remains
there unless the selected rule explicitly burns it. Other allocations in this
candidate settle as named non-miner outputs in the same interval.
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

T506 must also freeze exact unsigned widths and operand maxima for monetary
fields, weight, rates, fee products, interval accumulators, and controller
state. Addition, multiplication, and accumulation are checked operations with
no wrap or saturation. Ceiling division uses quotient and remainder for a
non-negative numerator and positive divisor; an unchecked <code>a + b - 1</code>
construction is forbidden.

Genesis must commit to a zero initial miner fee pool, cumulative issuance and
note supply equal to the explicitly authorised genesis subsidy, and canonical
initial fee-controller epoch and rates. Under the retained no-premine baseline,
the genesis subsidy is zero.

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
and persistent-split analysis. It must also publish an exhaustive parameter
registry separating immutable historical invariants, normal-upgrade-only
protected parameters, and emergency-changeable parameters.

The task may select a voting, threshold-signature, constitution-like, or other
model only after its exact trust and failure boundaries are stated. Social
coordination may remain part of incident response, but it is not a substitute
for deterministic consensus activation rules. No hidden unilateral key,
classical fallback, or unspecified emergency bypass may activate a release.
No upgrade may rewrite cumulative issuance or erase or reclassify an accrued
fee-pool liability. An emergency path cannot change the 21-million cap semantic,
issuance schedule, fee allocation, or value-conservation equations. A
prospective monetary change requires a new T506 campaign, the named monetary
approvals, normal versioned activation, and rebuilt dependent evidence.

R1.7/R7.10 also require continuity of note-instance identity and spent status.
T510 consumes T204's key/recovery policy, T302's immutable nullifier-domain
contract and T403's apply/revert state. Active transaction/proof versions must
not give an old spent note a fresh nullifier or silently strand unspent notes.
Any explicit migration must consume the old instance once, preserve value and
define historical signing, offline recovery and reorg behaviour before activation.

Passing T510 does not prove governance decentralisation or prevent capture by
a formally authorised quorum. The threat model must cover principal
concentration, bribery, collusion, strategic abstention, veto power, and control
of client distribution. It must also keep deterministic protocol activation
separate from voluntary social adoption: an on-chain or signed activation rule
cannot prevent users from declining a client release or choosing a social fork.

## 10. Task-graph decision

The [verification guide](../zkprivacy-verification-guide.md)
owns the complete 41-task dependency graph. This record states the decision
boundaries; it does not maintain a second copy of that graph.

T002 owns common encoding rules and interface ownership, T401 the encryption
contract, T402 the staged codec, and T304 the proof envelope. T401 and T402
precede T301; T006 and T402 precede T305. Early task completion must not require
future protocol measurements. T510 additionally consumes T204/T302/T403 so
activation cannot ignore historical-note continuity.

T503 must freeze the exact header/checkpoint execution context, separate
malformed-block rules from contextual transaction rejection, and test parallel
conflicts with atomic rollback. The symbolic example in specification Section
7.3.1 is an illustrative deferred-acceptance candidate, not a selected consensus
profile or a correctness proof. T503 uses an accounting interface; T504 supplies
the selected reward and fee semantics without a reverse task dependency.

T004 owns the method and artifact harness. T005 freezes the profile before any
later result is interpreted; there is no dependency in the reverse direction.
T509 precedes PoW selection. T306 owns only generic proof-system capability;
T405, T503, and T504 precede T505 so that the exact Quantum relation cannot
omit payment-policy state, canonical ordering, rewards, fees, burns, or
issuance. T510 owns post-quantum upgrade authorisation and activation before
release review.

For each monetary campaign, T506 freezes the exact fee, controller, pool, and
burn rule before T504. T508 may reject but must not revise that frozen rule. A
rejection starts a new versioned T506 campaign and invalidates dependent
T504/T507/T508 evidence until the replacement is implemented and retested; this
campaign reset is not a reverse dependency in the task DAG.

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
8. Ethereum Improvement Proposal 1559,
   [Fee market change for ETH 1.0 chain](https://eips.ethereum.org/EIPS/eip-1559),
   including the base-fee burn as prior art for reducing producer manipulation
   incentives rather than as evidence that the same allocation fits Quantum.

These sources provide prior art, threat questions, or comparator mechanisms.
They do not verify the Quantum design.

## 13. Revision record

### 0.3.3-research — 2026-09-05

- Aligned with design 0.5.4, T006 receiving/transport screening and pre-sign
  fee-context/weight construction, without selecting fees or budgets.
- Required note/nullifier continuity through upgrades and explicit contextual
  DAG acceptance/rejection/rollback semantics.
- Replaced the duplicated graph with its canonical verification-guide owner
  and recorded the prerequisite/interface boundaries.
- Preserved the 2026-08-09 prior-art snapshot, 21-million lifetime cap and
  pending specialist approvals; no gate or implementation is approved.

### 0.3.2-research — 2026-08-25

- aligned the decision with protocol design 0.5.3-research while retaining the
  21,000,000 QTM lifetime gross-issuance cap;
- recorded a bounded dynamic resource/security fee controller and finalised
  reward-window allocation as required T506/T508 comparators, not as a selected
  policy or miner-revenue guarantee;
- added fee-pool liability accounting, payout/burn variants, and the rule that a
  T508 rejection starts a new T506 campaign;
- separated total accepted fees from miner-eligible revenue and constrained
  payout capacity to matured claimable pool value;
- required non-negative checked arithmetic, canonical reorg reassignment,
  explicit genesis controller state, and emergency-upgrade monetary guards; and
- required explicit zero-demand underfunding, prior-finalised inputs, integer
  clamps, no oracle, no extra issuance, and manipulation/free-riding analysis.

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
