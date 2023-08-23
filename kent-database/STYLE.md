# Coding Standards for SQL Functions

This document outlines the coding standards used in the provided SQL functions.

## Function Naming Convention

All function names should follow the format: `schema_name.function_name`.

For example:
- `kentdb.f_get_clarks`
- `kentdb.f_get_clark`
- `kentdb.f_update_clark_expiration`

## Indentation and Formatting

- Use consistent indentation with 4 spaces for each level of nesting.
- Use uppercase for SQL keywords to improve readability.
- Align the arguments of a function or a SELECT statement for clarity.

Example:
```sql
SELECT
    JSONB_BUILD_OBJECT(
        'id', clarks.id_clark,
        'serial', (SELECT kentdb.f_get_clark_serial(clarks.id_clark)),
        -- More fields...
    ) INTO v_clark
```

## Comments

Use comments to explain the purpose and logic of the code sections.
Place comments before each function definition to provide a brief description.

Example:

```sql
/*
**  kentdb.f_update_clark_expiration
**  Updates the expiration timestamp of a clark.
*/
CREATE OR REPLACE FUNCTION kentdb.f_update_clark_expiration (
    -- Function arguments...
) RETURNS JSONB AS $f_update_clark_expiration$
-- Function body...
```


## Error Handling

Use consistent error handling practices to ensure clear and informative error messages.
Utilize RAISE EXCEPTION statements to throw custom error messages.
Provide relevant error codes and additional information where necessary.

Example:

```sql
-- If clark does not exist, raise an exception with details.
RAISE EXCEPTION '{!}%{!}',
    JSONB_BUILD_OBJECT (
        'info', 'execko',
        'code', 404,
        'error', 'ERROR_CLARK_DOES_NOT_EXIST',
        'additional', JSONB_BUILD_OBJECT (
            'id', p_id_clark
        )
    )
;
```

## Additional Guidelines

Use consistent variable naming conventions. For example, prefix variables with v_ for local variables and p_ for parameters.
Break down complex expressions into multiple lines to improve readability.
Avoid using unnecessary parentheses.

Example:

```sql
UPDATE kentdb.ref_clarks AS clarks
SET ts_expiration = p_ts_expiration
WHERE clarks.id_clark = p_id_clark;
```

These coding standards are intended to improve the readability, maintainability, and consistency of the SQL code. Adhering to these standards will help in better collaboration and understanding of the codebase.

