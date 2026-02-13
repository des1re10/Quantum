# AGENTS.md

## Repo overview
- Repo: `Quantum`
- App registry entries: quantum
- quantum: Quantum - Post-Quantum Cryptography Research - static documentation site; domain quantum.phexora.ai; backend none (static site); frontend none; redis n/a; status none; enabled
- Registry source: `Libraries/Python/ApplicationRegistry.py` (ports, domains, scripts, Redis DBs)

## Quick start
- Read: `README.md`, `CLAUDE.md`, `Documentation/`
- Prefer startup scripts in `tools/Scripts/Startup`: `tools/Scripts/Startup/run_quantum.sh`
- Local start scripts in repo root: `start-local.bat`, `start-local.sh`

## Setup
- No dependency manifests detected; treat as docs/assets unless README says otherwise

## Commands
- Dev: `tools/Scripts/Startup/run_quantum.sh`, `start-local.bat`, `start-local.sh`

## Notes
- Deploy scripts: `tools/Scripts/Startup/quantum_deploy_script.sh`

## Fail-Fast Policy (Mandatory)
- For all Python changes, follow: `/mnt/d/workspace/VisualStudio/Libraries/Scripts/audit_prompts/03_defensive_programming_violations.md`.
- Do not add defensive fallbacks for required dependencies/fields.
- Do not use `hasattr()`/`getattr(..., default)` on required code paths.
- Do not use silent fallback patterns like `x = x or []`, `dict.get("key", default)` for required fields, or broad `except: return None`.
- Use direct access for required values and raise explicit exceptions when invariants are violated.
- Only keep fallback behavior when it is truly required by external systems/data quality and document it with `# REQUIRED FALLBACK:` including:
- Why it is required
- Evidence/example that triggers it
- What breaks if removed