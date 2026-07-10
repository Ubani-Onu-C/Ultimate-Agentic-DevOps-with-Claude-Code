---
name: project-portfolio-site-terraform
description: State of terraform/ (S3+CloudFront static site hosting) as of the 2026-07-10 security audit — what's already solid vs. still open.
metadata:
  type: project
---

This repo (`Ultimate-Agentic-DevOps-with-Claude-Code`) provisions a static HTML/CSS
portfolio site on S3 + CloudFront via Terraform in `terraform/` (files:
providers.tf, variables.tf, main.tf, outputs.tf, backend.tf). No IAM
roles/policies or OIDC trust docs exist in these files yet — IAM/OIDC checklist
items were N/A as of this review.

**Already solid (verified 2026-07-10), don't re-flag unless changed:**
- S3 public access block fully locked down (all 4 flags true).
- `object_ownership = "BucketOwnerEnforced"` — ACLs disabled, correct modern pattern.
- CloudFront uses OAC (not OAI), bucket policy scoped to the specific distribution
  ARN via `AWS:SourceArn` condition — good least-privilege pattern to recognize as
  correct, not flag as wildcard-principal risk.
- `viewer_protocol_policy = "redirect-to-https"` set.
- Versioning enabled on the site bucket.
- No hardcoded account IDs/secrets — account ID pulled via `data.aws_caller_identity.current`.
- `backend.tf` documents a sane local-state bootstrap flow before an S3 backend exists (intentionally commented out); this is a deliberate, reasonable chicken-and-egg solution, not an oversight.

**Open findings as of 2026-07-10 (re-check on next review to see if fixed):**
- No `aws_cloudfront_response_headers_policy` — missing CSP/X-Frame-Options/HSTS/etc.
- No root-level `.gitignore` anywhere in the repo — tfstate/tfvars/.terraform/ are
  not excluded from git, risky given backend.tf's local-state bootstrap step.
- `viewer_certificate` block hardcodes `cloudfront_default_certificate = true` even
  though `aliases` becomes non-empty when `var.domain_name` is set — will break or
  weaken TLS (stuck at TLSv1) the moment a custom domain is configured. Needs
  conditional ACM cert + `minimum_protocol_version = "TLSv1.2_2021"`.
- No explicit `aws_s3_bucket_server_side_encryption_configuration` (relies on
  implicit SSE-S3 default rather than codifying it).
- No access logging for either the S3 bucket or the CloudFront distribution.
- No WAF attached to the CloudFront distribution (lower priority, nice-to-have for
  this low-traffic static site).
- Minor/low: no lifecycle rule to expire noncurrent object versions; bucket name
  embeds account ID (minor info-disclosure, common tradeoff); `custom_error_response`
  rewrites 404s to index.html with 200 even though this is a plain multi-page HTML
  site with no client-side router (per root CLAUDE.md — no JS allowed in this project).

**How to apply:** When re-auditing this directory, diff against this list first —
only report items above as findings if they're still present in the code; report
new items separately. If response headers policy / logging / SSE config / gitignore
get added, remove the corresponding bullet here and note the resolution date instead
of re-flagging.
