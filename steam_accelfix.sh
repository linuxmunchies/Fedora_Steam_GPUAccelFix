#!/bin/bash

# A script to fix the Steam hardware acceleration crash on Linux by
# removing the 'PrefersNonDefaultGPU=true' line from its desktop launcher.

set -e # Exit immediately if a command fails

# --- Define File Paths ---
SYSTEM_LAUNCHER="/usr/share/applications/steam.desktop"
LOCAL_LAUNCHER_DIR="${HOME}/.local/share/applications"
LOCAL_LAUNCHER_PATH="${LOCAL_LAUNCHER_DIR}/steam.desktop"

echo "--- Steam GPU Acceleration Fix ---"

# 1. Check if Steam is installed and the system launcher exists
if [ ! -f "$SYSTEM_LAUNCHER" ]; then
    echo "Error: System-wide Steam launcher not found at '$SYSTEM_LAUNCHER'."
    echo "Please make sure Steam is installed correctly."
    exit 1
fi

# 2. Ensure the local applications directory exists
mkdir -p "$LOCAL_LAUNCHER_DIR"

# 3. Copy the launcher to the local directory to avoid modifying system files
echo "Copying system launcher to local directory for user-specific changes..."
cp "$SYSTEM_LAUNCHER" "$LOCAL_LAUNCHER_PATH"

# 4. Check if the problematic line exists in the new file
if grep -q "PrefersNonDefaultGPU=true" "$LOCAL_LAUNCHER_PATH"; then
    echo "Found 'PrefersNonDefaultGPU=true' line. Removing it..."
    # Use sed to find the line and delete it in-place
    sed -i '/^PrefersNonDefaultGPU=true/d' "$LOCAL_LAUNCHER_PATH"
    echo "Successfully removed the line."
else
    echo "The line 'PrefersNonDefaultGPU=true' was not found."
    echo "No changes needed, the launcher may already be fixed."
fi

# 5. Update the desktop database to make changes apply immediately
echo "Updating application database..."
update-desktop-database -q "$LOCAL_LAUNCHER_DIR"

echo " "
echo "✅ Fix applied successfully!"
echo "You should now be able to launch Steam from your application menu with GPU acceleration enabled."
