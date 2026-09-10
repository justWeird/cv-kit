#!/usr/bin/env bash
# Page-count tests. Ground truth comes from Spotlight for the two indexed
# fixtures, and from a generated PDF whose page count we control.
set -uo pipefail
cd "$(dirname "$0")/.."

pass=0; fail=0
check() { # check <label> <expected> <file>
  got=$(./bin/cv-pagecount "$3" 2>/dev/null || echo "ERROR")
  if [ "$got" = "$2" ]; then
    printf '  ok    %-46s %s pages\n' "$1" "$got"; pass=$((pass+1))
  else
    printf '  FAIL  %-46s expected %s, got %s\n' "$1" "$2" "$got"; fail=$((fail+1))
  fi
}

# Fixture: generate a PDF with a known page count, right now, so it is
# guaranteed NOT to be in the Spotlight index. This is the case that broke.
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
{ echo "# Page one"; echo; echo "text"; echo;
  for i in 1 2 3; do echo '<div style="break-before: page"></div>'; echo; echo "Page $((i+1))"; echo; done
} > "$tmp/four.md"
pandoc "$tmp/four.md" -o "$tmp/four.pdf" --pdf-engine=weasyprint 2>/dev/null

echo "Page-count tests"
check "freshly written PDF, not Spotlight-indexed" 4 "$tmp/four.pdf"
check "indexed 2-page CV"                          2 "../jd/Apeiron-Insight/CV.pdf"
check "indexed 8-page proposal"                    8 "../jd/AlfaCables/AlphaCables_proposal.pdf"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
