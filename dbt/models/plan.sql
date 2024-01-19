SELECT
  *,
  STRUCT(JSON_EXTRACT_SCALAR(metadata, '$.created_by') AS created_by) AS metadata_struct
FROM {{ ref('raw_plan') }}
