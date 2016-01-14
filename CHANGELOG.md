# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## 1.1.1
- Fixes issue where upgrade doesn't restart service.

## 1.1.0
- Removes dependency on the SELinux cookbook.

## 1.0.8
### Bug Fixes
- Fixes incorrect default options in template resource.
- Fixes path to template resource file for configuration.

## 1.0.4
### Bug Fixes
- Squashes several issues converging and testing the [confd-iptables cookbook][1].

## 1.0.0
### Features
- Resource for managing confd templates and configurations.
- Resource for executing confd command.
- Resource for running confd as a service.

[Unreleased]: https://github.com/johnbellone/confd-cookbook/compare/v1.1.0...HEAD
[1]: https://github.com/johnbellone/confd-iptables-cookbook
