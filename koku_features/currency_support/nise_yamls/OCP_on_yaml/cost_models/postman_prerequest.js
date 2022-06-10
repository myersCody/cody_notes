// Requires the currrency to be in the cluster_id
// Can get to the postman console with cmd + option + C
desired_currency = "JYP";
pm.collectionVariables.set("currency", desired_currency)
pm.sendRequest("http://localhost:8000/api/cost-management/v1/sources/", function (err, response) {
    sources_data = response.json().data;
    for (let idx = 0; idx < sources_data.length; idx++) {
        source = sources_data[idx];
        source_type = source["source_type"];
        source_uuid = source["uuid"];
        if (source_type == "OCP") {
            cluster_id = sources_data[idx]["authentication"]["credentials"]["cluster_id"];
            if (cluster_id.indexOf(desired_currency) !== -1) {
                pm.collectionVariables.set("source_uuid", source_uuid);
                console.log(pm.collectionVariables.get("source_uuid"))
            }
        }
    }
});