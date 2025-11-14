name: az-sbr-cl-qa-ewm-deploy

on:
  push:
    branches: ["master"]

  workflow_dispatch:

defaults:
  run:
    working-directory: ./templates

jobs:
  qa-terraform-apply:
    if: ${{ github.ref == 'refs/heads/master' || (github.event_name == 'pull_request' && github.base_ref == 'master') }}
    uses: inchcape-nci/github_workflow_terraform_templates/.github/workflows/terraform-apply-template.yml@master
    secrets: inherit
    with:
      ENVIRONMENT_NAME: sbr-cl-qa-ewm
