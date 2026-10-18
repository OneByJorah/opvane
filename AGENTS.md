# AGENTS.md

Instructions for AI coding agents (OpenCode, Freebuff/Codebuff, Hermes workers, and others). Humans: see [CONTRIBUTING.md](CONTRIBUTING.md).

## Project

- **What it is:** A self-hosted AI agent operations dashboard (real-time fleet status, task board, schedule view, and content browser).
- **Stack:** Python 3.11+ stdlib HTTP server, vanilla HTML/JS/CSS frontend, Docker Compose deployment.
- **Run locally:** `cp .env.example .env && docker compose up -d --build`, then open `http://127.0.0.1:51763`.
- **Health check:** `GET /api/health` must return 200.

## Commands

| Task | Command |
| --- | --- |
| Build image | `docker build .` |
| Start / stop | `docker compose up -d --build` / `docker compose down -v` |
| Run from source | `pip install -r requirements.txt && python3 server.py` |
| Lint Dockerfile | `hadolint Dockerfile` |
| Lint Python | `flake8 scripts/ server.py --max-line-length=120 --ignore=E501,W503` |
| Scan for secrets | `gitleaks detect --redact --no-banner` |
| Capture screenshots | start the stack, then `BASE_URL=http://127.0.0.1:51763 node scripts/screenshots.mjs` |

## Rules

1. Work on a branch named `agent/<task>`. Never push to `main`. Open a pull request.
2. Commit messages use Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
3. Never read, print, or commit secrets. Do not open `.env` files. Use `.env.example` for documentation.
4. Bind services to `127.0.0.1` on the host. Inside the container, bind to `0.0.0.0`.
5. Screenshots use demo or empty data only. No real hostnames, IPs, usernames, emails, school or client names.
6. Do not invent facts. If a command, flag, or API is unverified, check the official docs or ask.
7. Verify before reporting done: run the build, run the tests, open the page. Paste real output.
8. Ask before: creating releases or tags, changing repo visibility, deleting files outside your task, or adding dependencies with a network-heavy footprint.

## Style

- Match the existing code style. `.editorconfig` is authoritative.
- README voice: calm, direct, specific. No hype, no filler.
- Design language for any UI: background `#0a0a09`, accent `#FFB300`, font JetBrains Mono.

## Skills

Reusable procedures live in `.agents/skills/`: `repo-polish`, `readme-writer`, `dockerize`, `screenshot-capture`, `security-scrub`, `pr-workflow`, `release-checklist`. Load the one that matches your task.
