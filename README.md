This is a sample of a local `dbt-core` config supporting and BigQuery SQL syntax to be used in conjunction with `lightdash`.

Models are mainly taken from https://github.com/lightdash/lightdash/tree/main/examples/full-jaffle-shop-demo/dbt, with some adjustments (see below).

We're also going with a local kubernetes deployment with `helm` based on the Lightdash [self-hosting instructions](https://docs.lightdash.com/self-host/self-host-lightdash/#self-host-lightdash-on-kubernetes).

## Setup
This expects the following to be established already:
- a BigQuery service account using OAuth
- a BigQuery project & dataset
- local kubernetes with `helm` installed

Download your BigQuery service account key (JSON) and set its path in your `~/.dbt/profiles.yml`. (`sample_profiles.yml` and `sample_key.json` are provided here for reference.)


## Installation
Required steps for a fresh installation:
- locally deploy `lightdash` via `helm` ([docs](https://docs.lightdash.com/self-host/self-host-lightdash/#self-host-lightdash-on-kubernetes))
- make sure the `lightdash` CLI is installed (`npm install -g @lightdash/cli@0.702.0`)
- set up the seed data with `dbt seed`

```
lightdash dbt run
lightdash deploy --create
```

For follow-on installations (after any modifications), use `lightdash deploy` (without the `--create` flag).

## Adjustments made
- converted the `raw_generated.csv`'s `date*` and `time` values to proper date/time strings to avoid parser errors
- swap `field::type` syntax to `CAST(field AS type)` syntax

TO FIX:
- `raw_plan.metadata` in `dbt_project.yml` changed from `JSONB` (unsupported) to `string` type, but that's breaking `metadata.created_by` references and is currently throwing validation errors
