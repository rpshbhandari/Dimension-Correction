page 60102 "DCC Dim Corr Log List"
{
    PageType = List;
    SourceTable = "DCC Dim Corr Log";
    Caption = 'DCC Dimension Correction Log';
    ApplicationArea = All;
    UsageCategory = Lists;
    // Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("New Dimension Set ID"; Rec."New Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Key 1"; Rec."Primary Key 1")
                {
                    ApplicationArea = All;
                }
                field("Primary Key 2"; Rec."Primary Key 2")
                {
                    ApplicationArea = All;
                }
                field("Primary Key 3"; Rec."Primary Key 3")
                {
                    ApplicationArea = All;
                }
                field("Primary Key 4"; Rec."Primary Key 4")
                {
                    ApplicationArea = All;
                }
                field("Reason Text"; Rec."Reason Text")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenWorksheet)
            {
                ApplicationArea = All;
                Caption = 'Open Worksheet';
                RunObject = page 60103;
            }
        }
    }
}
