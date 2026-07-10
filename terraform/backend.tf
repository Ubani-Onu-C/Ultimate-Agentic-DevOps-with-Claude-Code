# ---------------------------------------------------------------------------
# Remote state backend (S3)
# ---------------------------------------------------------------------------
#
# The backend is COMMENTED OUT intentionally. Terraform cannot use an S3
# backend that does not exist yet, so the first run must use local state.
#
# Bootstrap procedure:
#
#   1. First run — with this block commented out — initializes local state:
#          terraform init
#
#   2. Create the infrastructure (this also lets you create a dedicated
#      state bucket first if you prefer; the bucket must exist before step 4):
#          terraform apply
#
#   3. Uncomment the `terraform { backend "s3" { ... } }` block below and
#      set `bucket` to your state bucket name (and `region` to match).
#
#   4. Migrate the existing local state into the S3 backend:
#          terraform init -migrate-state
#
# Notes:
#   - The state bucket should have versioning enabled and public access
#     blocked. Do NOT store state in the same bucket that serves the site.
#   - `use_lockfile = true` provides state locking via S3 (Terraform >= 1.10);
#     alternatively configure a DynamoDB table with `dynamodb_table`.
#
# terraform {
#   backend "s3" {
#     bucket       = "CHANGE-ME-terraform-state-bucket"
#     key          = "portfolio-site/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
