#!/usr/bin/env sh
# Pre-deploy check. Run from the repo root: ./check.sh
#
# GitHub Pages serves case-sensitive paths; Windows and macOS do not. A path
# that resolves locally can 404 once deployed, and the only way to find out by
# hand is to click every link. This walks them instead.

set -u
fail=0
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

html=$(find . -name '*.html' -not -path './.git/*' | sort)

# ---- 1. every referenced local file resolves -------------------------------
# Paths in work/*.html are relative to that folder, so resolve each reference
# against the directory of the file it appears in.
: > "$tmp/missing"
for f in $html; do
  dir=$(dirname "$f")
  grep -ohE '(src|href)="[^"#:]+\.(jpg|jpeg|png|svg|pdf|css|js|xml|txt)"' "$f" 2>/dev/null \
    | sed -E 's/.*="([^"]+)"/\1/' | sort -u | while read -r ref; do
        case "$ref" in
          /*) path=".$ref" ;;
          *)  path="$dir/$ref" ;;
        esac
        [ -f "$path" ] || printf '%s -> %s\n' "$f" "$ref" >> "$tmp/missing"
      done
done

printf '== unresolved file references ==\n'
if [ -s "$tmp/missing" ]; then sort -u "$tmp/missing" | sed 's/^/  /'; fail=1; else printf '  none\n'; fi

# ---- 2. dead or placeholder links -----------------------------------------
printf '\n== placeholder links ==\n'
if grep -n 'href="#"\|href=""\|href="https://github.com/"' $html > "$tmp/ph" 2>/dev/null; then
  sed 's/^/  /' "$tmp/ph"; fail=1
else
  printf '  none\n'
fi

# ---- 3. images missing alt text --------------------------------------------
# Collapse newlines first, then split on '<', so a tag spread over several
# source lines still lands on one line and its alt= is visible to grep.
printf '\n== images without alt text ==\n'
: > "$tmp/noalt"
for f in $html; do
  tr '\n' ' ' < "$f" | tr '<' '\n' | grep '^img ' | grep -v 'alt=' \
    | cut -c1-90 | sed "s|^|  $f: <|" >> "$tmp/noalt"
done
if [ -s "$tmp/noalt" ]; then cat "$tmp/noalt"; fail=1; else printf '  none\n'; fi

# ---- 4. social preview image ----------------------------------------------
printf '\n== social preview image ==\n'
if [ -f assets/og-image.jpg ]; then
  printf '  present\n'
else
  printf '  MISSING assets/og-image.jpg (referenced by the absolute og:image URL)\n'; fail=1
fi

# ---- 5. inventory ----------------------------------------------------------
printf '\n== inventory ==\n'
printf '  title cards:  %s\n' "$(grep -c 'data-studio=' index.html)"
printf '  case studies: %s\n' "$(printf '%s\n' $html | grep -c '^\./work/')"
printf '  images:       %s\n' "$(find assets -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.svg' \) | wc -l | tr -d ' ')"
printf '  total size:   %s\n' "$(du -sh . 2>/dev/null | cut -f1)"

printf '\n'
if [ "$fail" -eq 0 ]; then printf 'OK - safe to push.\n'; else printf 'Problems above. Fix before pushing.\n'; fi
exit "$fail"
