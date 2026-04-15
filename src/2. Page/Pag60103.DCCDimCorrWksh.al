page 60103 "DCC Dim Corr Wksh"
{
    UsageCategory = Tasks;
    PageType = Worksheet;
    ApplicationArea = All;
    SourceTable = "DCC Dim Corr";
    Caption = 'DCC Dimension Correction Worksheet';
    InsertAllowed = false;
    DelayedInsert = true;
    PromotedActionCategories = 'New,Process,Report,Configuration';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No.1"; DocumentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    trigger OnValidate()
                    begin
                        UpdateTempTable();
                    end;
                }
            }
            repeater(Line)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
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
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Dimension Set ID"; Rec."New Dimension Set ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dimension 1"; Rec."Dimension 1")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(1, Rec."Dimension 1");
                    end;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(2, Rec."Dimension 2");
                    end;
                }
                field("Dimension 3"; Rec."Dimension 3")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(3, Rec."Dimension 3");
                    end;
                }
                field("Dimension 4"; Rec."Dimension 4")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(4, Rec."Dimension 4");
                    end;
                }
                field("Dimension 5"; Rec."Dimension 5")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(5, Rec."Dimension 5");
                    end;
                }
                field("Dimension 6"; Rec."Dimension 6")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(6, Rec."Dimension 6");
                    end;
                }
                field("Dimension 7"; Rec."Dimension 7")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(7, Rec."Dimension 7");
                    end;
                }
                field("Dimension 8"; Rec."Dimension 8")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimValue(8, Rec."Dimension 8");
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetupTable)
            {
                ApplicationArea = All;
                Caption = 'Setup Table';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "DCC Dim Setup List";
            }
            action(Log)
            {
                ApplicationArea = All;
                Caption = 'Correction Log';
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = page "DCC Dim Corr Log List";
            }

            action(UpdateEntries)
            {
                ApplicationArea = All;
                Caption = 'Update Entries';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Docnos: Record "DCC Dim Corr Doc List";
                    DimCorr: Record "DCC Dim Corr";
                begin
                    DimCorrMgt.UpdateLedgerTables();
                    if not Dialog.Confirm('Delete the generated document list and temporary lines?', false) then
                        exit;
                    Docnos.DeleteAll();
                    DimCorr.DeleteAll();
                end;
            }
            action("Dimension Correction Documents")
            {
                ApplicationArea = All;
                Caption = 'Dimension Correction Documents';
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page 60104;
            }
            action("Generate Entries")
            {
                ApplicationArea = All;
                Caption = 'Generate Entries';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    UpdateTempTable1();
                end;
            }
            action("Export To Excel")
            {
                ApplicationArea = All;
                Caption = 'Export To Excel';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = Visible;

                trigger OnAction()
                begin
                    ExportToExcel();
                end;
            }
            action("Import To Excel")
            {
                ApplicationArea = All;
                Caption = 'Import From Excel';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = Visible;
                trigger OnAction()
                begin
                    ImportFromExcel();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        EnvInfo: Codeunit "Environment Information";
    begin
        Visible := EnvInfo.IsOnPrem();
    end;

    var
        DocumentNo: Code[20];
        ReasonText: Text;
        Visible: Boolean;
        DimCorrMgt: Codeunit "DCC Dim Corr Mgt";


    local procedure UpdateTempTable()
    begin
        DimCorrMgt.RebuildTempLinesFromDocumentNo(DocumentNo);
        CurrPage.Update();
    end;

    local procedure UpdateTempTable1()
    begin
        DimCorrMgt.RebuildTempLinesFromDocumentList();
        CurrPage.Update();
    end;

    procedure ExportToExcel()
    begin
        DimCorrMgt.ExportToExcel(Rec);
    end;

    local procedure ImportFromExcel()
    begin
        DimCorrMgt.ImportFromExcel();
        CurrPage.Update();
    end;


}
