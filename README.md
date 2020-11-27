# XWiki Helm Chart

This is the keyport tech adaption of xwiki-helm. Main change includes for direct volume mount of wiki-data storage

This is the XWiki [Helm Chart](https://helm.sh/docs/developing_charts) aiming to ease the deployment in both Local and Highly Available setups.

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 12.9.0](https://img.shields.io/badge/AppVersion-12.9.0-informational?style=flat-square)

Helm chart for xwiki.

**Homepage:** <https://github.com/keyporttech/helm-xwiki>

## Introduction

This is the keyport tech adaption of xwiki-helm. Main change includes for direct volume mount of wiki-data storage

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.helm.sh/stable | mysql | 1.6.9 |
| https://charts.helm.sh/stable | postgresql | 8.6.4 |
* A kubernetes cluster ( most recent release recommended)
* Helm 3 client
* Please ensure that nodepools have enough resources to run both a web application and database
* An external database if not using the in pod database

## Installing the Chart

This chart is published in [keyporttech/charts](https://github.com/keyporttech/helm-charts). To install the chart, first add the keyporttech helm repo:
```bash
helm repo add keyporttech https://keyporttech.github.io/helm-charts/
```
Then to install with the release name `xwiki` in the namespace `xwiki` with the customized values in custom_values.yaml run:

```bash
$ helm install -- values custom_values.yaml --name xwiki --namespace xwiki keyporttech/xwiki
```
or locally:

```bash
$ helm install --name xwiki --namespace  xwiki.
```
> **Tip**: You can use the default [values.yaml](values.yaml)

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm uninstall my-release -n my-namespace
```

All resources associated with the last release of the chart as well as its release history will be deleted.

## Ingress And External Host/Ports

To expose the web application this chart will generate an ingress using the ingress controller of choice if specified. If an ingress is enabled services.http.externalHost must be specified. To expose SSH services it relies on either a LoadBalancer or NodePort.

# Configuration

Refer to [values.yaml](values.yaml) for the full run-down on defaults.

The following table lists the configurable parameters of this chart and their default values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalDB.database | string | `""` |  |
| externalDB.host | string | `""` |  |
| externalDB.password | string | `""` |  |
| externalDB.user | string | `""` |  |
| image.name | string | `"xwiki"` | image name |
| image.pullPolicy | string | `"IfNotPresent"` | image name |
| image.tag | string | `"12.9.0-postgres-tomcat"` | image tag |
| ingress.annotations | object | `{"kubernetes.io/ingress.class":"nginx"}` | ingress annotations |
| ingress.enabled | bool | `false` | enable the ingress |
| ingress.host | string | `"my-host"` | ingress host name |
| ingress.tls | list | `[{"hosts":["myhost"],"secretName":"wiki-tls"}]` | tls config for ingress |
| istio.enabled | bool | `false` |  |
| istio.host | string | `"*"` |  |
| mysql.enabled | bool | `false` | Whether to deploy a mysql server. Set false for a different database. |
| mysql.imageTag | float | `5.7` |  |
| mysql.mysqlDatabase | string | `"xwiki"` |  |
| mysql.mysqlPassword | string | `"xwiki"` |  |
| mysql.mysqlRootPassword | string | `"xwiki"` |  |
| mysql.mysqlUser | string | `"xwiki"` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.minAvailable | int | `1` |  |
| postgresql.enabled | bool | `true` | Whether to deploy a postgresql server. Set false for a different database. |
| postgresql.image.tag | string | `"11.3.0-debian-9-r38"` |  |
| postgresql.persistence.enabled | bool | `false` |  |
| postgresql.postgresqlDatabase | string | `"xwiki"` |  |
| postgresql.postgresqlPassword | string | `"xwiki"` |  |
| postgresql.postgresqlUsername | string | `"xwiki"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"350m"` |  |
| resources.limits.memory | string | `"1000Mi"` |  |
| resources.requests.cpu | string | `"150m"` | xwiki container cpu request |
| resources.requests.memory | string | `"250Mi"` | xwiki container memory request |
| service.externalPort | int | `80` | external port name |
| service.internalPort | int | `8080` |  |
| service.name | string | `"http"` | service name |
| service.portName | string | `"node"` | name of the port |
| service.type | string | `"ClusterIP"` | service type |
| solr | object | `{"enabled":false,"host":"localhost","port":8983}` | To use external solr enable solr, provide host and port |
| storageType | string | `"emptyDir"` | type of storage for the volume: pvc, emptyDir or directVolume |

## Source Code

* <https://github.com/xwiki-contrib/docker-xwiki>
* <https://github.com/keyporttech/charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| John Felten | john.felten@keyporttech.com |  |
| John Felten | john.felten@keyporttech.com |  |

## Contributing

Please see [keyporttech charts contribution guidelines](https://github.com/keyporttech/helm-charts/blob/master/CONTRIBUTING.md)

