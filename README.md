# DCC Dimension Correction

This extension provides a controlled way to correct dimensions on posted documents and related ledger entries in Business Central.

It uses a setup-driven mapping between table fields and dimension fields, generates editable worksheet lines, and applies updates with an audit log.

## Installation

Download the zip from [Releases](https://github.com/rpshbhandari/Dimension-Correction/releases), extract the `.app` and deploy it to your Business Central environment.

## Main Objects

- Table `60100` - `DCC Dim Corr Setup`: Stores per-table field mapping (document no., primary keys, dimension fields, dimension set id field).
- Table `60101` - `DCC Dim Corr`: Temporary/working lines used in the worksheet.
- Table `60102` - `DCC Dim Corr Log`: Stores applied change history.
- Table `60103` - `DCC Dim Corr Doc List`: Stores a list of document numbers for batch generation.
- Page `60103` - `DCC Dim Corr Wksh`: Main worksheet for generating, editing, and applying corrections.
- Codeunit `60100` - `DCC Dim Corr Mgt`: Core generation/import/export/update logic.
- Codeunit `60101` - `SetupFields Helper`: Seeds default setup mappings.

## Process Flow

```mermaid
flowchart TD
	A[Open Worksheet: DCC Dim Corr Wksh] --> B{How to Generate Lines?}

	B -->|Single Document No.| C[Enter Document No.]
	C --> D[RebuildTempLinesFromDocumentNo]

	B -->|Document List| E[Maintain DCC Dim Corr Doc List]
	E --> F[Generate Entries]
	F --> G[RebuildTempLinesFromDocumentList]

	D --> H[AppendTempLinesForDocumentNo]
	G --> H

	H --> I[Read DCC Dim Corr Setup where Skip = false]
	I --> J[Open source tables dynamically via RecordRef]
	J --> K[Insert worksheet lines in DCC Dim Corr]

	K --> L[User edits Dimension 1..8]
	L --> M[ValidateShortcutDimValue updates New Dimension Set ID]

	M --> N[Update Entries action]
	N --> O[UpdateLedgerTables]
	O --> P[Resolve target record by Document No + Primary Keys]
	P --> Q[Write new dimension fields and Dimension Set ID]
	Q --> R[Modify source record]
	R --> S[Insert audit row into DCC Dim Corr Log]

	S --> T{Cleanup prompt}
	T -->|Yes| U[Delete DCC Dim Corr Doc List and worksheet lines]
	T -->|No| V[Keep generated data]
```

## Typical Usage

1. Open **DCC Dimension Correction Worksheet**.
2. Ensure **DCC Dim Corr Setup** is configured (or initialize via `SetupFields Helper`).
3. Generate lines:
   - Enter one document no. for targeted correction, or
   - Add multiple document no. values in document list and run **Generate Entries**.
4. Review lines and adjust Dimension 1..8 values as needed.
5. Run **Update Entries** to apply changes.
6. Review **Correction Log** for traceability.

## Notes

- Setup must include at least one primary key field and document no. field for each target table.
- The update logic applies only to tables configured with `Skip = false`.
- Excel import/export actions are available in on-prem environments from the worksheet page.
