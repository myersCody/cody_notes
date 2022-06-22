from decimal import Decimal
# USE THE FIND DAILY COST SQL
# -[ RECORD 1 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | 2d085606-e8fa-4a91-9ef8-755c05cb36e2
# cluster_id    | ocp-cluster-JPY
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.1337976777777776100000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 2 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | 7188a517-5653-4482-bc57-c60b4a8f88a8
# cluster_id    | ocp-cluster-EUR
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.2284206333333329500000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 3 ]-+-------------------------------------
# usage_start   | 2022-06-01
# source_uuid   | e2e9d867-bced-43f1-8f03-922f0fb1fdee
# cluster_id    | ocp-cluster-AUD
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.0170106833333333000000000
# infra_monthly | 16999.999999999999999800000000000000
# sup_monthly   |
# -[ RECORD 4 ]-+-------------------------------------


exchange_rates = {
                    "JPY": {"USD": Decimal(1.25)},
                    "EUR": {"USD": Decimal(.5)},
                    "AUD": {"USD": Decimal(.25)},
                }

query_data = {
    "JPY": [60.00000000000000000, 120.1337976777777776100000000, 16999.999999999999999800000000000000],
    "EUR": [60.00000000000000000, 120.2284206333333329500000000, 16999.999999999999999800000000000000],
    "AUD": [60.00000000000000000, 120.0170106833333333000000000, 16999.999999999999999800000000000000]
}

# -[ RECORD 4 ]-+-------------------------------------
# usage_start   | 2022-06-02
# source_uuid   | 2d085606-e8fa-4a91-9ef8-755c05cb36e2
# cluster_id    | ocp-cluster-JPY
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.5596480999999999000000000
# infra_monthly |
# sup_monthly   |
# -[ RECORD 5 ]-+-------------------------------------
# usage_start   | 2022-06-02
# source_uuid   | 7188a517-5653-4482-bc57-c60b4a8f88a8
# cluster_id    | ocp-cluster-EUR
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.2828745388888888600000000
# infra_monthly |
# sup_monthly   |
# -[ RECORD 6 ]-+-------------------------------------
# usage_start   | 2022-06-02
# source_uuid   | e2e9d867-bced-43f1-8f03-922f0fb1fdee
# cluster_id    | ocp-cluster-AUD
# infra_daily   | 60.00000000000000000
# sup_daily     | 120.9194122166666666300000000
# infra_monthly |
# sup_monthly   |



total_sum_list = []
for key in query_data.keys():
    for cost in query_data.get(key, []):
        converted = Decimal(cost) * exchange_rates[key]["USD"]
        total_sum_list.append(converted)

print(sum(total_sum_list))
