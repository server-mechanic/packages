# Package repository for [Server Mechanic](https://github.com/server-mechanic/mechanic) [![Build Status](https://travis-ci.org/server-mechanic/packages.svg)](https://travis-ci.org/server-mechanic/packages)

![Server Mechanic](https://server-mechanic.github.io/website/images/mechanic_small.png "Server Mechanic")

## mechanic *unstable*

Server Mechanic is supported on:
* Ubuntu: xenial, yakkety, zesty, artful, bionic
* Debian: wheezy, jessie (currently broken), stretch, sid
* Fedora: 25, 26, 27, 28
* CentOS: 7

### Simple install (for all supported distributions)

```
curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh | sudo bash -s unstable
```

### debian sid

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ sid unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### debian stretch

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ stretch unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### debian jessie

#### Support for debian jessie is currently broken because of apt rejecting install via https.

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ jessie unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### debian wheezy

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ wheezy unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### ubuntu xenial

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ xenial unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### ubuntu yakkety

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ yakkety unstable
EOB

apt-get update && apt-get install -y mechanic
```

### ubuntu zesty

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ zesty unstable
EOB

apt-get update && apt-get install -y mechanic
```

### fedora 25, 26

```
cat - >/etc/yum.repos.d/server-mechanic.repo <<EOB
[servermechanicrepo]
name=Server Mechanic Repository
baseurl=https://raw.githubusercontent.com/server-mechanic/packages/master/rpm/fedora/\$releasever/unstable/\$basearch
enabled=1
gpgcheck=0
EOB

dnf install -y mechanic
```

### centos 7

```
cat - >/etc/yum.repos.d/server-mechanic.repo <<EOB
[servermechanicrepo]
name=Server Mechanic Repository
baseurl=https://raw.githubusercontent.com/server-mechanic/packages/master/rpm/centos/\$releasever/unstable/\$basearch
enabled=1
gpgcheck=0
EOB

dnf install -y mechanic
```

## Issues

Please raise issues at [Issue list of Server Mechanic](https://github.com/server-mechanic/mechanic/issues).
