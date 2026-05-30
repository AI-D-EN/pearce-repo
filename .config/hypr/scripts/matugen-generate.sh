matugen image "$WALL" \
    -m dark \
    -t scheme-vibrant \
    --prefer saturation \
    -q

# Wait until ALL important files exist and stabilize

sleep 2

while pgrep -x matugen >/dev/null; do
    sleep 0.2
done

sleep 1

~/.config/hypr/scripts/reload-theme.sh
