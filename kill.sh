while true; do
    echo "Killed TeleSeed"
    kill -9 $(pgrep telegram-cli)
    sleep 2000
done