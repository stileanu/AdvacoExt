TableExtension 50107 ItemJournalLineExt Extends "Item Journal Line"
{
    // To find commented code, use pattern <//--!>

    /* Documentation    
    QDP Parts Handling

    Item No -OnValidate Changes
    */
    fields
    {
        field(50000; Rep; Code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;

            begin

                IF Item."No." <> "Item No." THEN
                    Item.GET("Item No.");

                //>> HEF INSERT PIP
                IF "Journal Batch Name" = 'PIP' THEN BEGIN
                    "Gen. Prod. Posting Group" := 'PIP';
                    "Location Code" := 'MAIN';
                    "Unit Cost" := Item."Last Direct Cost";
                END;
                //<< HEF END INSERT   
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()

            begin
                //--!MF
                /*
                //>>  Multi-Location - start
                IF Location.GET("Location Code") THEN
                    IF Location."Department Code" <> '' THEN
                        "Department Code" := Location."Department Code";
                IF Location."Project Code" <> '' THEN
                    "Project Code" := Location."Project Code";
                IF LocationItem.GET("Location Code", "Item No.", "Variant Code") THEN
                    "Inventory Posting Group" := LocationItem."Inventory Posting Group";
                //<<  Multi-Location - end
                */
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                //  Multi-Location - start
                //IF Location.GET("Location Code") THEN
                // IF (Location."Department Code" <> '') AND
                //(Location."Department Code" <> "Department Code") THEN
                //ERROR('You may not change the department code for this location.');
                //<<  Multi-Location - end  
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin

                //  Multi-Location - start
                //IF Location.GET("Location Code") THEN
                // IF (Location."Project Code" <> '') AND
                //(Location."Project Code" <> "Project Code") THEN
                //ERROR('You may not change the project code for this location.');
                //<<  Multi-Location - end

            end;
        }
    }
    var
        Location: Record Location;
}