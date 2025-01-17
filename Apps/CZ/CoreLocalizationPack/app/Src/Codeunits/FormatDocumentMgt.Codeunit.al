codeunit 11701 "Format Document Mgt. CZL"
{
    procedure GetDocumentFooterText(LanguageCode: Code[10]): Text[1000]
    var
        DocumentFooterCZL: Record "Document Footer CZL";
    begin
        DocumentFooterCZL.SetFilter("Language Code", '%1|%2', '', LanguageCode);
        if DocumentFooterCZL.FindLast() then
            exit(DocumentFooterCZL."Footer Text");
        exit('');
    end;

    procedure SetPaymentSymbols(var PaymentSymbol: array[2] of Text; var PaymentSymbolLabel: array[2] of Text; VariableSymbol: Code[10]; VariableSymbolCaption: Text; ConstantSymbol: Code[10]; ConstantSymbolCaption: Text; SpecificSymbol: Code[10]; SpecificSymbolCaption: Text)
    var
        TempPaymentSymbol: array[3] of Text;
        TempPaymentSymbolLabel: array[3] of Text;
        PaymentSymbolTok: Label '%1. / %2. %3', Locked = true;
        TwoPlaceholdersTok: Label '%1 / %2', Locked = true;
    begin
        Clear(PaymentSymbol);
        Clear(PaymentSymbolLabel);

        if VariableSymbol <> '' then begin
            TempPaymentSymbolLabel[1] := VariableSymbolCaption;
            TempPaymentSymbol[1] := VariableSymbol;
        end;
        if ConstantSymbol <> '' then begin
            TempPaymentSymbolLabel[2] := ConstantSymbolCaption;
            TempPaymentSymbol[2] := ConstantSymbol;
        end;
        if SpecificSymbol <> '' then begin
            TempPaymentSymbolLabel[3] := SpecificSymbolCaption;
            TempPaymentSymbol[3] := SpecificSymbol;
        end;

        CompressArray(TempPaymentSymbol);
        CompressArray(TempPaymentSymbolLabel);

        if TempPaymentSymbolLabel[3] <> '' then begin
            TempPaymentSymbolLabel[2] := StrSubstNo(PaymentSymbolTok,
                CopyStr(TempPaymentSymbolLabel[2], 1, 5),
                CopyStr(TempPaymentSymbolLabel[3], 1, 4),
                CopyStr(TempPaymentSymbolLabel[3], StrPos(TempPaymentSymbolLabel[3], ' ') + 1));
            TempPaymentSymbol[2] := StrSubstNo(TwoPlaceholdersTok, TempPaymentSymbol[2], TempPaymentSymbol[3]);
        end;

        CopyArray(PaymentSymbol, TempPaymentSymbol, 1, 2);
        CopyArray(PaymentSymbolLabel, TempPaymentSymbolLabel, 1, 2);
    end;
#if not CLEAN19
#if CLEAN17
#pragma warning disable AL0432

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Document", 'OnGetDocumentFooterText', '', false, false)]
    local procedure OnGetDocumentFooterText(LanguageCode: Code[10]; var DocumentFooterText: Text[250]);
    begin
        DocumentFooterText := CopyStr(GetDocumentFooterText(LanguageCode), 1, 250);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Document", 'OnSetPaymentSymbols', '', false, false)]
    local procedure OnSetPaymentSymbols(var PaymentSymbol: array[2] of Text; var PaymentSymbolLabel: array[2] of Text; VariableSymbol: Code[10]; VariableSymbolCaption: Text[80]; ConstantSymbol: Code[10]; ConstantSymbolCaption: Text[80]; SpecificSymbol: Code[10]; SpecificSymbolCaption: Text[80])
    begin
        SetPaymentSymbols(PaymentSymbol, PaymentSymbolLabel, VariableSymbol, VariableSymbolCaption, ConstantSymbol, ConstantSymbolCaption, SpecificSymbol, SpecificSymbolCaption);
    end;
#pragma warning restore AL0432    
#endif
#endif
}
