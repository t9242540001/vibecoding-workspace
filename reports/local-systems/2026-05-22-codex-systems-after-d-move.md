# Local Codex Systems Health Audit After D Move

Date: 2026-05-22

This diagnostic audit was run after moving the Ubuntu WSL distro to `D:\Vibecoding\WSL\Ubuntu`. It used only safe local inspection commands. No deploy, server, production, secret, database, nginx, PM2, SSH, credential, or product-code files were intentionally modified.

## Summary

- WSL is operational.
- Windows wrappers `vcw` and `yura` are callable and return repo status.
- Main repo `vibecoding-workspace` is clean and aligned with local `origin/main`.
- Product repo `yurassistent` is clean and aligned with local `origin/main`.
- WSL registry metadata on Windows shows the Ubuntu distro base path at `D:\Vibecoding\WSL\Ubuntu`.
- The WSL ext4 virtual disk file was found at `D:\Vibecoding\WSL\Ubuntu\ext4.vhdx`.
- No automatic move is recommended from Codex during this diagnostic batch.

## 1. WSL/User State

Command:

```text
wsl -e bash -lc 'set -u; echo USER=$(whoami); echo HOME=$HOME; echo PWD=$(pwd); sed -n "1,80p" /etc/wsl.conf 2>/dev/null || true'
```

Observed:

```text
USER=redmi
HOME=/home/redmi
PWD=/mnt/c/Users/topan/OneDrive/文档/New project
[user]
default=redmi
```

Notes:

- Current Linux user: `redmi`.
- HOME path: `/home/redmi`.
- Current Windows-launched WSL working directory: `/mnt/c/Users/topan/OneDrive/文档/New project`.
- Current repo root for the main workspace repo: `/home/redmi/codex-runners/vibecoding-workspace`.
- `/etc/wsl.conf` sets `[user] default=redmi`: yes.

## 2. Disk/Storage State

### WSL root disk

Command:

```text
wsl -e df -h /
```

Output:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd       1007G  4.7G  952G   1% /
```

### Mount info

Command:

```text
wsl -e findmnt /
```

Output:

```text
TARGET SOURCE   FSTYPE OPTIONS
/      /dev/sdd ext4   rw,relatime,discard,errors=remount-ro,data=ordered
```

Inside WSL, the root filesystem is visible as ext4 on `/dev/sdd`. Inside WSL alone, this does not expose the Windows host path of the VHDX file.

### Windows WSL location

Command:

```text
Get-ChildItem 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss' |
  ForEach-Object { Get-ItemProperty $_.PsPath | Select-Object DistributionName,BasePath,DefaultUid,State,Version }
