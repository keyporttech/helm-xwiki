# XWiki Helm Chart

This is the keyport tech adaption of xwiki-helm. Main change includes for direct volume mount of wiki-data storage

This is the XWiki [Helm Chart](https://helm.sh/docs/developing_charts) aiming to ease the deployment in both Local and Highly Available setups.  


## Resources

* XWiki Installation Guide: https://www.xwiki.org/xwiki/bin/view/Documentation/AdminGuide/Installation
* XWiki Docker : https://github.com/xwiki-contrib/docker-xwiki


## Prerequisite

* A modern
* Kubectl
* helm 3

## Installation on Minikube

* First, enable ingress

```bash
minikube addons enable ingress
```

* Install chart

```bash
git clone https://github.com/xkeyporttech/xwiki-helm
cd xwiki-helm-chart
helm dependency update
helm --debug upgrade -i --force xwiki -f ./values.yaml .
```
