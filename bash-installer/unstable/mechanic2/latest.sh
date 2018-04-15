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
