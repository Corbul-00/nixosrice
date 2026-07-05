#!/usr/bin/env bash
player=$(playerctl -l 2>/dev/null | head -n1)

if [ -z "$player" ]; then
  jq -n '{title:"Nothing playing", artist:"", art:"", position:"0:00", length:"0:00"}'
  exit 0
fi

title=$(playerctl -p "$player" metadata title 2>/dev/null)
artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
art_url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)
art_path="${art_url#file://}"
[ -f "$art_path" ] || art_path=""

pos_s=$(playerctl -p "$player" position 2>/dev/null | cut -d. -f1)
len_us=$(playerctl -p "$player" metadata mpris:length 2>/dev/null)
len_s=$(( ${len_us:-0} / 1000000 ))

fmt() { printf '%d:%02d' $(( $1 / 60 )) $(( $1 % 60 )); }

jq -n \
  --arg title "${title:-Unknown}" \
  --arg artist "${artist:-Unknown}" \
  --arg art "$art_path" \
  --arg position "$(fmt "${pos_s:-0}")" \
  --arg length "$(fmt "${len_s:-0}")" \
  '{title:$title, artist:$artist, art:$art, position:$position, length:$length}'
