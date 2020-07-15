tableextension 50134 InventoryBufferExt extends "Inventory Buffer"
{
    fields
    {
        field(50000; "Inventory Status"; Enum InventoryStatus)
        {
            DataClassification = ToBeClassified;
            Caption = 'Inventory Status';
        }
        field(50001; Line; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line';
        }
    }

    var
        myInt: Integer;
}