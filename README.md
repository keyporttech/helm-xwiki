# XWiki Helm Chart

This is the keyport tech adaption of xwiki-helm. The main changes include direct volume mount of wiki-data storage and CICD automation.

## Prerequisites

* helm 3
* a modern working k8s cluster

## Install

```bash
helm repo add keyporttech https://keyporttech.github.io/helm-charts/
helm install my-release keyporttech/helm-xwiki
```
or clone this repo and install from the file system.

## Contributing

Please see [keyporttech charts contribution guidelines](https://github.com/keyporttech/helm-charts/blob/master/CONTRIBUTING.md)

## Running the cicd tooling locally

This chart uses a Makefile to run CICD. To run:

```bash
make build
```

## Values.yaml Configuration

Most configurable values are similar to other helm charts generated via helm create. The configurations specific to this chart are listed below.

## Resources

* XWiki Installation Guide: https://www.xwiki.org/xwiki/bin/view/Documentation/AdminGuide/Installation
* XWiki Docker : https://github.com/xwiki-contrib/docker-xwiki

## Project Information

* Project Lead: [Ashish Sharma](https://www.xwiki.org/xwiki/bin/view/XWiki/ashish932)
* [Issue Tracker](http://jira.xwiki.org/browse/HELM)
* Communication: [Mailing List](http://dev.xwiki.org/xwiki/bin/view/Community/MailingLists), [IRC](http://dev.xwiki.org/xwiki/bin/view/Community/IRC)
* [Development Practices](http://dev.xwiki.org)
* Minimal XWiki version supported: XWiki 8.4
* License: LGPL 2.1
* Translations: N/A
* Sonar Dashboard: N/A
* Continuous Integration Status: N/A
