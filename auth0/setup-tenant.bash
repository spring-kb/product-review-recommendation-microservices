#!/usr/bin/env bash

source env.bash

CLIENT_REDIRECT_URI=https://my.redirect.uri
API_NAME=product-composite
API_URL=https://localhost:8443/product-composite

# set -x
set -e

AT=$(curl -s --request POST \
  --url https://$TENANT/oauth/token \
  --header 'content-type: application/json' \
  --data "{\"client_id\":\"$MGM_CLIENT_ID\",\"client_secret\":\"$MGM_CLIENT_SECRET\",\"audience\":\"https://$TENANT/api/v2/\",\"grant_type\":\"client_credentials\"}" | jq -r .access_token)

AT=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Im9zSlZseUEzM0NtbVdDX1FDenNSbSJ9.eyJpc3MiOiJodHRwczovL2Rldi1xOG4wYzBldGdvZmI3Z3BkLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJsaWEwaGFQemdzc21zMzlQbEg0SDAzOEVMd0FOMUlWc0BjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9kZXYtcThuMGMwZXRnb2ZiN2dwZC51cy5hdXRoMC5jb20vYXBpL3YyLyIsImlhdCI6MTc5MjQ5MjQxNSwiZXhwIjoxNzkyNTc4ODE1LCJzY29wZSI6InJlYWQ6Y2xpZW50X2dyYW50cyBjcmVhdGU6Y2xpZW50X2dyYW50cyBkZWxldGU6Y2xpZW50X2dyYW50cyB1cGRhdGU6Y2xpZW50X2dyYW50cyByZWFkOnVzZXJzIHVwZGF0ZTp1c2VycyBkZWxldGU6dXNlcnMgY3JlYXRlOnVzZXJzIHJlYWQ6dXNlcnNfYXBwX21ldGFkYXRhIHVwZGF0ZTp1c2Vyc19hcHBfbWV0YWRhdGEgZGVsZXRlOnVzZXJzX2FwcF9tZXRhZGF0YSBjcmVhdGU6dXNlcnNfYXBwX21ldGFkYXRhIHJlYWQ6dXNlcl9jdXN0b21fYmxvY2tzIGNyZWF0ZTp1c2VyX2N1c3RvbV9ibG9ja3MgZGVsZXRlOnVzZXJfY3VzdG9tX2Jsb2NrcyBjcmVhdGU6dXNlcl90aWNrZXRzIHJlYWQ6Y2xpZW50cyB1cGRhdGU6Y2xpZW50cyBkZWxldGU6Y2xpZW50cyBjcmVhdGU6Y2xpZW50cyByZWFkOmNsaWVudF9rZXlzIHVwZGF0ZTpjbGllbnRfa2V5cyBkZWxldGU6Y2xpZW50X2tleXMgY3JlYXRlOmNsaWVudF9rZXlzIHJlYWQ6Y2xpZW50X2NyZWRlbnRpYWxzIHVwZGF0ZTpjbGllbnRfY3JlZGVudGlhbHMgZGVsZXRlOmNsaWVudF9jcmVkZW50aWFscyBjcmVhdGU6Y2xpZW50X2NyZWRlbnRpYWxzIHJlYWQ6Y29ubmVjdGlvbnMgdXBkYXRlOmNvbm5lY3Rpb25zIGRlbGV0ZTpjb25uZWN0aW9ucyBjcmVhdGU6Y29ubmVjdGlvbnMgcmVhZDpyZXNvdXJjZV9zZXJ2ZXJzIHVwZGF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIGRlbGV0ZTpyZXNvdXJjZV9zZXJ2ZXJzIGNyZWF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIHJlYWQ6ZGV2aWNlX2NyZWRlbnRpYWxzIHVwZGF0ZTpkZXZpY2VfY3JlZGVudGlhbHMgZGVsZXRlOmRldmljZV9jcmVkZW50aWFscyBjcmVhdGU6ZGV2aWNlX2NyZWRlbnRpYWxzIHJlYWQ6cnVsZXMgdXBkYXRlOnJ1bGVzIGRlbGV0ZTpydWxlcyBjcmVhdGU6cnVsZXMgcmVhZDpydWxlc19jb25maWdzIHVwZGF0ZTpydWxlc19jb25maWdzIGRlbGV0ZTpydWxlc19jb25maWdzIHJlYWQ6aG9va3MgdXBkYXRlOmhvb2tzIGRlbGV0ZTpob29rcyBjcmVhdGU6aG9va3MgcmVhZDphY3Rpb25zIHVwZGF0ZTphY3Rpb25zIGRlbGV0ZTphY3Rpb25zIGNyZWF0ZTphY3Rpb25zIHJlYWQ6ZW1haWxfcHJvdmlkZXIgdXBkYXRlOmVtYWlsX3Byb3ZpZGVyIGRlbGV0ZTplbWFpbF9wcm92aWRlciBjcmVhdGU6ZW1haWxfcHJvdmlkZXIgYmxhY2tsaXN0OnRva2VucyByZWFkOnN0YXRzIHJlYWQ6aW5zaWdodHMgcmVhZDp0ZW5hbnRfc2V0dGluZ3MgdXBkYXRlOnRlbmFudF9zZXR0aW5ncyByZWFkOmxvZ3MgcmVhZDpsb2dzX3VzZXJzIHJlYWQ6c2hpZWxkcyBjcmVhdGU6c2hpZWxkcyB1cGRhdGU6c2hpZWxkcyBkZWxldGU6c2hpZWxkcyByZWFkOmFub21hbHlfYmxvY2tzIGRlbGV0ZTphbm9tYWx5X2Jsb2NrcyB1cGRhdGU6dHJpZ2dlcnMgcmVhZDp0cmlnZ2VycyByZWFkOmdyYW50cyBkZWxldGU6Z3JhbnRzIHJlYWQ6Z3VhcmRpYW5fZmFjdG9ycyB1cGRhdGU6Z3VhcmRpYW5fZmFjdG9ycyByZWFkOmd1YXJkaWFuX2Vucm9sbG1lbnRzIGRlbGV0ZTpndWFyZGlhbl9lbnJvbGxtZW50cyBjcmVhdGU6Z3VhcmRpYW5fZW5yb2xsbWVudF90aWNrZXRzIHJlYWQ6dXNlcl9pZHBfdG9rZW5zIGNyZWF0ZTpwYXNzd29yZHNfY2hlY2tpbmdfam9iIGRlbGV0ZTpwYXNzd29yZHNfY2hlY2tpbmdfam9iIHJlYWQ6Y3VzdG9tX2RvbWFpbnMgZGVsZXRlOmN1c3RvbV9kb21haW5zIGNyZWF0ZTpjdXN0b21fZG9tYWlucyB1cGRhdGU6Y3VzdG9tX2RvbWFpbnMgcmVhZDplbWFpbF90ZW1wbGF0ZXMgY3JlYXRlOmVtYWlsX3RlbXBsYXRlcyB1cGRhdGU6ZW1haWxfdGVtcGxhdGVzIHJlYWQ6bWZhX3BvbGljaWVzIHVwZGF0ZTptZmFfcG9saWNpZXMgcmVhZDpyb2xlcyBjcmVhdGU6cm9sZXMgZGVsZXRlOnJvbGVzIHVwZGF0ZTpyb2xlcyByZWFkOnByb21wdHMgdXBkYXRlOnByb21wdHMgcmVhZDpicmFuZGluZyB1cGRhdGU6YnJhbmRpbmcgZGVsZXRlOmJyYW5kaW5nIHJlYWQ6bG9nX3N0cmVhbXMgY3JlYXRlOmxvZ19zdHJlYW1zIGRlbGV0ZTpsb2dfc3RyZWFtcyB1cGRhdGU6bG9nX3N0cmVhbXMgY3JlYXRlOnNpZ25pbmdfa2V5cyByZWFkOnNpZ25pbmdfa2V5cyB1cGRhdGU6c2lnbmluZ19rZXlzIHJlYWQ6bGltaXRzIHVwZGF0ZTpsaW1pdHMgY3JlYXRlOnJvbGVfbWVtYmVycyByZWFkOnJvbGVfbWVtYmVycyBkZWxldGU6cm9sZV9tZW1iZXJzIHJlYWQ6ZW50aXRsZW1lbnRzIHJlYWQ6YXR0YWNrX3Byb3RlY3Rpb24gdXBkYXRlOmF0dGFja19wcm90ZWN0aW9uIHJlYWQ6b3JnYW5pemF0aW9uc19zdW1tYXJ5IGNyZWF0ZTphdXRoZW50aWNhdGlvbl9tZXRob2RzIHJlYWQ6YXV0aGVudGljYXRpb25fbWV0aG9kcyB1cGRhdGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyBkZWxldGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyByZWFkOm9yZ2FuaXphdGlvbnMgdXBkYXRlOm9yZ2FuaXphdGlvbnMgY3JlYXRlOm9yZ2FuaXphdGlvbnMgZGVsZXRlOm9yZ2FuaXphdGlvbnMgcmVhZDpvcmdhbml6YXRpb25fZGlzY292ZXJ5X2RvbWFpbnMgdXBkYXRlOm9yZ2FuaXphdGlvbl9kaXNjb3ZlcnlfZG9tYWlucyBjcmVhdGU6b3JnYW5pemF0aW9uX2Rpc2NvdmVyeV9kb21haW5zIGRlbGV0ZTpvcmdhbml6YXRpb25fZGlzY292ZXJ5X2RvbWFpbnMgY3JlYXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcnMgZGVsZXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIGNyZWF0ZTpvcmdhbml6YXRpb25fY29ubmVjdGlvbnMgcmVhZDpvcmdhbml6YXRpb25fY29ubmVjdGlvbnMgdXBkYXRlOm9yZ2FuaXphdGlvbl9jb25uZWN0aW9ucyBkZWxldGU6b3JnYW5pemF0aW9uX2Nvbm5lY3Rpb25zIGNyZWF0ZTpvcmdhbml6YXRpb25fbWVtYmVyX3JvbGVzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBkZWxldGU6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBjcmVhdGU6b3JnYW5pemF0aW9uX2ludml0YXRpb25zIHJlYWQ6b3JnYW5pemF0aW9uX2ludml0YXRpb25zIGRlbGV0ZTpvcmdhbml6YXRpb25faW52aXRhdGlvbnMgcmVhZDpzY2ltX2NvbmZpZyBjcmVhdGU6c2NpbV9jb25maWcgdXBkYXRlOnNjaW1fY29uZmlnIGRlbGV0ZTpzY2ltX2NvbmZpZyBjcmVhdGU6c2NpbV90b2tlbiByZWFkOnNjaW1fdG9rZW4gZGVsZXRlOnNjaW1fdG9rZW4gcmVhZDpkaXJlY3RvcnlfcHJvdmlzaW9uaW5ncyBjcmVhdGU6ZGlyZWN0b3J5X3Byb3Zpc2lvbmluZ3MgdXBkYXRlOmRpcmVjdG9yeV9wcm92aXNpb25pbmdzIGRlbGV0ZTpkaXJlY3RvcnlfcHJvdmlzaW9uaW5ncyBkZWxldGU6cGhvbmVfcHJvdmlkZXJzIGNyZWF0ZTpwaG9uZV9wcm92aWRlcnMgcmVhZDpwaG9uZV9wcm92aWRlcnMgdXBkYXRlOnBob25lX3Byb3ZpZGVycyBkZWxldGU6cGhvbmVfdGVtcGxhdGVzIGNyZWF0ZTpwaG9uZV90ZW1wbGF0ZXMgcmVhZDpwaG9uZV90ZW1wbGF0ZXMgdXBkYXRlOnBob25lX3RlbXBsYXRlcyBjcmVhdGU6ZW5jcnlwdGlvbl9rZXlzIHJlYWQ6ZW5jcnlwdGlvbl9rZXlzIHVwZGF0ZTplbmNyeXB0aW9uX2tleXMgZGVsZXRlOmVuY3J5cHRpb25fa2V5cyByZWFkOnNlc3Npb25zIHVwZGF0ZTpzZXNzaW9ucyBkZWxldGU6c2Vzc2lvbnMgcmVhZDpyZWZyZXNoX3Rva2VucyB1cGRhdGU6cmVmcmVzaF90b2tlbnMgZGVsZXRlOnJlZnJlc2hfdG9rZW5zIGNyZWF0ZTpzZWxmX3NlcnZpY2VfcHJvZmlsZXMgcmVhZDpzZWxmX3NlcnZpY2VfcHJvZmlsZXMgdXBkYXRlOnNlbGZfc2VydmljZV9wcm9maWxlcyBkZWxldGU6c2VsZl9zZXJ2aWNlX3Byb2ZpbGVzIGNyZWF0ZTpzc29fYWNjZXNzX3RpY2tldHMgZGVsZXRlOnNzb19hY2Nlc3NfdGlja2V0cyByZWFkOmZvcm1zIHVwZGF0ZTpmb3JtcyBkZWxldGU6Zm9ybXMgY3JlYXRlOmZvcm1zIHJlYWQ6Zmxvd3MgdXBkYXRlOmZsb3dzIGRlbGV0ZTpmbG93cyBjcmVhdGU6Zmxvd3MgcmVhZDpmbG93c192YXVsdCByZWFkOmZsb3dzX3ZhdWx0X2Nvbm5lY3Rpb25zIHVwZGF0ZTpmbG93c192YXVsdF9jb25uZWN0aW9ucyBkZWxldGU6Zmxvd3NfdmF1bHRfY29ubmVjdGlvbnMgY3JlYXRlOmZsb3dzX3ZhdWx0X2Nvbm5lY3Rpb25zIHJlYWQ6Zmxvd3NfZXhlY3V0aW9ucyBkZWxldGU6Zmxvd3NfZXhlY3V0aW9ucyByZWFkOmNvbm5lY3Rpb25zX29wdGlvbnMgdXBkYXRlOmNvbm5lY3Rpb25zX29wdGlvbnMgcmVhZDpzZWxmX3NlcnZpY2VfcHJvZmlsZV9jdXN0b21fdGV4dHMgdXBkYXRlOnNlbGZfc2VydmljZV9wcm9maWxlX2N1c3RvbV90ZXh0cyBjcmVhdGU6bmV0d29ya19hY2xzIHVwZGF0ZTpuZXR3b3JrX2FjbHMgcmVhZDpuZXR3b3JrX2FjbHMgZGVsZXRlOm5ldHdvcmtfYWNscyBkZWxldGU6dmRjc190ZW1wbGF0ZXMgcmVhZDp2ZGNzX3RlbXBsYXRlcyBjcmVhdGU6dmRjc190ZW1wbGF0ZXMgdXBkYXRlOnZkY3NfdGVtcGxhdGVzIGNyZWF0ZTpjdXN0b21fc2lnbmluZ19rZXlzIHJlYWQ6Y3VzdG9tX3NpZ25pbmdfa2V5cyB1cGRhdGU6Y3VzdG9tX3NpZ25pbmdfa2V5cyBkZWxldGU6Y3VzdG9tX3NpZ25pbmdfa2V5cyByZWFkOmZlZGVyYXRlZF9jb25uZWN0aW9uc190b2tlbnMgZGVsZXRlOmZlZGVyYXRlZF9jb25uZWN0aW9uc190b2tlbnMgY3JlYXRlOnVzZXJfYXR0cmlidXRlX3Byb2ZpbGVzIHJlYWQ6dXNlcl9hdHRyaWJ1dGVfcHJvZmlsZXMgdXBkYXRlOnVzZXJfYXR0cmlidXRlX3Byb2ZpbGVzIGRlbGV0ZTp1c2VyX2F0dHJpYnV0ZV9wcm9maWxlcyByZWFkOmV2ZW50X3N0cmVhbXMgY3JlYXRlOmV2ZW50X3N0cmVhbXMgZGVsZXRlOmV2ZW50X3N0cmVhbXMgdXBkYXRlOmV2ZW50X3N0cmVhbXMgcmVhZDpldmVudF9kZWxpdmVyaWVzIHVwZGF0ZTpldmVudF9kZWxpdmVyaWVzIGNyZWF0ZTpjb25uZWN0aW9uX3Byb2ZpbGVzIHJlYWQ6Y29ubmVjdGlvbl9wcm9maWxlcyB1cGRhdGU6Y29ubmVjdGlvbl9wcm9maWxlcyBkZWxldGU6Y29ubmVjdGlvbl9wcm9maWxlcyBjcmVhdGU6Z3JvdXBzIHJlYWQ6Z3JvdXBzIHVwZGF0ZTpncm91cHMgZGVsZXRlOmdyb3VwcyByZWFkOmdyb3VwX21lbWJlcnMgY3JlYXRlOmdyb3VwX3JvbGVzIGRlbGV0ZTpncm91cF9yb2xlcyByZWFkOnVzZXJfZWZmZWN0aXZlX3Blcm1pc3Npb25zIHJlYWQ6dXNlcl9lZmZlY3RpdmVfcm9sZXMgcmVhZDpvcmdhbml6YXRpb25fbWVtYmVyX2VmZmVjdGl2ZV9yb2xlcyByZWFkOnVzZXJfcm9sZV9zb3VyY2VfZ3JvdXBzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlX3NvdXJjZV9ncm91cHMgcmVhZDp1c2VyX3Blcm1pc3Npb25fc291cmNlX3JvbGVzIHJlYWQ6Z3JvdXBfcm9sZXMgcmVhZDpvcmdhbml6YXRpb25fZ3JvdXBzIGNyZWF0ZTpvcmdhbml6YXRpb25fZ3JvdXBzIGRlbGV0ZTpvcmdhbml6YXRpb25fZ3JvdXBzIHJlYWQ6b3JnYW5pemF0aW9uX2dyb3VwX3JvbGVzIGNyZWF0ZTpvcmdhbml6YXRpb25fZ3JvdXBfcm9sZXMgZGVsZXRlOm9yZ2FuaXphdGlvbl9ncm91cF9yb2xlcyBjcmVhdGU6dG9rZW5fZXhjaGFuZ2VfcHJvZmlsZXMgcmVhZDp0b2tlbl9leGNoYW5nZV9wcm9maWxlcyB1cGRhdGU6dG9rZW5fZXhjaGFuZ2VfcHJvZmlsZXMgZGVsZXRlOnRva2VuX2V4Y2hhbmdlX3Byb2ZpbGVzIHJlYWQ6b3JnYW5pemF0aW9uX2NsaWVudF9ncmFudHMgY3JlYXRlOm9yZ2FuaXphdGlvbl9jbGllbnRfZ3JhbnRzIGRlbGV0ZTpvcmdhbml6YXRpb25fY2xpZW50X2dyYW50cyByZWFkOm9yZ2FuaXphdGlvbl9jbGllbnRzIGNyZWF0ZTpvcmdhbml6YXRpb25fY2xpZW50cyB1cGRhdGU6b3JnYW5pemF0aW9uX2NsaWVudHMgZGVsZXRlOm9yZ2FuaXphdGlvbl9jbGllbnRzIHJlYWQ6ZXZlbnRzIGNyZWF0ZTpyYXRlX2xpbWl0X3BvbGljaWVzIHJlYWQ6cmF0ZV9saW1pdF9wb2xpY2llcyB1cGRhdGU6cmF0ZV9saW1pdF9wb2xpY2llcyBkZWxldGU6cmF0ZV9saW1pdF9wb2xpY2llcyBjcmVhdGU6cG9ydGFscyByZWFkOnBvcnRhbHMgdXBkYXRlOnBvcnRhbHMgZGVsZXRlOnBvcnRhbHMgY3JlYXRlOm5ldHdvcmtfYWNsX2tleXMgdXBkYXRlOm5ldHdvcmtfYWNsX2tleXMgcmVhZDpuZXR3b3JrX2FjbF9rZXlzIGRlbGV0ZTpuZXR3b3JrX2FjbF9rZXlzIHJlYWQ6c2VjdXJpdHlfbWV0cmljcyByZWFkOmNvbm5lY3Rpb25zX2tleXMgdXBkYXRlOmNvbm5lY3Rpb25zX2tleXMgY3JlYXRlOmNvbm5lY3Rpb25zX2tleXMiLCJndHkiOiJjbGllbnQtY3JlZGVudGlhbHMiLCJhenAiOiJsaWEwaGFQemdzc21zMzlQbEg0SDAzOEVMd0FOMUlWcyJ9.Hq2rpAybvovyJrSU2XMMEgIAZwdxbG_QK9RpGJ26akKFAaO36TQwYtD4TUfCdgZA0jF0GM2g44yo2wCetg9u8lp3ixUjIuTQNyebtg_p2v5Unss60-rUUM1M-kyeoAGtEGOHwaAFkFHa6Z2CKcmcpTI8FMKDKcZ6c9-hcuLH5z_J_PxdDzbcIuy55uFdDHOiB11XF-dRHqkMhzCoavOC5_j5zm8zQCjmJylBGx9X6O6ODqrnIo2g11LvdsRP-T4L94UXmGh053YP1skExCWUgyhbGPTYKZ9FkwHtYYJI8xL8WxpKteFXyDNcJobN9ZJ0XcYshqNbhTyEWFC6Xx5kgQ
# Update the tenant
echo "Update the tenant, set its default connection to a user dictionary..."
curl -s -H "Authorization: Bearer $AT" -X PATCH  -H "Content-Type: application/json" -d '{"default_directory":"Username-Password-Authentication"}' https://$TENANT/api/v2/tenants/settings | jq .default_directory

