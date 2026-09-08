#!/usr/bin/env sh
# Pre-publish sanity check. Run from the repo root: ./check.sh
# Exits non-zero if anything is still a placeholder.

fail=0
say() { printf '%s\n' "$*"; }

say "── Placeholders ─────────────────────────────────────────────"
if grep -rn "TODO(ewing)" --include="*.html" . 2>/dev/null; then fail=1; fi
if grep -rln "draft-note" --include="*.html" . 2>/dev/null | grep -q .; then
  say ""
  say "Draft boxes still present in:"
  grep -rc "class=\"draft-note\"" --include="*.html" . 2>/dev/null | grep -v ':0$'
  fail=1
fi
if grep -rn "REPLACE-WITH-YOUR-DOMAIN" robots.txt sitemap.xml 2>/dev/null; then fail=1; fi
if grep -rn 'href="https://github.com/"' --include="*.html" . 2>/dev/null; then fail=1; fi

say ""
say "── Missing files referenced by the HTML ─────────────────────"
grep -rhoE '(src|href)="[^"#:]+\.(jpg|png|svg|pdf|css|js)"' --include="*.html" . 2>/dev/null \
  | sed -E 's/.*="([^"]+)"/\1/' | sort -u | while read -r ref; do
      case "$ref" in
        /*) p=".$ref" ;;
        ../*) p="$(printf '%s' "$ref" | sed 's|^\.\./||')" ;;
        *) p="$ref" ;;
      esac
      [ -f "$p" ] || say "  MISSING  $ref"
    done

say ""
say "── Counts ──────────────────────────────────────────────────"
say "  game cards:   $(grep -c 'class="card card--study"\|class="card"' index.html)"
say "  case studies: $(ls -1 work/*.html 2>/dev/null | wc -l | tr -d ' ')"
say "  images:       $(find assets -name '*.jpg' | wc -l | tr -d ' ')"
say "  total size:   $(du -sh . | cut -f1)"

say ""
if [ "$fail" -eq 0 ]; then
  say "✓ No placeholders found — ready to publish."
else
  say "✗ Placeholders above need attention before publishing."
  say "  See NOTES-FOR-EWING.md"
fi
exit "$fail"
