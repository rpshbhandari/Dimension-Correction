table 60100 "DCC Dim Corr Setup"
{
    Caption = 'DCC Dimension Correction Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Table Id';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));

            trigger OnValidate()
            begin
                if "Table Id" = 0 then
                    "Table Caption" := ''
                else begin
                    RecRef.Open("Table Id");
                    "Table Caption" := RecRef.Caption;
                end;
            end;
        }
        field(17; "Table Caption"; Text[30])
        {
            Caption = 'Table Caption';
            DataClassification = ToBeClassified;
        }
        field(2; "Dimension 1 - Field No."; Integer)
        {
            Caption = 'Dimension 1 - Field No. 1';
            DataClassification = ToBeClassified;
        }
        field(3; "Dimension 2 - Field No."; Integer)
        {
            Caption = 'Dimension 2 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Dimension 3 - Field No."; Integer)
        {
            Caption = 'Dimension 3 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Dimension 4 - Field No."; Integer)
        {
            Caption = 'Dimension 4 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Dimension 5 - Field No."; Integer)
        {
            Caption = 'Dimension 5 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Dimension 6 - Field No."; Integer)
        {
            Caption = 'Dimension 6 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Dimension 7 - Field No."; Integer)
        {
            Caption = 'Dimension 7 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Dimension 8 - Field No."; Integer)
        {
            Caption = 'Dimension 8 - Field No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Document No. Field No."; Integer)
        {
            Caption = 'Document No. Filed No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Dimension Set Id - Field No."; Integer)
        {
            Caption = 'Dimension Set Id - Field No.';
            DataClassification = ToBeClassified;
        }
        field(12; "Primary Key 1"; Integer)
        {
            Caption = 'Primary Key 1';
            DataClassification = ToBeClassified;
        }
        field(13; "Primary Key 2"; Integer)
        {
            Caption = 'Primary Key 2';
            DataClassification = ToBeClassified;
        }
        field(14; "Primary Key 3"; Integer)
        {
            Caption = 'Primary Key 3';
            DataClassification = ToBeClassified;
        }
        field(15; "Primary Key 4"; Integer)
        {
            Caption = 'Primary Key 4';
            DataClassification = ToBeClassified;
        }
        field(16; Skip; Boolean)
        {
            Caption = 'Skip';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Table Id")
        {
            Clustered = true;
        }
    }

    var
        RecRef: RecordRef;

    procedure CheckSetup(TableId: Integer)
    begin
        Get(TableId);
        case true of
            "Primary Key 1" = 0:
                Error('No Primary Key field is defined for Table ID %1.', TableId);
            "Dimension Set Id - Field No." = 0:
                Error('No Dimension Set Id field is defined for Table ID %1.', TableId);
            "Document No. Field No." = 0:
                Error('No Document No. field is defined for Table ID %1.', TableId);
        end;
    end;
}