# Create reader application
createClientBody='"callbacks":["https://my.redirect.uri"],"app_type":"non_interactive","grant_types":["authorization_code","implicit","refresh_token","client_credentials","password","http://auth0.com/oauth/grant-type/password-realm"],"oidc_conformant":true,"token_endpoint_auth_method":"client_secret_post"'
if [ ! -z $(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients?fields=name | jq -r '.[] | select(.name == "reader") | .name') ]
then
  echo "Reader client app already exists"
else
  echo "Creates reader client app..."
  curl -s -H "Authorization: Bearer $AT" -X POST -H "Content-Type: application/json" -d "{\"name\":\"reader\",$createClientBody}" https://$TENANT/api/v2/clients | jq .
fi
READER_CLIENT_ID=$(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients | jq -r '.[] | select(.name == "reader") | .client_id')
READER_CLIENT_SECRET=$(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients | jq -r '.[] | select(.name == "reader") | .client_secret')

# Create writer application
if [ ! -z $(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients?fields=name | jq -r '.[] | select(.name == "writer") | .name') ]
then
  echo "Writer client app already exists"
else
  echo "Creates writer client app..."
  curl -s -H "Authorization: Bearer $AT" -X POST -H "Content-Type: application/json" -d "{\"name\":\"writer\",$createClientBody}" https://$TENANT/api/v2/clients | jq .
