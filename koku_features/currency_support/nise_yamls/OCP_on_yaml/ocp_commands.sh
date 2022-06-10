#!/bin/bash
# curl -s -L https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_commands.sh | bash
AUD_YAML_URL=https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_AUD.yml
JPY_YAML_URL=https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_JPY.yml
EUR_YAML_URL=https://raw.githubusercontent.com/myersCody/cody_notes/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_EUR.yml

AUD_YAML=$(basename $AUD_YAML_URL)
JPY_YAML=$(basename $JPY_YAML_URL)
EUR_YAML=$(basename $EUR_YAML_URL)


curl -o $AUD_YAML $AUD_YAML_URL
curl -o $JPY_YAML $JPY_YAML_URL
curl -o $EUR_YAML $EUR_YAML_URL

START_DATE=$(date -v -1m +"%Y-%m-01")
END_DATE=$(date +"%Y-%m-%d")

# https://stackoverflow.com/questions/19456518/error-when-using-sed-with-find-command-on-os-x-invalid-command-code
sed -i '' -e "s/START_DATE/$START_DATE/g" $AUD_YAML
sed -i '' -e "s/END_DATE/$END_DATE/g" $AUD_YAML

sed -i '' -e "s/START_DATE/$START_DATE/g" $JPY_YAML
sed -i '' -e "s/END_DATE/$END_DATE/g" $JPY_YAML

sed -i '' -e "s/START_DATE/$START_DATE/g" $EUR_YAML
sed -i '' -e "s/END_DATE/$END_DATE/g" $EUR_YAML

make ocp-source-from-yaml cluster_id=ocp-cluster-AUD srf_yaml=$AUD_YAML ocp_name=local-ocp
make ocp-source-from-yaml cluster_id=ocp-cluster-JPY srf_yaml=$JPY_YAML ocp_name=local-ocp-0
make ocp-source-from-yaml cluster_id=ocp-cluster-EUR srf_yaml=$EUR_YAML ocp_name=local-ocp-1

rm $AUD_YAML
rm $JPY_YAML
rm $EUR_YAML

curl http://localhost:8000/api/cost-management/v1/sources/

