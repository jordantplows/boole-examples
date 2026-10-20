#!/bin/sh
# macOS setup check for the published Boole CLI. Does not vendor the CLI.
set -eu
echo "Boole setup (macOS)"
uname -sm

print_node_hint() {
  echo "Node.js 22 or newer is required (@boole/cli 0.7.0)."
  echo "Install it from https://nodejs.org/"
  echo "Or: brew install node"
  echo "Or, with nvm: nvm install 22"
}

if ! command -v node >/dev/null 2>&1; then
  echo "node was not found on PATH."
  print_node_hint
  exit 1
fi
major=$(node -p "process.versions.node.split('.')[0]")
echo "Node $(node -v)"
case $major in
  ''|*[!0-9]*)
    echo "Could not read the Node.js major version."
    print_node_hint
    exit 1
    ;;
esac
if [ "$major" -lt 22 ]; then
  echo "This Node.js is older than 22."
  print_node_hint
  exit 1
fi
echo "Running boole doctor via npx. This contacts the npm registry."
npx --yes @boole/cli@latest doctor
echo
echo "Commands: boole run, boole pull, boole serve, boole list, boole doctor, boole models."
echo "boole serve is for local development only. It has no authentication."
echo "Device notes: https://boole.sh/guides/"
