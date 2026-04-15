codeunit 60100 "DCC Dim Corr Mgt"
{
    Permissions = tabledata "G/L Entry" = rm,
    tabledata "Cust. Ledger Entry" = rm,
    tabledata "Vendor Ledger Entry" = rm,
    tabledata "Item Ledger Entry" = rm,
    tabledata "Sales Shipment Header" = rm,
    tabledata "Sales Shipment Line" = rm,
    tabledata "Sales Invoice Header" = rm,
    tabledata "Sales Invoice Line" = rm,
    tabledata "Sales Cr.Memo Header" = rm,
    tabledata "Sales Cr.Memo Line" = rm,
    tabledata "Purch. Rcpt. Header" = rm,
    tabledata "Purch. Rcpt. Line" = rm,
    tabledata "Purch. Inv. Header" = rm,
    tabledata "Purch. Inv. Line" = rm,
    tabledata "Purch. Cr. Memo Hdr." = rm,
    tabledata "Purch. Cr. Memo Line" = rm,
    tabledata "Bank Account Ledger Entry" = rm,
    tabledata "Detailed Cust. Ledg. Entry" = rm,
    tabledata "Detailed Vendor Ledg. Entry" = rm,
    tabledata "FA Ledger Entry" = rm,
    tabledata "Value Entry" = rm,
    tabledata "Return Shipment Header" = rm,
    tabledata "Return Shipment Line" = rm,
    tabledata "Return Receipt Header" = rm,
    tabledata "Return Receipt Line" = rm;

    procedure RebuildTempLinesFromDocumentNo(DocumentNo: Code[20])
    begin

        if DocumentNo = '' then
            exit;

        AppendTempLinesForDocumentNo(DocumentNo);
    end;

    procedure RebuildTempLinesFromDocumentList()
    var
        DocumentNoEntry: Record "DCC Dim Corr Doc List";
    begin
        DocumentNoEntry.Reset();
        DocumentNoEntry.SetFilter("Document No", '<>%1', '');
        if DocumentNoEntry.FindSet() then
            repeat
                AppendTempLinesForDocumentNo(DocumentNoEntry."Document No");
            until DocumentNoEntry.Next() = 0
        else
            Message('No document number found in document list.');
    end;

    procedure UpdateLedgerTables()
    var
        ReasonText: Text;
        IsUpdated: Boolean;
        SourceLines: Record "DCC Dim Corr";
    begin
        // if not Dialog.Confirm('Are you sure you want to update?', false) then
        //     Error('Update cancelled.');
        SourceLines.Reset();
        if SourceLines.FindSet() then begin
            repeat
                UpdateLedgerTables(SourceLines, ReasonText);
            until SourceLines.Next() = 0;
        end
        else
            Message('There is nothing to update.');

        if IsUpdated then
            Message('Dimension updated.');
    end;

    procedure UpdateLedgerTables(var SourceLines: Record "DCC Dim Corr"; ReasonText: Text)
    var
        DimSetupTable: Record "DCC Dim Corr Setup";
        TempLines: Record "DCC Dim Corr" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        GenLedgerSetup: Record "General Ledger Setup";
        DimLogTable: Record "DCC Dim Corr Log";
        RecRef: RecordRef;
        MyFieldRef: FieldRef;
        MyFieldRef1: FieldRef;
        MyFieldRef2: FieldRef;
        MyFieldRef3: FieldRef;
        MyFieldRef4: FieldRef;
        MyFieldRef5: FieldRef;
        MyFieldRef6: FieldRef;
        MyFieldRef7: FieldRef;
        MyFieldRef8: FieldRef;
        EntryNo: Integer;
    begin


        TempLines.Init();
        TempLines.TransferFields(SourceLines);
        TempLines.Insert();

        TempLines.Reset();
        if TempLines.IsEmpty() then begin
            Message('There is nothing to update.');
            exit;
        end;

        DimSetupTable.Reset();
        DimSetupTable.SetRange(Skip, false);
        DimSetupTable.SetRange("Table Id", TempLines."Table ID");
        if DimSetupTable.FindFirst() then
            repeat
                Clear(RecRef);
                Clear(MyFieldRef);

                RecRef.Open(DimSetupTable."Table Id");

                MyFieldRef := RecRef.Field(DimSetupTable."Document No. Field No.");
                MyFieldRef.SetFilter(TempLines."Document No.");

                if TempLines."Primary Key 1" = '' then
                    Error('Table ID %1, requires at least one primary key in setup.', DimSetupTable."Table Id");

                MyFieldRef := RecRef.Field(DimSetupTable."Primary Key 1");
                MyFieldRef.SetFilter(TempLines."Primary Key 1");

                if TempLines."Primary Key 2" <> '' then begin
                    MyFieldRef := RecRef.Field(DimSetupTable."Primary Key 2");
                    MyFieldRef.SetFilter(TempLines."Primary Key 2");
                end;

                if TempLines."Primary Key 3" <> '' then begin
                    MyFieldRef := RecRef.Field(DimSetupTable."Primary Key 3");
                    MyFieldRef.SetFilter(TempLines."Primary Key 3");
                end;

                if TempLines."Primary Key 4" <> '' then begin
                    MyFieldRef := RecRef.Field(DimSetupTable."Primary Key 4");
                    MyFieldRef.SetFilter(TempLines."Primary Key 4");
                end;

                if RecRef.FindFirst() then begin
                    if DimSetupTable."Dimension 1 - Field No." <> 0 then begin
                        MyFieldRef1 := RecRef.Field(DimSetupTable."Dimension 1 - Field No.");
                        MyFieldRef1.Value := TempLines."Dimension 1";
                    end;

                    if DimSetupTable."Dimension 2 - Field No." <> 0 then begin
                        MyFieldRef2 := RecRef.Field(DimSetupTable."Dimension 2 - Field No.");
                        MyFieldRef2.Value := TempLines."Dimension 2";
                    end;

                    if DimSetupTable."Dimension 3 - Field No." <> 0 then begin
                        MyFieldRef3 := RecRef.Field(DimSetupTable."Dimension 3 - Field No.");
                        MyFieldRef3.Value := TempLines."Dimension 3";
                    end;

                    if DimSetupTable."Dimension 4 - Field No." <> 0 then begin
                        MyFieldRef4 := RecRef.Field(DimSetupTable."Dimension 4 - Field No.");
                        MyFieldRef4.Value := TempLines."Dimension 4";
                    end;

                    if DimSetupTable."Dimension 5 - Field No." <> 0 then begin
                        MyFieldRef5 := RecRef.Field(DimSetupTable."Dimension 5 - Field No.");
                        MyFieldRef5.Value := TempLines."Dimension 5";
                    end;

                    if DimSetupTable."Dimension 6 - Field No." <> 0 then begin
                        MyFieldRef6 := RecRef.Field(DimSetupTable."Dimension 6 - Field No.");
                        MyFieldRef6.Value := TempLines."Dimension 6";
                    end;

                    if DimSetupTable."Dimension 7 - Field No." <> 0 then begin
                        MyFieldRef7 := RecRef.Field(DimSetupTable."Dimension 7 - Field No.");
                        MyFieldRef7.Value := TempLines."Dimension 7";
                    end;

                    if DimSetupTable."Dimension 8 - Field No." <> 0 then begin
                        MyFieldRef8 := RecRef.Field(DimSetupTable."Dimension 8 - Field No.");
                        MyFieldRef8.Value := TempLines."Dimension 8";
                    end;

                    if DimSetupTable."Dimension Set Id - Field No." <> 0 then begin
                        MyFieldRef := RecRef.Field(DimSetupTable."Dimension Set Id - Field No.");
                        MyFieldRef.Value := TempLines."New Dimension Set ID";
                    end;

                    RecRef.Modify();

                    EntryNo := 0;
                    DimLogTable.Reset();
                    if DimLogTable.FindLast() then
                        EntryNo := DimLogTable."Entry No.";

                    DimLogTable.Init();
                    DimLogTable.TransferFields(TempLines);
                    DimLogTable."Entry No." := EntryNo + 1;
                    DimLogTable."Reason Text" := ReasonText;
                    DimLogTable.UserId := UserId;
                    DimLogTable.Date := Today;
                    DimLogTable.Insert();
                end;
            until DimSetupTable.Next() = 0
        else
            Error('No setup found for Table ID %1.', TempLines."Table ID");
    end;

    local procedure AppendTempLinesForDocumentNo(DocumentNo: Code[20])
    var
        DimCorrSetup: Record "DCC Dim Corr Setup";
        SourceRecRef: RecordRef;
        SourceFieldRef: FieldRef;
    begin
        DimCorrSetup.Reset();
        DimCorrSetup.SetRange(Skip, false);
        DimCorrSetup.SetFilter("Document No. Field No.", '<>%1', 0);
        if DimCorrSetup.FindSet() then
            repeat
                Clear(SourceRecRef);
                Clear(SourceFieldRef);

                SourceRecRef.Open(DimCorrSetup."Table Id");
                SourceFieldRef := SourceRecRef.Field(DimCorrSetup."Document No. Field No.");
                SourceFieldRef.SetRange(DocumentNo);
                if SourceRecRef.FindFirst() then
                    repeat
                        InsertTempLineFromSourceRecord(DimCorrSetup, SourceRecRef);
                    until SourceRecRef.Next() = 0;

            until DimCorrSetup.Next() = 0
        else
            Error('No setup found for Table ID %1.', DimCorrSetup."Table Id");
    end;

    local procedure InsertTempLineFromSourceRecord(DimCorrSetup: Record "DCC Dim Corr Setup"; SourceRecRef: RecordRef)
    var
        TempLine: Record "DCC Dim Corr";
        DimSetEntry: Record "Dimension Set Entry";
        GenLedgerSetup: Record "General Ledger Setup";
        TempStr: Text;
        EntryNo: Integer;
    begin
        EntryNo := 0;
        TempLine.Reset();
        if TempLine.FindLast() then
            EntryNo := TempLine."Line No.";

        TempLine.Init();
        TempLine."Line No." := EntryNo + 1;
        TempLine."Table ID" := DimCorrSetup."Table Id";
        TempLine."Table Name" := Format(SourceRecRef.Caption);

        if DimCorrSetup."Primary Key 1" = 0 then
            Error('Table %1, requires at least 1 primary key setup.', DimCorrSetup."Table Caption");

        TempLine."Primary Key 1" := Format(SourceRecRef.Field(DimCorrSetup."Primary Key 1"));
        if DimCorrSetup."Primary Key 2" <> 0 then
            TempLine."Primary Key 2" := Format(SourceRecRef.Field(DimCorrSetup."Primary Key 2"));
        if DimCorrSetup."Primary Key 3" <> 0 then
            TempLine."Primary Key 3" := Format(SourceRecRef.Field(DimCorrSetup."Primary Key 3"));
        if DimCorrSetup."Primary Key 4" <> 0 then
            TempLine."Primary Key 4" := Format(SourceRecRef.Field(DimCorrSetup."Primary Key 4"));

        TempLine."Document No." := Format(SourceRecRef.Field(DimCorrSetup."Document No. Field No."));

        if DimCorrSetup."Dimension Set Id - Field No." <> 0 then begin
            TempStr := Format(SourceRecRef.Field(DimCorrSetup."Dimension Set Id - Field No."));
            Evaluate(TempLine."Dimension Set ID", TempStr);
            TempLine."New Dimension Set ID" := TempLine."Dimension Set ID";

            GenLedgerSetup.Get();
            DimSetEntry.Reset();
            DimSetEntry.SetRange("Dimension Set ID", TempLine."Dimension Set ID");
            if DimSetEntry.FindSet() then
                repeat
                    case DimSetEntry."Dimension Code" of
                        GenLedgerSetup."Shortcut Dimension 1 Code":
                            TempLine."Dimension 1" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 2 Code":
                            TempLine."Dimension 2" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 3 Code":
                            TempLine."Dimension 3" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 4 Code":
                            TempLine."Dimension 4" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 5 Code":
                            TempLine."Dimension 5" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 6 Code":
                            TempLine."Dimension 6" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 7 Code":
                            TempLine."Dimension 7" := DimSetEntry."Dimension Value Code";
                        GenLedgerSetup."Shortcut Dimension 8 Code":
                            TempLine."Dimension 8" := DimSetEntry."Dimension Value Code";
                    end;
                until DimSetEntry.Next() = 0;
        end;

        TempLine.Insert();
    end;

    [Obsolete('Obsolete procedure, will be removed in future version.')]

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        if ExcelBuffer.Get(RowNo, ColNo) then
            exit(ExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    [Obsolete('Obsolete procedure, will be removed in future version.')]
    procedure ExportToExcel(var SourceLines: Record "DCC Dim Corr")
    var
        DimensionCorrectionTemp: Record "DCC Dim Corr";
        TempExcelBuf: Record "Excel Buffer" temporary;
    begin
        DimensionCorrectionTemp.CopyFilters(SourceLines);

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Table ID', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Table Name', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Document No.', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Line No.', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Primary Key 1', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Primary Key 2', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Primary Key 3', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Primary Key 4', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 1', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 2', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 3', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 4', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 5', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 6', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 7', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Dimension 8', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);

        if DimensionCorrectionTemp.FindSet() then
            repeat
                TempExcelBuf.NewRow();
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Table ID", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Table Name", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Document No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Line No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Primary Key 1", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Primary Key 2", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Primary Key 3", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Primary Key 4", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 1", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 2", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 3", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 4", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 5", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 6", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 7", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
                TempExcelBuf.AddColumn(DimensionCorrectionTemp."Dimension 8", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
            until DimensionCorrectionTemp.Next() = 0;

        TempExcelBuf.CreateNewBook('Dimension Correction');
        TempExcelBuf.WriteSheet('Dimension Correction', 'Salesberry', UserId);
        TempExcelBuf.CloseBook();
        TempExcelBuf.SetFriendlyFilename('Dimension Correction');
        TempExcelBuf.OpenExcel();
    end;

    [Obsolete('Obsolete procedure, will be removed in future version.')]
    procedure ImportFromExcel()
    var
        LastRow: Integer;
        RowNo: Integer;
        Filename: Text;
        InStr: InStream;
        ImportedLine: Record "DCC Dim Corr";
        LineNo: Integer;
        DocNo: Code[20];
    begin
        if not UploadIntoStream('Import Excel', '', '', Filename, InStr) then
            exit;

        ExcelBuffer.OpenBookStream(InStr, 'Dimension Correction');
        ExcelBuffer.ReadSheet();
        ExcelBuffer.SetRange("Column No.", 1);
        if ExcelBuffer.FindLast() then
            LastRow := ExcelBuffer."Row No.";

        ExcelBuffer.Reset();

        if LastRow < 2 then begin
            Message('No data was found in the selected Excel file.');
            exit;
        end;

        for RowNo := 2 to LastRow do begin
            if not Evaluate(LineNo, GetValueAtCell(RowNo, 4)) then
                Error('Invalid line number in row %1.', RowNo);

            if not Evaluate(DocNo, GetValueAtCell(RowNo, 3)) then
                Error('Invalid document number in row %1.', RowNo);

            ImportedLine.Reset();
            ImportedLine.SetRange("Line No.", LineNo);
            ImportedLine.SetRange("Document No.", DocNo);
            if ImportedLine.FindFirst() then begin
                ImportedLine.Validate("Dimension 1", GetValueAtCell(RowNo, 9));
                ImportedLine.Validate("Dimension 2", GetValueAtCell(RowNo, 10));
                ImportedLine.Validate("Dimension 3", GetValueAtCell(RowNo, 11));
                ImportedLine.Validate("Dimension 4", GetValueAtCell(RowNo, 12));
                ImportedLine.Validate("Dimension 5", GetValueAtCell(RowNo, 13));
                ImportedLine.Validate("Dimension 6", GetValueAtCell(RowNo, 14));
                ImportedLine.Validate("Dimension 7", GetValueAtCell(RowNo, 15));
                ImportedLine.Validate("Dimension 8", GetValueAtCell(RowNo, 16));
                ImportedLine.Modify();
            end;
        end;

        Message('Total count %1', ExcelBuffer.Count);
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
}