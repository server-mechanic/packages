# Package repository for [Server Mechanic](https://github.com/server-mechanic/mechanic)

![Server Mechanic](https://server-mechanic.github.io/website/images/mechanic_small.png "Server Mechanic")

## mechanic *unstable*

### debian jessie

/Support for debian jessie is broken now because of apt rejecting install via https./

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ jessie unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### debian sid

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ sid unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### ubuntu xenial

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ xenial unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### ubuntu yakkety

```
apt-get update && apt-get install -y apt-transport-https

cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ yakkety unstable
EOB

apt-get update && apt-get install -y mechanic
```

