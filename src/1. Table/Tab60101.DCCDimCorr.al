table 60101 "DCC Dim Corr"
{
    Caption = 'DCC Dimension Correction';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Dimension 1"; Code[20])
        {
            Caption = 'Dimension 1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard));
        }
        field(3; "Dimension 2"; Code[20])
        {
            Caption = 'Dimension 2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard));
        }
        field(4; "Dimension 3"; Code[20])
        {
            Caption = 'Dimension 3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard));
        }
        field(5; "Dimension 4"; Code[20])
        {
            Caption = 'Dimension 4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard));
        }
        field(6; "Dimension 5"; Code[20])
        {
            Caption = 'Dimension 5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard));
        }
        field(7; "Dimension 6"; Code[20])
        {
            Caption = 'Dimension 6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard));
        }
        field(8; "Dimension 7"; Code[20])
        {
            Caption = 'Dimension 7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard));
        }
        field(9; "Dimension 8"; Code[20])
        {
            Caption = 'Dimension 8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard));
        }
        field(10; "Table Name"; Text[50])
        {
            Caption = 'Table Name';
            DataClassification = ToBeClassified;
        }
        field(11; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
        }
        field(12; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            DataClassification = ToBeClassified;
        }
        field(13; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(14; "Primary Key 1"; Text[30])
        {
            Caption = 'Primary Key 1';
            DataClassification = ToBeClassified;
        }
        field(15; "Primary Key 2"; Text[30])
        {
            Caption = 'Primary Key 2';
            DataClassification = ToBeClassified;
        }
        field(16; "Primary Key 3"; Text[30])
        {
            Caption = 'Primary Key 3';
            DataClassification = ToBeClassified;
        }
        field(17; "Primary Key 4"; Text[30])
        {
            Caption = 'Primary Key 4';
            DataClassification = ToBeClassified;
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    var
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimValue(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimCorr: Page "Dimension Correction";
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, Rec."New Dimension Set ID");
        DimCorr.Update();
    end;

}
