page 60101 "DCC Dim Table Fields"
{
    UsageCategory = Lists;
    PageType = List;
    SourceTable = Field;
    Caption = 'DCC Dimension Table Fields';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = false;
                }
            }
        }
    }
}
