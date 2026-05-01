# Secure Development Access Layer

## Secure Development Access Layer

The workspace needs a controlled local-only development access layer for secrets and operational credentials.

Purpose: enable automation during setup without turning temporary convenience into permanent exposure.

Rules:

- temporary development secrets may be made conveniently available to AI-driven setup only through an explicitly controlled local-only mechanism;
- secrets must not be committed to GitHub;
- secrets must not be placed in tracked documentation;
- secrets must not be read by Code Agent unless the task explicitly names the relevant local file or value;
- local-only material remains outside GitHub source of truth.

After launch or infrastructure stabilization, every product must have a mandatory credential rotation task:

1. replace temporary credentials;
2. remove exposed development access;
3. verify Git history for accidental secret exposure;
4. update production secrets securely;
5. record the stable production access pattern in the product repository knowledge without storing secret values.

## Stage 4 - Secure Development Access Layer

Goal: make temporary development access convenient enough for automation while keeping secrets out of GitHub and tracked documentation.

Why it matters: setup work often needs credentials, but accidental permanence of temporary access is a serious operational risk.

Key deliverables:

- local-only access pattern;
- rules for when Code Agent may read local secret material;
- temporary credential handling checklist;
- mandatory post-launch credential rotation checklist;
- Git history verification step.

Definition of done:

- AI-driven setup can use explicitly approved local-only access;
- no secrets are committed or copied into tracked docs;
- every launch or stabilization includes credential rotation and access cleanup.

Current status: Pending.
