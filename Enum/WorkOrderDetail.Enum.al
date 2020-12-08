enum 50000 YesNo
{
    Extensible = true;

    value(0; " ") { }
    value(1; Yes) { }
    value(2; No) { }
}
enum 50001 Container
{
    Extensible = true;

    value(0; " ") { }
    value(1; Skid) { }
    value(2; Box) { }
    value(3; Crate) { }
    value(4; Drum) { }
    value(5; "Skid Box") { }
    value(6; Loose) { }
}

enum 50002 OrderType
{
    Extensible = true;

    value(0; Rebuild) { }
    value(1; Repair) { }
    value(2; Warranty) { }
}

enum 50003 ModelType
{
    Extensible = true;

    value(0; " ") { }
    value(1; Blower) { }
    value(2; "Cryo Compressor") { }
    value(3; "Cryo Pump") { }
    value(4; "Diffusion Pump") { }
    value(5; "Dry Pump - Ebara") { }
    value(6; "Dry Pump - Edwards") { }
    value(7; "Dry Pump - Leybold") { }
    value(8; "Filter System") { }
    value(9; "Leak Detector") { }
    value(10; "Mechanical Pump") { }
    value(11; "Scroll Pump") { }
    value(12; "Turbo Controller") { }
    value(13; "Turbo Pump") { }
}

enum 50004 IncomeCode
{
    Extensible = true;

    value(0; " ") { }
    value(1; Service) { }
    value(2; Sales) { }
    value(3; Turbo) { }
    value(4; Electronic) { }
    value(5; Dry) { }
    value(6; Cryo) { }
}

enum 50005 WarrantyType
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Key Account") { }
    value(2; Legitimate) { }
    value(3; "No Trouble Found") { }
    value(4; Process) { }
}

enum 50006 QuoteOptions
{
    Extensible = true;

    value(0; " ") { }
    value(1; Accepted) { }
    value(2; "Not Repairable") { }
}

enum 50007 UnrepairableReason
{
    Extensible = true;

    value(0; " ") { }
    value(1; Obsolete) { }
    value(2; "Can't Be Repaired") { }
    value(3; "Rejected By Customer") { }
}

enum 50008 UnrepairableHandling
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Return Un-Assembled") { }
    value(2; "Return Assembled") { }
    value(3; "Save Parts & Scrap") { }
    value(4; Scrap) { }
    value(5; "Return to Vendor") { }
}

enum 50009 ShippingCharge
{
    Extensible = true;

    value(0; " ") { }
    value(1; Collect) { }
    value(2; "Pre-Paid") { }
    value(3; "Pre-Paid & Add") { }
    value(4; "3rd Party") { }
    value(5; Consignee) { }
}

enum 50010 DetailStep
{
    Extensible = true;

    value(0; RCV)
    {
        Caption = 'REC';
    }
    value(1; DIS) { }
    value(2; QOT) { }
    value(3; "B-O") { }
    value(4; CLN) { }
    value(5; ASM) { }
    value(6; TST) { }
    value(7; REP) { }
    value(8; RET) { }
    value(9; MSP) { }
    value(10; PNT) { }
    value(11; QC) { }
    value(12; SHP) { }
    value(100; NON) { }
}

enum 50011 QuotePhase
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Phase 1") { }
    value(2; "Phase 2") { }
    value(3; "Phase 3") { }
}

enum 50012 StageOption
{
    Extensible = true;

    value(0; Default) { }
    value(1; Quote) { }
    value(2; "In Process") { }
    value(3; Complete) { }
}

enum 50013 CreditCardType
{
    Extensible = true;

    value(0; " ") { }
    value(1; AM) { }
    value(2; DI) { }
    value(3; MC) { }
    value(4; VI) { }
}

enum 50014 DocType
{
    Extensible = true;

    value(0; WorkOrder) { }
    value(1; FieldService) { }
}

enum 50015 ItemType
{
    Extensible = true;

    value(0; " ") { }
    value(1; Item) { }
    value(2; Resource) { }
}

enum 50016 DeptCode
{
    Extensible = true;

    value(0; " ") { }
    value(1; Service) { }
    value(2; Sales) { }
    value(3; Turbo) { }
    value(4; Manufacturing) { }
    value(5; Dry) { }
}

enum 50017 TableName
{
    Extensible = true;

    value(0; WorkOrderMaster) { }
    value(1; WorkOrderDetail) { }
    value(2; IDRHeader) { }
}

enum 50018 IDRDocType
{
    Extensible = true;

    value(0; " ") { }
    value(1; Receiving) { }
    value(2; Production) { }
}
enum 50019 PartType
{
    Extensible = true;

    value(0; Item) { }
    value(1; Resource) { }
}
enum 50020 IDRDept
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Production Assembly") { }
    value(2; Test) { }
    value(3; "Quality Control") { }
}