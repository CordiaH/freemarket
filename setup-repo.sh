#!/usr/bin/env bash
# Fetch the license texts from their canonical sources.
#
# Deliberately downloaded rather than pasted: the AGPL is 600+ lines of
# operative legal text, and a transcription typo in a license is a genuine
# problem rather than a cosmetic one. Always take it from gnu.org.
set -euo pipefail

echo "Fetching AGPL-3.0 for Freemarket..."
curl -fsSL https://www.gnu.org/licenses/agpl-3.0.txt -o LICENSE

# Sanity check: the real text ends with the network-interaction section.
grep -q "Remote Network Interaction" LICENSE \
  || { echo "ERROR: downloaded file does not look like the AGPL"; exit 1; }

wc -l LICENSE
echo "Done. Now add SPDX headers to source files:"
echo '  // SPDX-License-Identifier: AGPL-3.0-or-later'
