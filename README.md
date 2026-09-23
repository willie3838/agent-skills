# agent-skills

A portable, cross-platform library of curated AI agent skills. This repository acts as a centralized directory to easily sync, install, and port agent skills across any environment or AI agent harness—including **Google Jetski / Gemini CLI**, **Google Agents CLI (ADK)**, **Anthropic Claude Code**, **Cursor**, **OpenCode**, and other LLM agent frameworks supporting the `SKILL.md` format.

---

## 📦 Skills Directory

### Core Engineering & TDD Lifecycle (Superpowers)
| Skill | Description | Key Capabilities |
| :--- | :--- | :--- |
| [`brainstorming`](skills/brainstorming/) | Socratic design exploration before code. | Interrogates requirements, explores edge cases, and aligns architecture before touching files. |
| [`writing-plans`](skills/writing-plans/) | Multi-step task planner. | Transforms specs into granular bite-sized tasks with explicit verification gates and file touchpoints. |
| [`executing-plans`](skills/executing-plans/) | Inline plan executor. | Executes tasks sequentially in the current session with verification checkpoints and zero stalling. |
| [`subagent-driven-development`](skills/subagent-driven-development/) | Parallel subagent orchestrator. | Dispatches fresh implementer and reviewer subagents per task with spec compliance & code quality reviews. |
| [`dispatching-parallel-agents`](skills/dispatching-parallel-agents/) | Multi-agent concurrency. | Spawns parallel agents for independent, non-overlapping tasks without shared state. |
| [`test-driven-development`](skills/test-driven-development/) | Strict test-first engineering. | Enforces RED-GREEN-REFACTOR cycles; requires failing tests before touching production code. |
| [`systematic-debugging`](skills/systematic-debugging/) | 4-phase root cause analysis. | Investigate $\rightarrow$ hypothesize $\rightarrow$ isolate $\rightarrow$ verify; eliminates guessing and thrashing. |
| [`verification-before-completion`](skills/verification-before-completion/) | "Evidence before assertions". | Strictly prevents claiming work is done or fixed without executing test commands and inspecting output. |
| [`using-git-worktrees`](skills/using-git-worktrees/) | Workspace isolation. | Spawns isolated Git worktrees for feature branches to keep the main working tree clean. |
| [`finishing-a-development-branch`](skills/finishing-a-development-branch/) | Branch integration checklist. | Guides decisions on PR creation, squashing, rebasing, merging, and worktree teardown. |
| [`requesting-code-review`](skills/requesting-code-review/) | Pre-PR self-audit. | Review checklist to verify changes against specs and quality guidelines before submission. |
| [`receiving-code-review`](skills/receiving-code-review/) | Objective feedback evaluator. | Prevents blind sycophantic agreement; verifies reviewer feedback technically before applying. |

### Productivity & Meta Skills
| Skill | Description | Key Capabilities |
| :--- | :--- | :--- |
| [`skill-creator`](skills/skill-creator/) | Create and benchmark agent skills. | Quantitative test cases (`evals/evals.json`), blind A/B comparator agents, browser eval viewer, and trigger auto-optimization. |
| [`explain`](skills/explain/) | First-principles, zero-jargon explainer. | Explains why a concept matters, what existed before, and how it transforms operations, using everyday analogies for non-experts. |
| [`i-have-adhd`](skills/i-have-adhd/) | Cognitive ergonomics & zero fluff. | Lead with immediate action, numbered steps, restate state across turns, cap lists at 5 items, concrete time estimates, zero pleasantries. |

---

## 🚀 Quick Install & Porting

Clone this repository to your machine or server:

```bash
git clone git@github.com:willie3838/agent-skills.git ~/Playground/agent-skills
cd ~/Playground/agent-skills
```

### Option A: Using the `install.sh` Helper

The included `install.sh` script automates installing any or all skills to your desired agent config directory:

```bash
# List all available skills
./install.sh --list

# Install all skills into default Gemini / Jetski directory (~/.gemini/config/skills/)
./install.sh

# Symlink skills for live local updates without recopying
./install.sh --symlink

# Install only specific skills
./install.sh test-driven-development systematic-debugging i-have-adhd

# Install into Google Agents CLI directory (~/.agents/skills/)
./install.sh --agents

# Install into Anthropic Claude Code directory (~/.claude/skills/)
./install.sh --claude

# Install into a custom directory
./install.sh --target /path/to/custom/skills
```

### Option B: Manual Installation

#### 1. Google Jetski / Gemini CLI
Copy or symlink desired skills into `~/.gemini/config/skills/`:

```bash
mkdir -p ~/.gemini/config/skills
cp -r skills/* ~/.gemini/config/skills/
```

To enable the `/i-have-adhd` custom command in Gemini CLI:
```bash
mkdir -p ~/.gemini/commands
cp skills/i-have-adhd/agents/gemini.toml ~/.gemini/commands/i-have-adhd.toml
```

#### 2. Google Agents CLI (ADK)
```bash
mkdir -p ~/.agents/skills
cp -r skills/* ~/.agents/skills/
```

#### 3. Anthropic Claude Code
```bash
mkdir -p ~/.claude/skills
cp -r skills/* ~/.claude/skills/
```

---

## 🛠️ Adding New Skills

To add a new skill to this repository:

1. Create a directory under `skills/<skill-name>/`:
   ```bash
   mkdir -p skills/my-new-skill
   ```
2. Add a `SKILL.md` file with standard YAML frontmatter:
   ```markdown
   ---
   name: my-new-skill
   description: Concise explanation of what the skill does and specific triggers for when to invoke it.
   ---

   # My New Skill

   Instructions for the agent...
   ```
3. Commit and push:
   ```bash
   git add skills/my-new-skill
   git commit -m "feat: add my-new-skill"
   git push origin main
   ```

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE).
Individual skills originate from and reference their respective open-source foundations:
- Superpowers skills from [Jesse Vincent / `obra/superpowers`](https://github.com/obra/superpowers) (MIT License)
- ADHD ergonomics from [`ayghri/i-have-adhd`](https://github.com/ayghri/i-have-adhd) (MIT License)
- Anthropic Reference Skill suite for `skill-creator` (Apache 2.0 / MIT)
