name: create-tfvars-file

on:
  workflow_call:
    inputs:
      ENVIRONMENT_NAME:
        required: true
        type: string
    outputs:
      tfvars_file_content_out:
        value: ${{ jobs.create-tfvars-file.outputs.tfvars_file_content_out }}

jobs:
  create-tfvars-file:
    runs-on: ubuntu-latest
    environment: ${{ inputs.ENVIRONMENT_NAME }}
    outputs:
      tfvars_file_content_out: ${{ steps.set_terraform_tfvars_file.outputs.tfvars_file_content }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Create artifacts directories
        run: |
          mkdir -p ${{ github.workspace }}/templates/${{ vars.TF_PLAN_OUTPUT_DIR }}_${{ vars.TAG_ENVIRONMENT }}
          mkdir -p ${{ github.workspace }}/templates/${{ vars.TF_VAR_FILES_DIR }}_${{ vars.TAG_ENVIRONMENT }}

      - name: Install Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: ${{ vars.TERRAFORM_VERSION }}

      - name: Create Terraform tfvars file
        id: create_terraform_tfvars_file
        run: |
          cat > ${{ github.workspace }}/templates/${{ vars.TF_VAR_FILES_DIR }}_${{ vars.TAG_ENVIRONMENT }}/variables-${{ vars.TAG_ENVIRONMENT }}.tfvars << EOF

          ### Virtual Machine variables ###
          vm-admin-username = "${{ vars.VM_ADMIN_USERNAME }}"
          vm-admin-password = "${{ secrets.VM_ADMIN_PASSWORD }}"

          vm-size-01 = "${{ vars.VM_SIZE_01 }}"

          vm-image-publisher = "${{ vars.VM_IMAGE_PUBLISHER }}"
          vm-image-offer = "${{ vars.VM_IMAGE_OFFER }}"
          vm-image-sku = "${{ vars.VM_IMAGE_SKU }}"
          vm-image-version = "${{ vars.VM_IMAGE_VERSION }}"

          vm-db-image-publisher = "${{ vars.VM_DB_IMAGE_PUBLISHER }}"
          vm-db-image-offer = "${{ vars.VM_DB_IMAGE_OFFER }}"
          vm-db-image-sku = "${{ vars.VM_DB_IMAGE_SKU }}"
          vm-db-image-version = "${{ vars.VM_DB_IMAGE_VERSION }}"
          vm-type = "${{ vars.VM_TYPE }}"

          ### Name concatenation variables ###
          project-short-description = "${{ vars.PROJECT_SHORT_DESCRIPTION }}"

          ### Tags variables ###
          tag-country             = "${{ vars.TAG_COUNTRY }}"
          tag-market              = "${{ vars.TAG_MARKET}}"
          tag-platform            = "${{ vars.TAG_PLATFORM }}"
          tag-department          = "${{ vars.TAG_DEPARTMENT }}"
          tag-environment         = "${{ vars.TAG_ENVIRONMENT }}"
          tag-geographic-location = "${{ vars.TAG_GEOGRAPHIC_LOCATION }}"
          tag-project-description = "${{ vars.TAG_PROJECT_DESCRIPTION }}"
          tag-project-name        = "${{ vars.TAG_PROJECT_NAME }}"
          tag-project-owner       = "${{ vars.TAG_PROJECT_OWNER }}"
          tag-solution-name       = "${{ vars.TAG_SOLUTION_NAME }}"
          tag-roledescription     = "${{ vars.TAG_ROLEDESCRIPTION }}"
          tag-usecase             = "${{ vars.TAG_USECASE }}"
          tag-deployed-date       = "${{ vars.TAG_DEPLOYED_DATE }}"
          tag-cost-center         = "${{ vars.TAG_COST_CENTER }}"
          deployed-by             = "${{ vars.DEPLOYED_BY }}"


          EOF

          terraform fmt ${{ github.workspace }}/templates/${{ vars.TF_VAR_FILES_DIR }}_${{ vars.TAG_ENVIRONMENT }}/variables-${{ vars.TAG_ENVIRONMENT }}.tfvars || exit 1

          cat ${{ github.workspace }}/templates/${{ vars.TF_VAR_FILES_DIR }}_${{ vars.TAG_ENVIRONMENT }}/variables-${{ vars.TAG_ENVIRONMENT }}.tfvars

      - name: Set tfvars_file_content output
        id: set_terraform_tfvars_file
        run: |
          FILE_PATH=${{ github.workspace }}/templates/${{ vars.TF_VAR_FILES_DIR }}_${{ vars.TAG_ENVIRONMENT }}/variables-${{ vars.TAG_ENVIRONMENT }}.tfvars
          FILE_CONTENT=$(cat $FILE_PATH)
          BINARY_ENCRYPTED_SECRET=$(echo -n "$FILE_CONTENT" | openssl enc -aes-256-cbc -pbkdf2 -salt -k "${{ secrets.GH_PAT }}" -base64)
          ENCRYPTED_SECRET=$(echo -n "$BINARY_ENCRYPTED_SECRET" | base64 -w 0)
          echo "tfvars_file_content=$ENCRYPTED_SECRET" >> $GITHUB_OUTPUT
