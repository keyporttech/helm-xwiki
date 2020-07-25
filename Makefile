# Copyright 2020 Keyporttech Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

REGISTRY=registry.keyporttech.com:30243
DOCKERHUB_REGISTRY="keyporttech"
CHART=xwiki
VERSION=$(shell yq r Chart.yaml 'version')
RELEASED_VERSION=$(shell helm repo add keyporttech https://keyporttech.github.io/helm-charts/ > /dev/null && helm repo update> /dev/null && helm show chart keyporttech/xwiki | yq - read 'version')
RELEASED_VERSION_DEFAULT=0.0.0
REGISTRY_TAG=${REGISTRY}/${CHART}:${VERSION}
CWD=$(shell pwd)
CURRENT_BRANCH=${GIT-REF}

check-version:
	@echo "checking version..."

	@echo "NEW CHART VERSION=${VERSION}"

ifeq (${RELEASED_VERSION},)
	@echo "CURRENT RELEASED CHART VERSION is NOT available"
	@echo "Setting CURRENT RELEASED CHART VERSION to ${RELEASED_VERSION_DEFAULT}"
	@RELEASED_VERSION=${RELEASED_VERSION_DEFAULT}
else
	@echo "CURRENT RELEASED CHART VERSION is ${RELEASED_VERSION}"
endif

ifeq (${VERSION},${RELEASED_VERSION})
	@echo "NEW CHART VERSION ${VERSION} must be > CURRENT RELEASED CHART VERSION ${RELEASED_VERSION}"
	@echo "Please increment chart version setting in file Chart.yaml"
	@exit 1
endif
.PHONY: check-version

lint:
	@echo "linting..."
	helm lint
	helm template test ./
	ct lint --validate-maintainers=false --charts .
.PHONY: lint

test:
	@echo "testing..."
	ct install --charts .
	@echo "OK"
.PHONY: test

build: check-version lint test
.PHONY: build

publish-local-registry:
	REGISTRY_TAG=${REGISTRY}/${CHART}:${VERSION}
	@echo "publishing to ${REGISTRY_TAG}"
	HELM_EXPERIMENTAL_OCI=1 helm chart save ./ ${REGISTRY_TAG}
	# helm chart export  ${REGISTRY_TAG}
	HELM_EXPERIMENTAL_OCI=1 helm chart push ${REGISTRY_TAG}
	@echo "OK"
.PHONY: publish-local-registry

publish-public-repository:
	#docker run -e GITHUB_TOKEN=${GITHUB_TOKEN} -v `pwd`:/charts/$(CHART) registry.keyporttech.com:30243/chart-testing:0.1.4 bash -cx " \
	#echo $GITHUB_TOKEN; \
	helm package .;
	curl -o releaseChart.sh https://raw.githubusercontent.com/keyporttech/helm-charts/master/scripts/releaseChart.sh; \
	chmod +x releaseChart.sh; \
	./releaseChart.sh $(CHART) $(VERSION) .;
.PHONY: publish-public-repository

deploy: publish-local-registry publish-public-repository
	rm -rf /tmp/helm-$(CHART)
	git clone git@github.com:keyporttech/helm-$(CHART).git /tmp/helm-$(CHART)
	cd /tmp/helm-$(CHART) && git remote add downstream ssh://git@git.keyporttech.com:30222/keyporttech/helm-xwiki.git
	cd /tmp/helm-$(CHART) && git config --global user.email "bot@keyporttech.com"
	cd /tmp/helm-$(CHART) && git config --global user.name "keyporttech-bot"
	cd /tmp/helm-$(CHART) && git fetch downstream master
	cd /tmp/helm-$(CHART) && git fetch origin
	cd /tmp/helm-$(CHART) && git push -u origin downstream/master:master --force-with-lease
.PHONY:deploy

