#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "Installing https transport..."
apt-get update && apt-get -y install apt-transport-https

echo "Adding mechanic repo..."
echo "deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ xenial unstable" > /etc/apt/sources.list.d/server-mechanic-unstable.list

echo "Installing mechanic..."
apt-get update && apt-get install -y mechanic

echo "Running mechanic..."
/usr/sbin/mechanic version

mkdir -p /var/lib/mechanic/migration.d/
cat - >/var/lib/mechanic/migration.d/001_test.sh <<EOB
#!/bin/bash -xe

echo "All right."

exit 0
EOB
chmod 755 /var/lib/mechanic/migration.d/001_test.sh

/usr/sbin/mechanic -v migrate

echo "Ok."
