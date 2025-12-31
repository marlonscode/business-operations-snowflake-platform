from dagster import Definitions
from orchestration.assets.airbyte import get_airbyte_objects
from orchestration.assets.dbt import get_dbt_warehouse_objects


airbyte_workspace, airbyte_assets = get_airbyte_objects()
dbt_warehouse_resource, dbt_warehouse = get_dbt_warehouse_objects()

defs = Definitions(
    assets=[*airbyte_assets, dbt_warehouse],
    resources={
        "airbyte": airbyte_workspace,
        "dbt_warehouse_resource": dbt_warehouse_resource
        }
)
