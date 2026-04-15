table 60103 "DCC Dim Corr Doc List"
{
    Caption = 'DCC Dimension Correction Document';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DimCorr: Record "DCC Dim Corr";
        ConfirmMgmt: Codeunit "Confirm Management";
    begin
        DimCorr.SetFilter("Document No.", '%1', Rec."Document No");
        if DimCorr.FindFirst() then
            DimCorr.DeleteAll();
    end;
}
