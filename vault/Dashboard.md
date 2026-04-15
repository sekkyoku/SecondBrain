# Vault Dashboard

## All Active Notes
```dataview
TABLE type, status, updated
FROM ""
WHERE type != null
SORT updated DESC
```

## Deal Types
```dataview
TABLE deal_type, cpm_type, serving
FROM "Deal Types"
```

## Operations Notes
```dataview
LIST
FROM "Operations"
```