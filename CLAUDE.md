# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Static HTML/CSS portfolio website (no build step, no backend, no JavaScript framework) used in the DevOps Micro Internship (DMI) as a hosting exercise. Intended deployment target: AWS, using S3 for static hosting and CloudFront as the CDN in front of it, provisioned with Terraform and automated via GitHub Actions.

## Architecture

Pure HTML5 and CSS3. `index.html` is the main page with anchor-linked sections (#home, #book, #courses, #contact); `privacy.html` and `terms.html` are standalone legal pages. All three share `style.css`. No JavaScript file exists in this project — do not add one. External dependency: Font Awesome 6.5.0 via CDN only.

## Commands

- `terraform init` — initialize the Terraform working directory
- `terraform plan` — preview infrastructure changes before applying
- `terraform apply` — provision/update the S3 + CloudFront infrastructure
- Local preview only: `python -m http.server 8000`

## Conventions

1. All infrastructure changes go through Terraform — never edit AWS resources manually.
2. **No JavaScript.** This project is pure HTML/CSS by design. Do not add `<script>` tags, JS frameworks, or JS-dependent components (including React).
3. Mobile-first CSS with breakpoints at 900px, 768px, and 600px.
4. Preserve the ownership footer in `index.html` — required for DMI submission proof.

## Safety

Never put secrets in this file or in the codebase. No API keys, passwords, or AWS credentials — use environment variables or a secrets manager instead.
