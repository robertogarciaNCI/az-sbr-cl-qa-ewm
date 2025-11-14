name: az-sbr-cl-qa-ewm-pr

on:
  pull_request:
    branches: ["**"]

  workflow_dispatch:

defaults:
  run:
    working-directory: ./templates

jobs:
  pdn-create-tfvars-file:
    if: ${{ github.ref == 'refs/heads/master' || (github.event_name == 'pull_request' && github.base_ref == 'master') }}
    uses: ./.github/workflows/create-tfvars-file.yml
    secrets: inherit
    with:
      ENVIRONMENT_NAME: sbr-cl-qa-ewm

  pdn-terraform-plan:
    needs: [pdn-create-tfvars-file]
    uses: inchcape-nci/github_workflow_terraform_templates/.github/workflows/terraform-plan-template.yml@master
    secrets: inherit
    with:
      ENVIRONMENT_NAME: sbr-cl-qa-ewm
      TFVARS_FILE_CONTENT: ${{ needs.pdn-create-tfvars-file.outputs.tfvars_file_content_out }}

