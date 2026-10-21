#!/bin/sh
# Prints the current MPRIS track for waybar (requires: playerctl).

STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ]; then
    exit 0
fi

TITLE=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)

case "$STATUS" in
    Playing) ICON="▶" ;;
    Paused)  ICON="⏸" ;;
    *)       ICON="•" ;;
esac

if [ -n "$ARTIST" ]; then
    TRACK="$ARTIST – $TITLE"
else
    TRACK="$TITLE"
fi

if [ -z "$TRACK" ] || [ "$TRACK" = "–" ]; then
    exit 0
fi

printf '%s %s\n' "$ICON" "$TRACK"
