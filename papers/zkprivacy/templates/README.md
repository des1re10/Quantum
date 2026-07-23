# Quantum research-paper templates

These files are planning templates, not active manuscripts, completed research,
or publication claims. They define the three major questions that remain after
the complete-transaction feasibility gate.

## Publication programme

| Order | Manuscript | Current status | Entry criterion |
|---:|---|---|---|
| 1 | Stateless Versus Stateful Hash-Based Authorisation Inside a Private-Transaction STARK | Active comparative research protocol | Now: it defines the T305 experiment and prior-art decision |
| 2 | Private Post-Quantum Note Discovery at High Throughput | Template | Frozen output format and measured T305 transaction/output sizes |
| 3 | Network-Origin Anonymity for a High-Throughput BlockDAG | Template | Frozen transaction propagation format, throughput workload, and observer model |
| 4 | Deterministic Private-State Semantics for GHOSTDAG | Template | Frozen transaction/state transition and versioned GHOSTDAG candidate |

The programme therefore contains **four intended research manuscripts**: one
active protocol and three templates. The final T701 composition and release
decision is an evidence dossier, not a fifth research paper unless it later
contains an independently reviewable scientific contribution.

## Promotion rule

A template becomes an active paper only when:

1. its entry criterion is satisfied;
2. its literature search is refreshed and recorded;
3. the exact novelty claim survives independent specialist review;
4. threat model, hypotheses, metrics, and failure thresholds are frozen before
   results are viewed; and
5. its filename moves to the parent <code>papers/zkprivacy/</code> directory.

Root-level Markdown files in <code>papers/zkprivacy/</code> are active
publication sources and are converted to same-name PDFs. Files in this
template directory are deliberately excluded from the PDF build and public
paper list.

The versioned decision records under <code>papers/zkprivacy/decisions/</code> gate
the manuscripts but do not add to the paper count.
