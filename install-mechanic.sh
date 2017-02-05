#!/bin/bash -e

channel=$1
if [[ "unstable" != "${channel}" ]]; then
  echo "The only channel is unstable for now. So call it $0 unstable"
  exit 1
fi

if [[ "$UID" != "0" ]]; then
  echo "Must be run as root."
  exit 1
fi

echo "This is $(md5sum $0)."

function print_banner() {
	echo "***************************************************"
	echo "*"
	echo "* " $*
	echo "*"
	echo "***************************************************"
}

print_banner Installing Server Mechanic ${channel}...

function install_debian_based() {
  dist=$1
  release=$2

  echo "Installing apt https transport..."
  apt-get update && apt-get install -y apt-transport-https

  echo "Adding server mechanic repo for $dist:$release..."
cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/${dist}/ ${release} ${channel}
EOB

  echo "Installing server mechanic..."
  apt-get update && apt-get install -y mechanic

  /usr/sbin/mechanic version
}

if [[ -f "/etc/lsb-release" ]]; then
  source /etc/lsb-release
  case "$DISTRIB_ID$DISTRIB_CODENAME" in
    Ubuntuxenial)
      install_debian_based ubuntu xenial
    ;;
    Ubuntuyakkety)
      install_debian_based ubuntu yakkety
    ;;
    *)
      echo "Unsupported lsb linux $DISTRIB_ID $DISTRIB_CODENAME."
      exit 1
    ;;
  esac
elif [[ -f "/etc/debian_version" ]]; then
  debian_version=$(cat /etc/debian_version)
  case $debian_version in
    *9.*|*sid*)
      install_debian_based debian sid
    ;;
    *8.*|*jessie*)
      install_debian_based debian jessie
    ;;
    *7.*|*wheezy*)
      install_debian_based debian wheezy
    ;;
    *)
      echo "Unsupported debian. ($debian_version)"
      exit 1
    ;;
  esac
elif [[ -f "/etc/fedora-release" ]]; then
  fedora_version=$(cat /etc/fedora-release)
  case $fedora_version in
    *25*)
      echo "Fedora 25 is currently not supported. ($fedora_version)"
      exit 1
    ;;
    *)
      echo "Unsupported fedora. ($fedora_version)"
      exit 1
    ;;
  esac
elif [[ -f "/etc/redhat-release" ]]; then
  redhat_version=$(cat /etc/redhat-release)
  case $redhat_version in
    *CentOS*7.*)
      echo "CentOS is currently not supported. ($redhat_version)"
      exit 1
    ;;
    *)
      echo "Unsupported redhat. ($redhat_version)"
      exit 1
    ;;
  esac
else
  echo "Unsupported linux."
  exit 1
fi

print_banner Done.

exit 0
