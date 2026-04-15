page 60104 "DCC Dim Corr Doc List"
{
    Caption = 'DCC Dimension Correction Document';
    PageType = List;
    SourceTable = "DCC Dim Corr Doc List";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Clear)
            {
                Caption = 'Clear Document List';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DocList: Record "DCC Dim Corr Doc List";
                begin
                    DocList.DeleteAll(true);
                end;

            }
        }
    }
}
