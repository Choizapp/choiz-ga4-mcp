# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 2.x     | Yes       |
| < 2.0   | No        |

## Reporting a Vulnerability

If you discover a security vulnerability, please open a GitHub issue in this repository or contact the maintainers directly. Do not include sensitive details (credentials, property IDs) in public issue reports.

## Credential Security

This server authenticates with Google APIs using a **service account JSON key file**.

### Best Practices

1. **Restrict file permissions** — The credentials file should only be readable by its owner:
   ```bash
   chmod 600 /path/to/service-account-key.json
   ```
   On Windows, restrict access via File Properties > Security.

2. **Use the minimum required scope** — The service account only needs the `analytics.readonly` scope:
   ```
   https://www.googleapis.com/auth/analytics.readonly
   ```
   Grant only **Viewer** role on the GA4 property (never Editor or Administrator).

3. **Never commit credentials** — The `.gitignore` excludes `*.json` credential files and `.env`. Verify this before pushing.

4. **Rotate keys periodically** — Rotate service account keys every 90 days via Google Cloud Console > IAM & Admin > Service Accounts.

5. **Use environment variables** — Always reference credentials via `GOOGLE_APPLICATION_CREDENTIALS` env var, never hardcode paths in source code.

## Data Access Scope

This MCP server operates in **read-only** mode. It can:
- Query GA4 reporting data (dimensions, metrics, date ranges)
- Access property metadata and schema

It **cannot**:
- Write, modify, or delete any GA4 data
- Access Google Ads data
- Access any data outside the configured GA4 property

## External Network Connections

This server only connects to:
- `analyticsdata.googleapis.com` — GA4 Data API (reporting)
- `analyticsadmin.googleapis.com` — GA4 Admin API (metadata)
- Google OAuth/auth endpoints for service account authentication

No data is sent to any third-party servers.
