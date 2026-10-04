#!/bin/bash

TARGET_FILE="test-data/network_target.txt"

echo "======================================"
echo "SAFE NETWORK FAILURE SIMULATION"
echo "======================================"
echo

echo "This simulation does NOT change your"
echo "real DNS settings or internet connection."
echo

echo "Changing diagnostic target to an"
echo "intentionally invalid hostname..."
echo

echo "does-not-exist.invalid" > "$TARGET_FILE"

echo "Target is now:"
cat "$TARGET_FILE"

echo
echo "Running network diagnostics..."
echo

python3 scripts/network_diagnostics.py

diagnostic_result=$?

echo

if [ "$diagnostic_result" -ne 0 ]; then

    echo "SIMULATION SUCCESSFUL"
    echo
    echo "The diagnostic tool correctly"
    echo "detected the simulated network failure."

else

    echo "UNEXPECTED RESULT"
    echo
    echo "The diagnostic tool did not detect"
    echo "the simulated failure."

fi

echo
echo "Run scripts/verify_recovery.sh"
echo "to restore the normal test target."