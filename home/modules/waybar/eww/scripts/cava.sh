#!/usr/bin/env bash
# ---------------------------------------------------------------
# Streams live audio bar values (0-100) as JSON arrays, one per line,
# consumed by eww's `deflisten cava-data`.
#
# Things you'll likely want to tweak:
#   BARS   -- how many bars in the row (matches cava-row's :for loop)
#   ascii_max_range -- resolution of each bar's value (higher = smoother)
#   noise_reduction  -- higher = calmer/less jumpy bars
# ---------------------------------------------------------------
BARS=32

CONF=$(mktemp)
cat > "$CONF" <<EOF
[general]
bars = $BARS

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 100

[smoothing]
noise_reduction = 30
EOF

cava -p "$CONF" | while IFS=';' read -ra vals; do
  printf '%s\n' "${vals[@]}" | jq -R . | jq -sc 'map(tonumber)'
done

rm -f "$CONF"
