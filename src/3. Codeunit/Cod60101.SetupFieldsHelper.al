codeunit 60101 "SetupFields Helper"
{
    Permissions =
        tabledata "DCC Dim Corr Setup" = RIMD;

    trigger OnRun()
    var
        FieldRec: Record Field;
    begin
        PopulateSetupFields();
    end;

    procedure PopulateSetupFields()
    var
    begin
        InsertSetupFields(17, 1, 0, 0, 0, 23, 24, 481, 482, 483, 484, 485, 486, 480, 6, false);
        InsertSetupFields(21, 1, 0, 0, 0, 23, 24, 481, 482, 483, 484, 485, 486, 480, 6, false);
        InsertSetupFields(25, 1, 0, 0, 0, 23, 24, 481, 482, 483, 484, 485, 486, 480, 6, false);
        InsertSetupFields(32, 1, 0, 0, 0, 33, 34, 481, 482, 483, 484, 485, 486, 480, 6, false);
        InsertSetupFields(112, 3, 0, 0, 0, 29, 30, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(113, 3, 4, 0, 0, 40, 41, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(114, 3, 0, 0, 0, 29, 30, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(115, 3, 0, 0, 0, 40, 41, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(122, 3, 0, 0, 0, 29, 30, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(123, 3, 4, 0, 0, 40, 41, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(124, 3, 0, 0, 0, 29, 30, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(125, 3, 4, 0, 0, 40, 41, 0, 0, 0, 0, 0, 0, 480, 3, false);
        InsertSetupFields(271, 1, 0, 0, 0, 23, 24, 481, 482, 483, 484, 485, 486, 480, 6, false);
        InsertSetupFields(379, 1, 0, 0, 0, 21, 22, 0, 0, 0, 0, 0, 0, 0, 6, false);
        InsertSetupFields(380, 1, 0, 0, 0, 21, 22, 0, 0, 0, 0, 0, 0, 0, 6, false);
        InsertSetupFields(5744, 1, 0, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 480, 1, false);
        InsertSetupFields(5745, 1, 2, 0, 0, 8, 9, 0, 0, 0, 0, 0, 0, 480, 1, false);
        InsertSetupFields(5746, 1, 0, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 480, 1, false);
        InsertSetupFields(5747, 1, 2, 0, 0, 8, 9, 0, 0, 0, 0, 0, 0, 480, 1, false);
        InsertSetupFields(5802, 1, 0, 0, 0, 33, 34, 481, 482, 483, 484, 485, 486, 480, 6, false);
    end;

    procedure InsertSetupFields(TableId: Integer; PrimaryKey1: Integer; PrimaryKey2: Integer; PrimaryKey3: Integer; PrimaryKey4: Integer; Dimension1FieldNo: Integer; Dimension2FieldNo: Integer; Dimension3FieldNo: Integer; Dimension4FieldNo: Integer; Dimension5FieldNo: Integer; Dimension6FieldNo: Integer; Dimension7FieldNo: Integer; Dimension8FieldNo: Integer; DimensionSetIdFieldNo: Integer; DocumentNoFieldNo: Integer; Skip: Boolean)
    var
        DimCorrSetup: Record "DCC Dim Corr Setup";
    begin
        if DimCorrSetup.Get(TableId) then begin
            Message('Setup fields for table %1 already exist. Skipping insert.', TableId);
            exit;
        end;
        DimCorrSetup.Init();
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
        DimCorrSetup.Validate("Dimension Set Id - Field No.", DimensionSetIdFieldNo);
        DimCorrSetup.Validate("Document No. Field No.", DocumentNoFieldNo);
        DimCorrSetup.Validate("Skip", Skip);
        DimCorrSetup.Insert();
    end;
}