fi
WRITER_CLIENT_ID=$(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients | jq -r '.[] | select(.name == "writer") | .client_id')
WRITER_CLIENT_SECRET=$(curl -s -H "Authorization: Bearer $AT" https://$TENANT/api/v2/clients | jq -r '.[] | select(.name == "writer") | .client_secret')

# Sleep 1 sec to avoid a "429: Too Many Requests, global limit has been reached"...'
sleep 1

# Create the API
if [ ! -z $(curl -s -H "Authorization: Bearer $AT" "https://$TENANT/api/v2/resource-servers" | jq -r ".[] | select(.name == \"$API_NAME\") | .name") ]
then
  echo "API $API_NAME ($API_URL) already exists"
else
  echo "Creates API $API_NAME ($API_URL)..."
  curl -s -H "Authorization: Bearer $AT" -X POST -H "Content-Type: application/json" -d "{\"name\": \"$API_NAME\", \"identifier\": \"$API_URL\", \"scopes\": [{ \"value\": \"product:read\", \"description\": \"Read product information\"}, {\"value\": \"product:write\", \"description\": \"Update product information\"}]}" https://$TENANT/api/v2/resource-servers | jq .
fi

# Create the user
if [ ! -z $(curl -s -H "Authorization: Bearer $AT" --get --data-urlencode "email=$USER_EMAIL" https://$TENANT/api/v2/users-by-email | jq -r ".[] | select(.email == \"$USER_EMAIL\") | .email") ]
then
  echo "User with email $USER_EMAIL already exists"
else
  echo "Creates user with email $USER_EMAIL..."
  curl -s -H "Authorization: Bearer $AT" -X POST  -H "Content-Type: application/json" -d "{\"email\": \"$USER_EMAIL\",  \"connection\": \"Username-Password-Authentication\", \"password\": \"$USER_PASSWORD\"}" https://$TENANT/api/v2/users | jq .
fi


# Grant access to the API for the reader client app
clientGrantsCount=$(curl -s -H "Authorization: Bearer $AT" --get --data-urlencode "audience=$API_URL" --data-urlencode "client_id=$READER_CLIENT_ID" https://$TENANT/api/v2/client-grants | jq length)
if [[ "$clientGrantsCount" -ne 0 ]]
then
  echo "Client grant for the reader app to access the $API_NAME API already exists"
else
  echo "Create client grant for the reader app to access the $API_NAME API..."
  curl -s -H "Authorization: Bearer $AT" -X POST  -H "Content-Type: application/json" -d "{\"client_id\":\"$READER_CLIENT_ID\",\"audience\":\"$API_URL\",\"scope\":[\"product:read\"]}" https://$TENANT/api/v2/client-grants | jq .
  echo
fi

# Grant access to the API for the writer client app
clientGrantsCount=$(curl -s -H "Authorization: Bearer $AT" --get --data-urlencode "audience=$API_URL" --data-urlencode "client_id=$WRITER_CLIENT_ID" https://$TENANT/api/v2/client-grants | jq length)
if [[ "$clientGrantsCount" -ne 0 ]]
then
  echo "Client grant for the writer app to access the $API_NAME API already exists"
else
  echo "Create client grant for the writer app to access the $API_NAME API..."
  curl -s -H "Authorization: Bearer $AT" -X POST  -H "Content-Type: application/json" -d "{\"client_id\":\"$WRITER_CLIENT_ID\",\"audience\":\"$API_URL\",\"scope\":[\"product:read\",\"product:write\"]}" https://$TENANT/api/v2/client-grants | jq .
  echo
fi

# Echo Auth0 - OAuth2 settings
echo
echo "Auth0 - OAuth2 settings:"
echo
echo export TENANT=$TENANT
echo export WRITER_CLIENT_ID=$WRITER_CLIENT_ID
echo export WRITER_CLIENT_SECRET=$WRITER_CLIENT_SECRET
echo export READER_CLIENT_ID=$READER_CLIENT_ID
echo export READER_CLIENT_SECRET=$READER_CLIENT_SECRET