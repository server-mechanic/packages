# Package repository for [Server Mechanic](https://github.com/server-mechanic/mechanic)

![Server Mechanic](https://server-mechanic.github.io/website/images/mechanic.png "Server Mechanic")

## mechanic *unstable*

### ubuntu xenial

```
cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ xenial unstable
EOB

apt-get update && apt-get install -y mechanic

/usr/sbin/mechanic version
```

### ubuntu yakkety

```
cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/ubuntu/ yakkety unstable
EOB

apt-get update && apt-get install -y mechanic
```

### debian jessie

```
cat - >/etc/apt/sources.list.d/server-mechanic-unstable.list <<EOB
deb [trusted=yes] https://raw.githubusercontent.com/server-mechanic/packages/master/apt/debian/ jessie unstable
EOB

apt-get update && apt-get install -y mechanic
```
