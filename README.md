# agent-skills

A portable, cross-platform library of curated AI agent skills. This repository acts as a centralized directory to easily sync, install, and port agent skills across any environment or AI agent harness—including **Google Jetski / Gemini CLI**, **Google Agents CLI (ADK)**, **Anthropic Claude Code**, **Cursor**, **OpenCode**, and other LLM agent frameworks supporting the `SKILL.md` format.

---

## 📦 Skills Directory

| Skill | Description | Key Capabilities |
| :--- | :--- | :--- |
| [`skill-creator`](skills/skill-creator/) | Create, test, evaluate, and iteratively optimize agent skills. | Quantitative test cases (`evals/evals.json`), blind A/B comparator agents, browser eval viewer, trigger description auto-tuning. |
| [`i-have-adhd`](skills/i-have-adhd/) | Format agent output specifically for ADHD cognitive ergonomics and zero executive friction. | Lead with immediate action, numbered steps, restate state across turns, cap lists at 5 items, concrete time estimates, zero conversational filler. |

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
./install.sh i-have-adhd

# Install into Google Agents CLI directory (~/.agents/skills/)
./install.sh --agents

# Install into Anthropic Claude Code directory (~/.claude/skills/)
./install.sh --claude

# Install into a custom directory
./install.sh --target /path/to/custom/skills
```

### Option B: Manual Installation

#### 1. Google Jetski / Gemini CLI
Copy or symlink the desired skill into `~/.gemini/config/skills/`:

```bash
mkdir -p ~/.gemini/config/skills
cp -r skills/i-have-adhd ~/.gemini/config/skills/
cp -r skills/skill-creator ~/.gemini/config/skills/
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
3. (Optional) Add bundled resources:
   - `scripts/`: Executable scripts for repetitive or deterministic tasks.
   - `references/`: Reference documentation loaded on demand.
   - `assets/`: Templates, schemas, or static files.
   - `agents/`: Platform-specific configurations (`gemini.toml`, `openai.yaml`).
4. Commit and push:
   ```bash
   git add skills/my-new-skill
   git commit -m "feat: add my-new-skill"
   git push origin main
   ```

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE).
Individual skills originate from and reference their respective open-source foundations (Anthropic reference skills, [`ayghri/i-have-adhd`](https://github.com/ayghri/i-have-adhd)).
