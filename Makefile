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

CHART=xwiki

init:
	mkdir -p .keyporttech && curl -o .keyporttech/Makefile.keyporttech https://raw.githubusercontent.com/keyporttech/helm-charts/master/Makefile.keyporttech
.PHONY: init

include ./.keyporttech/Makefile.keyporttech

generate-docs:
	@echo "generating documentation..."
	@echo "generating README.md"
	helm-docs --chart-search-root=./ --template-files=./README.md.gotmpl --template-files=./_templates.gotmpl --output-file=./README.md --log-level=trace
	sed -i 's/pipelineVer/$(TEKTON_PIPELINE_VERSION)/g' ./README.md
	sed -i 's/triggerVer/$(TEKTON_TRISGGERS_VERISON)/g' ./README.md
	sed -i 's/dashboardVer/$(TEKTON_DASHBOARD_VERSION)/g' ./README.md
.PHONY: generate-docs
