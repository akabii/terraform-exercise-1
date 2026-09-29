# Terraform Practical — Exercise

This repo is a **timed, hands-on Terraform exercise**. It contains a deliberately broken
Terraform repo (`net-baseline/`) that you have to fix, live, exactly like a real piece of work.

There is **no solution in this repo on purpose** — you clone it and work through it yourself.

---

## 1. What the exercise is (the brief)

> "Here's a repository for a baseline network build. The pipeline is red and a colleague
> has flagged that the code isn't up to standard. You've got **30 minutes**."
>
> - Get the pipeline **green**.
> - Fix anything you think is wrong.
> - Raise a **merge request** with your changes.

You will **not** have live AWS credentials, so `terraform plan` against the real API won't
work. Focus on **`init`, `fmt` and `validate`**, and *say out loud* what you'd expect a real
`plan` to show.

There's also a **10-minute follow-on**: you'll be shown a `terraform plan` for a *production*
change and asked *"Is this safe to apply?"* — talk through your reasoning.

### The rules on the day
- **Time:** 30 minutes. You'll be told at 15, 25 and 28 minutes.
- **Tools:** Terraform CLI + Git. **No** live cloud credentials.
- **Narrate:** talk through your reasoning the whole time — *silence scores nothing*.
- **Deliver:** a feature branch, small meaningful commits, and a merge request with a real description.

---

## 2. What you need installed (one-time setup)

You need **two** tools: **Git** and **Terraform**. Here's the idiot-proof way on Windows.

### 2a. Install Git (if `git --version` fails)
Download and run the installer: <https://git-scm.com/download/win>
Accept all the defaults. Done.

### 2b. Install Terraform (the easy way)
Open **PowerShell** and run:

```powershell
winget install HashiCorp.Terraform
```

Then **close and reopen PowerShell** so it picks up the new command.

> No `winget`? Manual way: download the Windows **AMD64** zip from
> <https://developer.hashicorp.com/terraform/install>, unzip it, put `terraform.exe`
> in a folder like `C:\terraform`, then add that folder to your PATH.

### 2c. Check both tools work
```powershell
git --version
terraform version
```
Both should print a version number. If they do, you're ready.

---

## 3. Get the exercise onto your machine

Clone it, then move into the folder:

```powershell
git clone https://github.com/akabii/terraform-exercise-1.git
cd terraform-exercise-1
```

The exercise lives in the **`net-baseline/`** folder.

---

## 4. How to actually do the exercise (step by step)

Do these in order. **Narrate every step out loud** — practise talking as you type.

### Step 1 — Look before you touch
```powershell
cd net-baseline\terraform
```
Read every file. Say what each one does. Note anything that smells wrong.

### Step 2 — Get a clean baseline (prove the pipeline is red)
```powershell
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```
- `init -backend=false` downloads the AWS provider **without** needing a real backend/credentials.
- `fmt -check` tells you if formatting is off (it exits non-zero if so).
- `validate` checks the config is valid — **this is where the pipeline breaks.**

Say out loud what fails and *why*. That's the "pipeline is red" moment.

### Step 3 — Make a feature branch (never work on main)
```powershell
git checkout -b fix/net-baseline-pipeline
```

### Step 4 — Fix things, committing in small logical chunks
Fix one problem, then commit it with a clear message, e.g.:
```powershell
git add terraform/main.tf
git commit -m "fix: use splat for private subnet ids output so validate passes"
```
Repeat for each fix. Small commits = easy to explain.

### Step 5 — Prove it's green
```powershell
terraform fmt -recursive
terraform validate
```
`validate` should now say **"Success!"** and `fmt` should make no changes.

### Step 6 — Push and raise a merge/pull request
```powershell
git push -u origin fix/net-baseline-pipeline
```
Then open a PR/MR with a **real description**: what was broken, what you changed,
and what you'd still do with more time.

---

## 5. What you're being marked on

You do **not** need to finish everything. It's about your **method**:

- Do you run `init` / `validate` **before** changing things? (clean baseline first)
- Feature branch + small meaningful commits + a real MR description.
- `fmt` and `validate` passing.
- Your **security eye** — spotting anything you wouldn't show a security reviewer.
- Sensible Terraform structure, and being able to **explain every choice**.

---

## 6. Golden rules for the day

- **Talk constantly.** Explain what you're reading, thinking, and doing.
- **Baseline first.** Run `init`/`validate` before editing anything.
- **Security is the hidden test.** Hunt for secrets and open network rules.
- **Small commits, clear messages.** Each commit should tell a story.
- **Manage the clock.** Don't rabbit-hole; a partial-but-clean answer beats a rushed mess.
- **It's fine not to finish.** Method beats completion.

Good luck — think out loud and back yourself.
