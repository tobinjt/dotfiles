# Global Antigravity Agent Guidelines

## Product, Hardware & Link Verification Rules

- **Never Trust Search Snippets Alone:** Search engine summary snippets, recalled SKU codes, and cached summaries frequently contain outdated, discontinued, or hallucinated product codes and URLs.
- **Mandatory Live Link Verification via `check_urls`:** When recommending specific products, hardware, components, or purchase links, always verify that the URL is live and active using `check_urls`. If the `check_urls` tool does not output the required information, the tool itself needs to be improved.
- **Verify Stock & Active SKUs:** Ensure the product is not discontinued, superseded, or out of stock. If a supplier has retired an item or replaced a SKU, locate the active replacement code or provide a verified in-stock trade alternative.
