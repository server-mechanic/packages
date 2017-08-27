#!/bin/bash -e

force="no"
channel=""

if [[ "$force" != "yes" && "$UID" != "0" ]]; then
  echo "Must be run as root. (Use -f|--force to override.)"
  exit 1
fi

function install_prerequesites() {
  echo "Installing prerequesites..."
if [[ -f "/etc/lsb-release" ]]; then
  source /etc/lsb-release
  case "$DISTRIB_ID$DISTRIB_CODENAME" in
    Ubuntuxenial|Ubuntuyakkety|Ubuntuzesty)
      apt-get update && apt-get install -y curl
    ;;
    *)
      echo "Unsupported lsb linux $DISTRIB_ID $DISTRIB_CODENAME."
      exit 1
    ;;
  esac
elif [[ -f "/etc/debian_version" ]]; then
  debian_version=$(cat /etc/debian_version)
  case $debian_version in
    *sid*|*10.*)
      apt-get update && apt-get remove -y apt-listchanges && apt-get install -y curl
    ;;
    *wheezy*|*7.*|*jessie*|*8.*|*stretch*|*9.*)
      apt-get update && apt-get install -y curl
    ;;
    *)
      echo "Unsupported debian. ($debian_version)"
      exit 1
    ;;
  esac
elif [[ -f "/etc/fedora-release" ]]; then
  fedora_version=$(cat /etc/fedora-release)
  case $fedora_version in
    *26*|*25*)
      dnf -y install which curl
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
      yum -y install which curl
      exit 1
    ;;
    *)
      echo "Unsupported redhat. ($redhat_version)"
      exit 1
    ;;
  esac
else
  echo "Unsupported OS. (Use -f|--force to force installation via bash installer.)"
  exit 1
fi
}

install_prerequesites

function check_tools() {
  local bin=""
  local i=""
  local path=""
  for i in $*; do 
    path=$(which $i)
    if [[ -z "$path" ]]; then
      echo "$i is required but is not in path."
      exit 1
    fi
  done
}

check_tools curl cat mktemp

function parse_opts() {
  for i in $*; do
    case $i in
      stable|unstable)
        channel=$i
      ;;
      -f|--force)
        force="yes"
      ;;
      *)
        echo "Unknown flag $i." >&2
    esac
  done
}

parse_opts $*

channel=$1
if [[ "unstable" != "${channel}" ]]; then
  echo "The only channel is unstable for now. So call it $0 unstable"
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

  /usr/bin/mechanic version
}

function install_redhat_based() {
  dist=$1
  release=$2

  cat - >/etc/yum.repos.d/server-mechanic.repo <<EOB
[servermechanicrepo]
name=Server Mechanic Repository
baseurl=https://raw.githubusercontent.com/server-mechanic/packages/master/rpm/$dist/\$releasever/unstable/\$basearch
enabled=1
gpgcheck=0
EOB

  echo "Installing server mechanic..."
  yum install -y mechanic

  /usr/bin/mechanic version
}

function install_unsupported() {
  local tmpsh=$(mktemp)
  curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/bash-installer/latest.sh -o $tmpsh
  chmod 755 $tmpsh
  ./$tmpsh
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
    Ubuntuzesty)
      install_debian_based ubuntu zesty
    ;;
    *)
      echo "Unsupported lsb linux $DISTRIB_ID $DISTRIB_CODENAME."
      exit 1
    ;;
  esac
elif [[ -f "/etc/debian_version" ]]; then
  debian_version=$(cat /etc/debian_version)
  case $debian_version in
    *10.*|*sid*)
      install_debian_based debian sid
    ;;
    *9.*|*stretch*)
      install_debian_based debian stretch
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
    *26*)
      install_redhat_based fedora 26
    ;;
    *25*)
      install_redhat_based fedora 25
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
      install_redhat_based centos 7
    ;;
    *)
      echo "Unsupported redhat. ($redhat_version)"
      exit 1
    ;;
  esac
else
  if [[ "$force" == "yes" ]]; then
    echo "Installing server mechanic via bash installer..."
    install_unsupported
  else
    echo "Unsupported OS. (Use -f|--force to force installation via bash installer.)"
    exit 1
  fi
fi

print_banner Done.

exit 0
