#!/bin/bash
# Script to push to myrepo with better error handling

set -e

cd "$(dirname "$0")"

echo "=== Pushing to myrepo ==="
echo "Remote: $(git remote get-url myrepo)"
echo ""

# Check if remote exists and is accessible
echo "1. Checking remote access..."
if ! git ls-remote myrepo &>/dev/null; then
    echo "⚠️  Warning: Cannot access remote. Make sure the repo exists on GitHub."
    echo "   Create it at: https://github.com/thomasvuong/e2-F5-tts_Pinokio_Mac_RunFromTerminal_Vietnamese_Models"
    exit 1
fi
echo "✅ Remote accessible"

# Show what will be pushed
echo ""
echo "2. Commits to push:"
git log --oneline origin/main..main 2>&1 || git log --oneline -8
echo ""

# Check repo size
REPO_SIZE=$(du -sh . | awk '{print $1}')
echo "3. Repository size: $REPO_SIZE"
if [ "$REPO_SIZE" != "" ]; then
    echo "   ⚠️  Large repository may cause push issues"
fi
echo ""

# Attempt push with timeout
echo "4. Attempting push..."
echo "   (This may take several minutes for large repos...)"
echo ""

GIT_TERMINAL_PROMPT=0 git push myrepo main 2>&1 | tee /tmp/git_push.log

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo ""
    echo "✅ Push successful!"
else
    echo ""
    echo "❌ Push failed. Check /tmp/git_push.log for details"
    echo ""
    echo "Common solutions:"
    echo "1. Initialize the repo on GitHub first"
    echo "2. Use GitHub Desktop or GitHub CLI"
    echo "3. Try: git push myrepo main --force-with-lease"
    exit 1
fi

