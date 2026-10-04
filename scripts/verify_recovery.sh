#!/bin/bash

TARGET_FILE="test-data/network_target.txt"

echo "======================================"
echo "POST-FIX RECOVERY VERIFICATION"
echo "======================================"
echo

echo "Restoring valid diagnostic target..."
echo

echo "example.com" > "$TARGET_FILE"

echo "Target restored to:"
cat "$TARGET_FILE"

echo
echo "Running post-fix diagnostics..."
echo

python3 scripts/network_diagnostics.py

diagnostic_result=$?

echo
echo "======================================"
echo "RECOVERY RESULT"
echo "======================================"
echo

if [ "$diagnostic_result" -eq 0 ]; then

    echo "RECOVERY VERIFIED"
    echo
    echo "DNS resolution passed."
    echo "TCP connectivity passed."
    echo
    echo "The simulated issue has been corrected."

    exit 0

else

    echo "RECOVERY NOT VERIFIED"
    echo
    echo "One or more diagnostic checks"
    echo "are still failing."
    echo
    echo "Further troubleshooting is required."

    exit 1

fi
