# poc-configcat-atlantis

## Quick Start

### 1. Set Environment Variables

```bash
export CONFIGCAT_BASIC_AUTH_USERNAME="your_username"
export CONFIGCAT_BASIC_AUTH_PASSWORD="your_api_key"
```

```bash
export TF_VAR_configcat_basic_auth_username=="your_username"
export TF_VAR_configcat_basic_auth_password="your_api_key"
```

### 2. Navigate to Atlantis Directory

```bash
atlantis server \
--atlantis-url="$URL" \
--gh-user="$USERNAME" \
--gh-token="$TOKEN" \
--gh-webhook-secret="$SECRET" \
--repo-allowlist="$REPO_ALLOWLIST"
```

More details how to use this command: https://www.runatlantis.io/guide/testing-locally.html#github-command
