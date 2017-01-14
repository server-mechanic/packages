# Package repository for [Server Mechanic](https://github.com/server-mechanic/mechanic) [![Build Status](https://travis-ci.org/server-mechanic/packages.svg)](https://travis-ci.org/server-mechanic/packages)

![Server Mechanic](https://server-mechanic.github.io/website/images/mechanic_small.png "Server Mechanic")

## mechanic *unstable*

Server Mechanic is supported on:
* Ubuntu: xenial, yakkety
* Debian: jessie (currently broken), sid

### Simple install (for all supported distributions)

```
curl -s https://raw.githubusercontent.com/server-mechanic/packages/master/install-mechanic.sh | sudo bash -s unstable
```

### debian jessie

#### Support for debian jessie is broken now because of apt rejecting install via https.

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ jessie unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
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

