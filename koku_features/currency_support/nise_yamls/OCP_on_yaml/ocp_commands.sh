AUD_YAML_URL=https://github.com/myersCody/cody_notes/blob/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_AUD.yml
JYP_YAML_URL=https://github.com/myersCody/cody_notes/blob/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_JYP.yml
EUR_YAML_URL=https://github.com/myersCody/cody_notes/blob/main/koku_features/currency_support/nise_yamls/OCP_on_yaml/ocp_on_premise_EUR.yml

AUD_YAML=notdir(AUD_YAML_URL)
JYP_YAML=notdir(JYP_YAML_URL)
EUR_YAML=notdir(EUR_YAML_URL)

wget -O - $AUD_YAML_URL >> $AUD_YAML_URL
wget -O - $JYP_YAML_URL >> $JYP_YAML_URL
wget -O - $EUR_YAML_URL >> $EUR_YAML_URL

START_DATE=$(date -v -1m +"%Y-%m-%d")
END_DATE=date +"%Y-%m-%d"

sed "s/START_DATE/$START_DATE/g" $AUD_YAML_URL
sed "s/END_DATE/$END_DATE/g" $AUD_YAML_URL

sed "s/START_DATE/$START_DATE/g" $JYP_YAML_URL
sed "s/END_DATE/$END_DATE/g" $JYP_YAML_URL

sed "s/START_DATE/$START_DATE/g" $EUR_YAML_URL
sed "s/END_DATE/$END_DATE/g" $EUR_YAML_URL

make ocp-source-from-yaml cluster_id=ocp-cluster-AUD srf_yaml=$AUD_YAML ocp_name=local-ocp
make ocp-source-from-yaml cluster_id=ocp-cluster-JYP srf_yaml=$JYP_YAML ocp_name=local-ocp-0
make ocp-source-from-yaml cluster_id=ocp-cluster-JYP srf_yaml=$EUR_YAML ocp_name=local-ocp-1
