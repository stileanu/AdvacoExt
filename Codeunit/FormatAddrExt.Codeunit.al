codeunit 50032 FormatAddrExt
{
    trigger OnRun()
    begin

    end;

    procedure OutsideRep(var AddrArray: array[8] of Text[100]; var OutsideSalesreps: Record "Outside Sales Reps")
    var
        FormatAddr: Codeunit "Format Address";
    begin

        // New Function by Intelice
        //WITH OutsideSalesReps DO
        FormatAddr.FormatAddr(
          AddrArray, OutsideSalesReps."Rep Company", OutsideSalesReps."Rep Name", '', OutsideSalesReps."Rep Address 1", '',
          OutsideSalesReps."Rep City", OutsideSalesReps."Rep Zip", OutsideSalesReps."Rep State", '');

    end;

    var
        myInt: Integer;
}