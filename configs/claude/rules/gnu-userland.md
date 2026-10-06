# Shell userland is GNU, not BSD (even on macOS)

On my Macs, the shell PATH (set in `~/.zprofile`, which `~/.zshenv` also
sources) puts Homebrew's GNU tools (`$(brew --prefix)/opt/*/libexec/gnubin`)
ahead of the macOS BSD tools. So even when the platform is darwin, the
unprefixed commands `sed`, `awk` (gawk), `find`, `xargs`, `grep`, `tar`,
`make`, `date`, `stat`, `readlink`, `cp`, `mv`, `ls`, `du`, `base64` and the
rest of coreutils are the GNU versions. On Linux they are GNU anyway.

- Use GNU syntax and flags: `sed -i 's/a/b/' file` (never `sed -i '' ...`),
  `date -d '1 day ago'` (not `date -v-1d`), `stat -c %Y` (not `stat -f %m`),
  `readlink -f`, `sed -E`/`-r`, `grep -P`, `xargs -r`, `find -printf`.
- Don't add BSD/GNU portability workarounds or `gsed`/`gdate` prefixes unless
  the script is meant to run elsewhere.
- Exception: scripts meant for other machines, or ones run by launchd, cron or
  other non-zsh contexts, may not get this PATH. For those, prefer portable
  POSIX syntax or call `/usr/bin/<tool>` or the gnubin path explicitly.
- If unsure, check with `<tool> --version` instead of guessing.
