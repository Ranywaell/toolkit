# Visualization Toolkit

A small Bash toolkit that reads numeric columns from a CSV file and shows summary statistics or an ASCII bar chart. Access is controlled by a login and a per-user list of allowed files.

## Setup
```bash
cp scripts/users.txt.example scripts/users.txt    # then edit the usernames/passwords
bash run.sh
```

## Usage
After logging in, choose:

1. **Show Stats**: count, sum, mean, max and min of a numeric column
2. **Show Bar Chart**: one bar per row (label column + value column)
3. **Exit**

The CSV must have a header row. Column indexes start at 1. Example with `data/sample.csv` (`Name,Score`): stats on column `2`, bar chart with label column `1` and value column `2`.

## Access control
- `scripts/users.txt`: `username:password`, one per line (git-ignored, create it from the `.example` file).
- `scripts/access_control.txt`: `username:path/to/file.csv`, one line per allowed file. A user can only open files listed for them.

## Security notes
- Credentials and file names are compared as fixed strings (`grep -qxF`), so regex characters such as `.*` cannot bypass login or access checks.
- Passwords in `users.txt` are stored in plain text. This is acceptable for a classroom demo only; do not reuse real passwords.
