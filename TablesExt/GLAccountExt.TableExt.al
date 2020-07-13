tableextension 50100 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "Include for Commissions"; Boolean)
        {
            CaptionML = ENU = 'Include for Commissions';

        }

    }
    local procedure SetupnewGLacc(OldGlacc: Record "G/L Account";BelowOldGlacc:Boolean)
    var
      OldGLAcc2: Record "G/L Account";
    begin
        if not BelowOldGlacc then begin
            OldGLAcc2 := OldGlacc;
            OldGlacc.Copy(Rec);
            OldGlacc := OldGLAcc2;
            if not OldGlacc.Find('<') then
              OldGlacc.Init();
          
        end;
        "Income/Balance" := OldGlacc."Income/Balance";
    end;
    local procedure CheckGLAcc()
    begin
        TestField("Account Type","Account Type"::Posting);
        TestField(Blocked,false);
    end;
    local procedure GetCurrencyCode():Code[10]
    var
      GlSetup: Record "General Ledger Setup";
      GlSetupRead:Boolean;
    begin
       if not GlSetupRead then begin
           GlSetup.Get();
           GlSetupRead := true;
       end;
       exit(GlSetup."Additional Reporting Currency");
       
    end;

}