```

Observed:

```text
DistributionName : Ubuntu
BasePath         : D:\Vibecoding\WSL\Ubuntu
DefaultUid       : 0
State            : 1
Version          : 2
```

Command:

```text
Get-ChildItem -Force 'D:\Vibecoding\WSL\Ubuntu'
```

Observed:

```text
ext4.vhdx     5,212,471,296 bytes
shortcut.ico  37,207 bytes
```

Conclusion: from Windows-side registry and filesystem metadata, the Ubuntu WSL virtual disk is physically under `D:\Vibecoding\WSL\Ubuntu`. This is more conclusive than the view from inside WSL, where only `/dev/sdd` is visible.

### Workspace sizes

Commands:

```text
wsl -e du -sh /home/redmi/codex-runners
wsl -e du -sh /home/redmi/codex-runners/vibecoding-workspace /home/redmi/codex-runners/yurassistent
```

Output:

```text
8.1M	/home/redmi/codex-runners
3.5M	/home/redmi/codex-runners/vibecoding-workspace
4.6M	/home/redmi/codex-runners/yurassistent
```

Additional Windows-side observations:

```text
C:\Users\topan\OneDrive\文档\New project  513.29 MB
C:\Users\topan\.codex                     311.09 MB
C:\Users\topan\bin                        small wrapper scripts
```

These Windows-side Codex/Desktop support locations still exist on C. The active WSL repos and WSL virtual disk are on D through the WSL VHDX. Moving Codex Desktop application data or `%USERPROFILE%\.codex` should not be done automatically by Codex in this diagnostic batch because it can break the desktop app's expected paths and credentials.

## 3. CLI/Runner State

### `vcw status`

Command:

```text
vcw status
```

Output:

```text
## main...origin/main
51859e1 [batch:batch-2026-05-21-auto-checkpoint-runner-encoding] Fix
7510dd3 [batch:batch-2026-05-21-auto-checkpoint-runner] Add
52da38c standards: batch-execution-standard v1.4 → v1.5 (E integration 2/3)
57a5e8a [batch:batch-2026-05-21-auto-checkpoint-smoke-test] Auto checkpoint after Codex batch
86a3a7d fix(skills): repair duplicate line in prompt-writing-standard v3.9
```

Result: works.

### `yura status`

Command:

```text
yura status
```

Output:

```text
## main...origin/main
dc4cd7f [batch:batch-2026-05-22-yurassistent-frontend-audit-preflight] Auto checkpoint after YurAssistent Codex batch
9da0066 Harden legal claim extraction privacy
4eab9f5 Add risky legal claim extraction metadata
59ff561 Add legal source freshness metadata
4650e91 Fix gosposhlina false freshness
```

Result: works.

### Windows wrappers

`C:\Users\topan\bin\vcw.cmd`:

```cmd
@echo off
wsl -u redmi python3 /home/redmi/codex-runners/vcw.py %*
```

`C:\Users\topan\bin\yura.cmd`:

```cmd
@echo off
wsl -u redmi python3 /home/redmi/codex-runners/yura.py %*
```

These wrappers are small C-side launchers. They intentionally point into WSL paths.

### Runner files

Command:

```text
wsl -e ls -l /home/redmi/codex-runners/run-vcw-codex-hardened.sh /home/redmi/codex-runners/run-vcw-batch-auto-checkpoint.sh /home/redmi/codex-runners/yura-codex-hardened.sh /home/redmi/codex-runners/yura-batch-auto-checkpoint.sh /home/redmi/codex-runners/yura-trusted-checkpoint.sh /home/redmi/codex-runners/vcw.py /home/redmi/codex-runners/yura.py
```

Output:

```text
-rwxr-xr-x 1 redmi redmi 1287 May 21 14:24 /home/redmi/codex-runners/run-vcw-batch-auto-checkpoint.sh
-rwxr-xr-x 1 redmi redmi 1611 May 21 13:18 /home/redmi/codex-runners/run-vcw-codex-hardened.sh
-rwxr-xr-x 1 redmi redmi 3556 May 21 19:20 /home/redmi/codex-runners/vcw.py
-rwxr-xr-x 1 redmi redmi 1458 May 22 12:51 /home/redmi/codex-runners/yura-batch-auto-checkpoint.sh
-rwxr-xr-x 1 redmi redmi 1331 May 22 12:51 /home/redmi/codex-runners/yura-codex-hardened.sh
-rwxr-xr-x 1 redmi redmi 1905 May 22 12:51 /home/redmi/codex-runners/yura-trusted-checkpoint.sh
-rwxr-xr-x 1 redmi redmi 3449 May 22 12:51 /home/redmi/codex-runners/yura.py
```

Result: all requested runner files exist and are executable.

## 4. Git State

### `vibecoding-workspace`

Command:

```text
wsl -e git -C /home/redmi/codex-runners/vibecoding-workspace status --short --branch
```

Output before this report was added:

```text
## main...origin/main
```

Latest 5 commits:

```text
51859e1 (HEAD -> main, origin/main, origin/HEAD) [batch:batch-2026-05-21-auto-checkpoint-runner-encoding] Fix
7510dd3 [batch:batch-2026-05-21-auto-checkpoint-runner] Add
52da38c standards: batch-execution-standard v1.4 → v1.5 (E integration 2/3)
57a5e8a [batch:batch-2026-05-21-auto-checkpoint-smoke-test] Auto checkpoint after Codex batch
86a3a7d fix(skills): repair duplicate line in prompt-writing-standard v3.9
```

Alignment command:

```text
wsl -e git -C /home/redmi/codex-runners/vibecoding-workspace rev-list --left-right --count HEAD...origin/main
```

Output:

```text
0	0
```

Result: clean and aligned with local `origin/main` before adding this report. After this report is added, the only expected local change is this report file.

### `yurassistent`

Command:

```text
wsl -e git -C /home/redmi/codex-runners/yurassistent status --short --branch
```

Output:

```text
## main...origin/main
```

Latest 5 commits:

```text
dc4cd7f (HEAD -> main, origin/main, origin/HEAD) [batch:batch-2026-05-22-yurassistent-frontend-audit-preflight] Auto checkpoint after YurAssistent Codex batch
9da0066 Harden legal claim extraction privacy
4eab9f5 Add risky legal claim extraction metadata
59ff561 Add legal source freshness metadata
4650e91 Fix gosposhlina false freshness
```

Alignment command:

```text
wsl -e git -C /home/redmi/codex-runners/yurassistent rev-list --left-right --count HEAD...origin/main
```

Output:

```text
0	0
```

Result: clean and aligned with local `origin/main`.

## 5. Safety State

- No product code was modified.
- No deploy, server, production, database, nginx, PM2, SSH, credential, or secret files were intentionally modified.
- No secret values were printed.
- No `.env` contents were read or printed.
- No destructive commands were run.
- No deployment commands were run.
- No dependency installation was run.
- No file move or delete operation was run.

Because both repos were clean before report creation, git did not show any modified secret, deploy, server, database, nginx, PM2, SSH, credential, or product files.

## 6. D-Move Conclusion

The working Codex system is operational after the move:

- WSL starts correctly.
- The default Linux user is `redmi`.
- The `vcw` and `yura` wrappers work from Windows.
- The WSL runner files exist and are executable.
- Both local repos are clean and aligned with local `origin/main`.
- The WSL VHDX is under `D:\Vibecoding\WSL\Ubuntu`.

Files that still exist on C:

- `C:\Users\topan\bin` contains tiny wrapper scripts and should stay there unless PATH is reworked.
- `C:\Users\topan\.codex` exists and was measured at about 311 MB.
- `C:\Users\topan\OneDrive\文档\New project` exists and was measured at about 513 MB. This is the current Codex Desktop workspace folder, not the WSL repo root.

No large WSL working repo files appear to need moving to D, because the active WSL repos live inside `/home/redmi/codex-runners`, and the Ubuntu VHDX is physically on D. Moving Codex Desktop app data, `.codex`, credentials, or profile-integrated folders automatically is not recommended from this diagnostic run because those paths may be assumed by the desktop app and authentication/session storage.

Recommended next safe action:

1. Continue with the next frontend audit batch.
2. If C pressure becomes urgent, manually plan a separate Codex Desktop storage audit for `C:\Users\topan\.codex` and `C:\Users\topan\OneDrive\文档\New project`, with backups and explicit approval before any move.

## Final Check

`git diff --check` must be run after this file is created.
