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
EOB
}

function checkPreconditions() {
echo "Checking preconditions..."
checkForTools cat tar base64 gzip mktemp sed mv rmdir rm
streamTar | tar tf - | sed -r 's#./(.*)$#/\1#g' | (while read file; do
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
streamTar | tar tf - | sort -r | sed -r 's#^/(.*)$#/\1#g' | (cat - <<EOB
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
