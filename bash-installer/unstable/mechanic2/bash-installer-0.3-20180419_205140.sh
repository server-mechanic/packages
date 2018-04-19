#!/bin/bash -e

force="no"
function parseOpts() {
for i in $*; do
case $i in
-f|--force)
force="yes"
;;
*)
echo "Unknown flag $i; $0 [-f|--force]" >&2
exit 1
esac
done
}

if [[ "$force" != "yes" && "$UID" != "0" ]]; then
echo "Must be run as root."
exit 1
fi

UNINSTALLER_TMP_FILE=$(mktemp)
UNINSTALLER_FILE=/usr/local/mechanic2/bin/uninstall.sh

function checkForTools() {
local path=""
local tool=""

for tool in $*; do
path=$(which $tool)
if [[ -z "$path" ]]; then
echo "$tool not found."
exit 1
fi
done
}

function streamTar() {
(cat - | base64 -d | gzip -d ) <<EOB
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
AwYMGDCgwv8AFI4GpgCgAAA=
EOB
}

function checkPreconditions() {
echo "Checking preconditions..."
checkForTools cat tar base64 gzip mktemp sed mv rmdir rm
streamTar | tar tf - | sed -r 's#^/(.*)$#/\1#g' | (while read file; do
if [[ "$file" =~ ^.*[^/]$ ]]; then
if [[ -f "$file" ]]; then
echo "$file already exists; aborting."
exit 1
else
echo "$file - ok"
fi
else
echo "$file - ok"
fi
done)
}

function unpack() {
echo "Unpacking..."
streamTar | tar xvf - -C /
}

function generateUninstaller() {
echo "Generating uninstaller..."
streamTar | tar tf - | grep -v -e '^usr/local/$' | grep -v -e '^usr/$' | sort -r | sed -r 's#^/(.*)$#/\1#g' | (cat - <<EOB
#!/bin/bash -xe

echo "Uninstalling..."
EOB
while read file; do
if [[ "$file" =~ ^.*/$ ]]; then
if [[ ! -d "$file" ]]; then
echo "rmdir "/$file""
fi
else
echo "rm "/$file"";
fi
done; cat - <<EOB
echo "Done."

exit 0
EOB
) >$UNINSTALLER_TMP_FILE
}

function relocateUninstaller() {
mv $UNINSTALLER_TMP_FILE $UNINSTALLER_FILE
chmod +x $UNINSTALLER_FILE
}

checkPreconditions
generateUninstaller
unpack
relocateUninstaller

exit 0
