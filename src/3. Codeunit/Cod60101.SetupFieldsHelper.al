codeunit 60101 "SetupFields Helper"
{
    Permissions =
        tabledata "DCC Dim Corr Setup" = RIMD,
        tabledata Field = r;



    trigger OnRun()
    var
        FieldRec: Record Field;
    begin
        PopulateSetupFields();
    end;

    procedure PopulateSetupFields()
    var
        DimCorrSetup: Record "DCC Dim Corr Setup";
        FieldRec: Record Field;
        a: Record 18;
    begin
        GetPrimaryKeyFields(18);

    end;

    procedure GetPrimaryKeyFields(TableId: Integer)
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        i: Integer;
        a: Record 18;
    begin
        RecRef.Open(TableId);
        Message('Number of keys: %1', RecRef.KeyCount());

        for i := 1 to RecRef.KeyCount do begin
            Message('Key %1 has %2 fields', i, RecRef.Field(i).Caption());
        end;
        RecRef.Close();
    end;


    procedure UpdateSetupTable(TableId: Integer; PrimaryKey1: Integer; PrimaryKey2: Integer; PrimaryKey3: Integer; PrimaryKey4: Integer; Dimension1FieldNo: Integer; Dimension2FieldNo: Integer; Dimension3FieldNo: Integer; Dimension4FieldNo: Integer; Dimension5FieldNo: Integer; Dimension6FieldNo: Integer; Dimension7FieldNo: Integer; Dimension8FieldNo: Integer; DocumentNoFieldNo: Integer)
    var
        DimCorrSetup: Record "DCC Dim Corr Setup";
    begin
        DimCorrSetup.Get(TableId);
        DimCorrSetup.Validate("Table Id", TableId);
        DimCorrSetup.Validate("Primary Key 1", PrimaryKey1);
        DimCorrSetup.Validate("Primary Key 2", PrimaryKey2);
        DimCorrSetup.Validate("Primary Key 3", PrimaryKey3);
        DimCorrSetup.Validate("Primary Key 4", PrimaryKey4);
        DimCorrSetup.Validate("Dimension 1 - Field No.", Dimension1FieldNo);
        DimCorrSetup.Validate("Dimension 2 - Field No.", Dimension2FieldNo);
        DimCorrSetup.Validate("Dimension 3 - Field No.", Dimension3FieldNo);
        DimCorrSetup.Validate("Dimension 4 - Field No.", Dimension4FieldNo);
        DimCorrSetup.Validate("Dimension 5 - Field No.", Dimension5FieldNo);
        DimCorrSetup.Validate("Dimension 6 - Field No.", Dimension6FieldNo);
        DimCorrSetup.Validate("Dimension 7 - Field No.", Dimension7FieldNo);
        DimCorrSetup.Validate("Dimension 8 - Field No.", Dimension8FieldNo);
        DimCorrSetup.Validate("Document No. Field No.", DocumentNoFieldNo);
        DimCorrSetup.Modify();
    end;
}