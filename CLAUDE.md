# CLAUDE.md — Quantum

## Scope

Quantum is a static documentation website and research-paper repository. It
does not currently contain a blockchain, node, wallet, API, backend, database,
or frontend framework.

Read and follow [AGENTS.md](AGENTS.md) before work. It owns the audit workflow,
required prompts, local start commands, and fail-fast policy; those rules are
not duplicated here.

## Research status

The current protocol document is revision <code>0.3.0-research</code>, even
though its legacy filename contains “v1”.

The three non-negotiable release requirements are:

1. ≥128-bit composed post-quantum security without classical fallbacks;
2. private transfers and network anonymity by default, with no transparent
   transaction mode; and
3. ≥1,000 accepted layer-1 transactions per second in a reproducible,
   privacy-enabled end-to-end benchmark.

These are targets. Never describe them as achieved until the matching evidence
gates in the specification and verification plan pass.

The initial product boundary is private post-quantum cash and settlement with
selective disclosure and a finite set of bounded payment policies. General
smart contracts, private assets, bridges, and cross-chain execution are
separate later profiles and do not inherit base-protocol claims.

## Canonical files

| Responsibility | Owner |
|---|---|
| Protocol requirements and candidate design | <code>papers/zkprivacy/zkprivacy-quantum-spec-v1.md</code> |
| Task graph and evidence gates | <code>papers/zkprivacy/zkprivacy-verification-guide.md</code> |
| T305 research protocol and prior-work boundary | <code>papers/zkprivacy/quantum-private-transaction-feasibility.md</code> |
| Future-paper scope and promotion gates | <code>papers/zkprivacy/templates/</code> |
| Public research positioning | <code>index.html</code> and <code>README.md</code> |
| Market/claim wording | <code>Documentation/Quantum_Market_Thesis.html</code> |
| Actual static-site architecture | <code>Documentation/SystemArchitecture.html</code> |
| Public site styles | <code>assets/css/style.css</code> |
| Internal document styles | <code>Documentation/assets/documentation.css</code> |

Root-level Markdown papers in <code>papers/zkprivacy/</code> are active source
documents. Their same-name PDFs are generated artifacts and must be rebuilt
after material changes. Markdown files under
<code>papers/zkprivacy/templates/</code> are planning artifacts, are excluded
from the PDF build, and must not be presented as completed papers or results.

## Technology and structure

~~~text
Quantum/
├── index.html
├── assets/
├── papers/zkprivacy/
├── Documentation/
├── tools/Scripts/
├── build-pdfs.sh
├── build-pdfs.bat
├── start-local.sh
└── start-local.bat
~~~

- Runtime: static HTML/CSS served by Nginx.
- Local preview: port 9180 through the repository start scripts.
- PDF build: Markdown → DocWizard-Pro/Pandoc → PDF.
- Deployment: <code>tools/Scripts/deploy_testing.bat</code> on Windows, then
  <code>tools/Scripts/Startup/quantum_deploy_script.sh</code> on the server.
- Public web root: <code>index.html</code>, <code>LICENSE</code>,
  <code>assets/</code>, and <code>papers/</code>. <code>Documentation/</code> is not
  deployed publicly.

## Editing rules

- Prefer technical accuracy and explicit evidence status over promotional
  language.
- Use FIPS 205 terminology <strong>SLH-DSA</strong>; SPHINCS+ is only design
  lineage.
- Do not invent cryptographic constructions, parameter security, Noise
  patterns, test vectors, benchmarks, or audit results.
- Do not claim that post-quantum private payments, RingCT, STARK-based
  hash-signature aggregation, private note retrieval, transaction-origin
  anonymity, or GHOSTDAG ordering are new; the active feasibility paper owns
  the current prior-work boundary.
- Distinguish requirements, selected standards, candidates, open gates, and
  verified results.
- A generic STARK, lattice commitment, or PQ primitive does not establish
  composed protocol security.
- Keep HTML semantic, responsive, accessible, and JavaScript-free unless a
  documented requirement justifies JavaScript.
- Use external stylesheets; do not add page-specific inline style blocks.
- Update <code>Documentation/ReleaseNotes.md</code> and
  <code>Documentation/ProjectStructure.md</code> when structure or durable
  behavior changes.

## Validation

For documentation changes:

1. run the audit gate required by <code>AGENTS.md</code>;
2. parse Markdown with Pandoc;
3. parse or validate HTML and verify local links/assets;
4. rebuild every active-paper PDF;
5. review public claims across README, landing page, papers, and research
   briefs;
6. run <code>git diff --check</code>.
