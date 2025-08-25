# ConfigCat V2 Configuration Structure

## Overview

This directory contains a simple, file-based structure to manage ConfigCat infrastructure and feature flags. No complex variables or logic - just rename files when you need to switch modes.

## File Structure

### `main.tf`

- **Provider configuration** and shared module references
- **Data sources** for products and environments
- **Always active** - provides base configuration

### `infrastructure.tf` (Default Mode)

- **Uses existing infrastructure** via data sources
- **Safe for ongoing operations** - won't recreate infrastructure
- **Default mode** for feature flag management

### `create-infrastructure.tf`

- **Creates new infrastructure** (configs, segments)
- **Use only when needed** - rename to activate
- **Rename back after creation** to avoid conflicts

### `prod.tf`

- **Feature flag definitions** only
- **Uses local values** from infrastructure.tf
- **Safe to run multiple times** - won't recreate infrastructure

## Usage Workflow

### Step 1: Initial Setup (First Time Only)

1. **Rename files to create infrastructure**:

   ```bash
   mv infrastructure.tf infrastructure.tf.disabled
   mv create-infrastructure.tf infrastructure.tf
   ```

2. **Run terraform apply** to create infrastructure:

   ```bash
   terraform apply
   ```

3. **Rename files back** to use existing infrastructure:
   ```bash
   mv infrastructure.tf create-infrastructure.tf
   mv infrastructure.tf.disabled infrastructure.tf
   ```

### Step 2: Ongoing Management

1. **Keep** `infrastructure.tf` as the active file
2. **Add new feature flags** to `prod.tf`
3. **Run terraform apply** - only feature flags will be created/updated
4. **Infrastructure won't be recreated**

## How It Works

### File Naming Convention

```
infrastructure.tf                    ← Active file (uses existing infrastructure)
create-infrastructure.tf            ← Backup file (creates new infrastructure)
infrastructure.tf.disabled          ← Disabled file (inactive)
```

### When You Need New Infrastructure

```bash
# 1. Switch to creation mode
mv infrastructure.tf infrastructure.tf.disabled
mv create-infrastructure.tf infrastructure.tf

# 2. Create infrastructure
terraform apply

# 3. Switch back to usage mode
mv infrastructure.tf create-infrastructure.tf
mv infrastructure.tf.disabled infrastructure.tf
```

### Benefits of This Approach

✅ **Super Simple** - Just rename files, no complex logic
✅ **No Variables** - No need to remember variable names
✅ **Visual Clarity** - You can see which mode is active
✅ **Safe Operations** - Can't accidentally recreate infrastructure
✅ **Easy to Understand** - Clear file purpose and naming

## Example: Adding a New Feature Flag

Simply add to `prod.tf`:

```hcl
# New feature flag
resource "configcat_setting" "new_feature" {
  config_id    = local.config_id  # Automatically uses existing config
  key          = "newFeature"
  name         = "New Feature"
  order        = 7
  setting_type = "boolean"
}

resource "configcat_setting_value_v2" "new_feature_value" {
  environment_id = data.configcat_environments.prod_environment.environments.0.environment_id
  setting_id     = configcat_setting.new_feature.id
  value = { bool_value = true }
}
```

Then run:

```bash
terraform plan    # Review changes
terraform apply   # Apply only the new feature flag
```

## Infrastructure Control

### To Create New Infrastructure:

```bash
# Switch to creation mode
mv infrastructure.tf infrastructure.tf.disabled
mv create-infrastructure.tf infrastructure.tf

# Apply
terraform apply

# Switch back to usage mode
mv infrastructure.tf create-infrastructure.tf
mv infrastructure.tf.disabled infrastructure.tf
```

### To Use Existing Infrastructure:

```bash
# Ensure infrastructure.tf is the active file
# (should contain data sources, not resources)

# Apply (safe - won't recreate infrastructure)
terraform apply
```

## Troubleshooting

### If you get "name already in use" errors:

1. **Check** if infrastructure already exists in ConfigCat
2. **Ensure** `infrastructure.tf` contains data sources (not resources)
3. **Run** `terraform plan` to verify it's using existing resources

### If you need to recreate infrastructure:

1. **Delete** the resources manually in ConfigCat dashboard
2. **Switch to creation mode** using file renaming
3. **Run** `terraform apply`
4. **Switch back to usage mode** using file renaming

### File Status Check:

```bash
# Check which mode is active
ls -la infrastructure.tf*

# infrastructure.tf should exist and contain data sources
# create-infrastructure.tf should exist and contain resources
# infrastructure.tf.disabled should NOT exist (unless in creation mode)
```

## Current Configuration

- **Config**: "My config v2" (V2 evaluation)
- **Segment**: "Beta users" (email-based targeting)
- **Environment**: Production
- **Feature Flags**: 6 flags with various metadata and targeting rules
- **Active Mode**: Using existing infrastructure (infrastructure.tf active)
