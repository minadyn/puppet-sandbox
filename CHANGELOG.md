# Changelog

## 0.1.0 - 2013-07-30

- Added dynamic hosts file based on Vagrant configuration.
- Added a Changelog
- Added host ssh port forward configuration support.
- Added some CentOS specific defaults to the default manifest.
      - CentOS enables iptables and selinux by default, so an exec resource was created to disable those.  
