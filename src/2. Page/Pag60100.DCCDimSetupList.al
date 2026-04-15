page 60100 "DCC Dim Setup List"
{
    PageType = List;
    SourceTable = "DCC Dim Corr Setup";
    Caption = 'DCC Dimension Setup List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table Id"; Rec."Table Id")
                {
                    ApplicationArea = All;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                }
                field("Primary Key 1"; Rec."Primary Key 1")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Primary Key 1"));
                    end;
                }
                field("Primary Key 2"; Rec."Primary Key 2")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Primary Key 2"));
                    end;
                }
                field("Primary Key 3"; Rec."Primary Key 3")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Primary Key 3"));
                    end;
                }
                field("Primary Key 4"; Rec."Primary Key 4")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Primary Key 4"));
                    end;
                }
                field("Dimension 1 - Field No."; Rec."Dimension 1 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 1 - Field No."));
                    end;
                }
                field("Dimension 2 - Field No."; Rec."Dimension 2 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 2 - Field No."));
                    end;
                }
                field("Dimension 3 - Field No."; Rec."Dimension 3 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 3 - Field No."));
                    end;
                }
                field("Dimension 4 - Field No."; Rec."Dimension 4 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 4 - Field No."));
                    end;
                }
                field("Dimension 5 - Field No."; Rec."Dimension 5 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 5 - Field No."));
                    end;
                }
                field("Dimension 6 - Field No."; Rec."Dimension 6 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 6 - Field No."));
                    end;
                }
                field("Dimension 7 - Field No."; Rec."Dimension 7 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 7 - Field No."));
                    end;
                }
                field("Dimension 8 - Field No."; Rec."Dimension 8 - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension 8 - Field No."));
                    end;
                }
                field("Dimension Set Id - Field No."; Rec."Dimension Set Id - Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Dimension Set Id - Field No."));
                    end;
                }
                field("Document No. Field No."; Rec."Document No. Field No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        AssistEdit(Rec.FieldNo("Document No. Field No."));
                    end;
                }
                field(Skip; Rec.Skip)
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
            action(DCCDimCorrWksh)
            {
                Caption = 'Dimension Correction Worksheet';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "DCC Dim Corr Wksh";
            }
            action(PopulateDimCorrSetup)
            {
                Caption = 'Populate Setup Fields';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = codeunit "SetupFields Helper";
            }
            action(CheckSetup)
            {
                Caption = 'Check Setup';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecCheckSetup: Record "DCC Dim Corr Setup";
                begin
                    if RecCheckSetup.IsEmpty() then
                        Message('No setup record found to check.')
                    else
                        if RecCheckSetup.FindSet() then begin
                            repeat
                                RecCheckSetup.CheckSetup(RecCheckSetup."Table Id");
                            until RecCheckSetup.Next() = 0;
                        end;
                end;
            }
        }
    }
    local procedure AssistEdit(NewFieldNo: Integer)
    var
        Field: Record Field;
        ChangeLogSetupFieldList: Page "Change Log Setup (Field) List";
    begin
        Field.FilterGroup(2);
        Field.SetRange(TableNo, Rec."Table Id");
        Field.FilterGroup(0);

        Clear(ChangeLogSetupFieldList);
        ChangeLogSetupFieldList.SetTableView(Field);
        ChangeLogSetupFieldList.SetRecord(Field);
        ChangeLogSetupFieldList.LookupMode(true);
        if ChangeLogSetupFieldList.RunModal = Action::LookupOK then begin
            ChangeLogSetupFieldList.GetRecord(Field);
            case NewFieldNo of
                Rec.FieldNo("Primary Key 1"):
                    Rec."Primary Key 1" := Field."No.";
                Rec.FieldNo("Primary Key 2"):
                    Rec."Primary Key 2" := Field."No.";
                Rec.FieldNo("Primary Key 3"):
                    Rec."Primary Key 3" := Field."No.";
                Rec.FieldNo("Primary Key 4"):
                    Rec."Primary Key 4" := Field."No.";
                Rec.FieldNo("Dimension 1 - Field No."):
                    Rec."Dimension 1 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 2 - Field No."):
                    Rec."Dimension 2 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 3 - Field No."):
                    Rec."Dimension 3 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 4 - Field No."):
                    Rec."Dimension 4 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 5 - Field No."):
                    Rec."Dimension 5 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 6 - Field No."):
                    Rec."Dimension 6 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 7 - Field No."):
                    Rec."Dimension 7 - Field No." := Field."No.";
                Rec.FieldNo("Dimension 8 - Field No."):
                    Rec."Dimension 8 - Field No." := Field."No.";
                Rec.FieldNo("Document No. Field No."):
                    Rec."Document No. Field No." := Field."No.";
                Rec.FieldNo("Dimension Set Id - Field No."):
                    Rec."Dimension Set Id - Field No." := Field."No.";
            end;
        end;
    end;
}
