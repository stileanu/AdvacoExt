table 50007 DeletedWorkOrder
{
    // 11/9/00 RJK TempSateCode can be removed but retained for possible later use.
    // To find commented code, use pattern <//--!>

    fields
    {
        field(5; "Work Order Master No."; Code[7])
        {
            TableRelation = WorkOrderMaster."Work Order Master No.";
        }
        field(6; "Customer ID"; Code[20])
        {
        }
        field(10; "Work Order No."; Code[7])
        {
        }
        field(11; "Work Order Date"; Date)
        {
        }
        field(12; "Sales Order No."; Code[10])
        {
        }
        field(15; "Detail No."; Code[2])
        {
        }
        field(20; "Model No."; Code[20])
        {
            //--!TR/MF
            //TableRelation = Item."No." WHERE(Class = CONST(MODEL));
        }
        field(25; "Model Verified"; Boolean)
        {
        }
        field(30; "Order Type"; Enum OrderType)
        {
            //OptionMembers = Rebuild,Repair,Warranty;
        }
        field(35; "Order Type Reason"; Text[100])
        {
        }
        field(40; Description; Text[30])
        {
        }
        field(50; "Serial No."; Code[20])
        {
        }
        field(55; "Build Ahead"; Boolean)
        {
        }
        field(60; "Customer PO No."; Code[30])
        {
        }
        field(70; Notes; Text[80])
        {
        }
        field(80; "Oil Type"; Code[30])
        {
        }
        field(90; "Deptartment Code"; Enum DeptCode)
        {
            //OptionMembers = ,SERVICE,SALES,TURBO,MANUFACTURING,DRY;
        }
        field(100; "Customer Part No."; Code[20])
        {
        }
        field(110; "Tax Exempt"; Boolean)
        {
        }
        field(115; "Tax Liable"; Boolean)
        {
        }
        field(120; "Warranty Code"; Code[2])
        {
        }
        field(125; Diagnosis; Text[80])
        {
        }
        field(130; "Ultimate Test"; Text[20])
        {
        }
        field(160; Container; Enum Container)
        {
            //OptionMembers = " ",Skid,Box,Crate,Drum,"Skid Box",Loose;
        }
        field(170; "Container Quantity"; Integer)
        {
        }
        field(180; "Ship Weight"; Decimal)
        {
        }
        field(185; "Package Tracking No."; Text[30])
        {
        }
        field(190; "Bill of Lading"; Integer)
        {
        }
        field(200; "Labor Hours Quoted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Parts."Quoted Quantity" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
        }
        field(202; "Labor Quoted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Parts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
        }
        field(210; "Parts Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Parts."Total Quote Cost" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
        }
        field(220; "Order Adj."; Decimal)
        {
        }
        field(221; "Quote Price"; Decimal)
        {
        }
        field(222; "Original Parts Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (OriginalQuotedParts."Total Quote Cost" WHERE("Work Order No." = FIELD("Work Order No.")));
            Description = '11/22/00';
        }
        field(223; "Original Parts Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (OriginalQuotedParts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
            Description = '03/15/01';
        }
        field(224; "Original Labor Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (OriginalQuotedParts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
            Description = '03/15/01';

        }
        field(226; "Unrepairable Charge"; Decimal)
        {
        }
        field(230; Freightin; Decimal)
        {
        }
        field(235; Freightout; Decimal)
        {
        }
        field(240; "Install Date"; Date)
        {
        }
        field(245; Quote; Enum QuoteOptions)
        {
            //OptionMembers = " ",Accepted,"Not Repairable";
        }
        field(246; "Unrepairable Reason"; Enum UnrepairableReason)
        {
            //OptionMembers = " ",Obsolete,"Can't Be Repaired","Rejected By Customer";
        }
        field(247; "Unrepairable Handling"; Enum UnrepairableHandling)
        {
            //OptionMembers = " ","Return Un-Assembled","Return Assembled","Save Parts & Scrap",Scrap;
        }
        field(250; "Parts Quoted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Parts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
        }
        field(260; Carrier; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(265; "Shipping Method"; Code[10])
        {
            TableRelation = "Shipment Method".Code;
        }
        field(270; "Shipping Account"; Code[30])
        {
        }
        field(275; "Shipping Charge"; Enum ShippingCharge)
        {
            //OptionMembers = ,Collect,"Pre-Paid","3rd Party",Consignee;
        }
        field(280; "Date Required"; Date)
        {
        }
        field(290; Warranty; Boolean)
        {
        }
        field(300; Released; Boolean)
        {
        }
        field(310; Invoiced; Boolean)
        {
        }
        field(330; Accessories; Text[40])
        {
        }
        field(335; "Receiving Notes"; Text[90])
        {
        }
        field(340; "Safety Form"; Boolean)
        {
        }
        field(345; Packaging; Text[40])
        {
        }
        field(350; "Packaging Location"; Code[2])
        {
        }
        field(360; "Pump Location"; Code[2])
        {
        }
        field(370; Boxed; Boolean)
        {
        }
        field(400; "Detail Step"; Enum DetailStep)
        {
            FieldClass = FlowField;
            CalcFormula = Max (Status.Step WHERE("Order No." = FIELD("Work Order No.")));
            //OptionMembers = REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,PNT,QC,MSP,SHP;
        }
        field(405; BackorderText; Code[40])
        {
        }
        field(410; "Quote Phase"; Enum QuotePhase)
        {
            //OptionMembers = " ","Phase 1","Phase 2","Phase 3";
        }
        field(500; "Current Reg Hours Used"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Status."Regular Hours" WHERE("Order No." = FIELD("Work Order No.")));
        }
        field(505; "Current OT Hours Used"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Status."Overtime Hours" WHERE("Order No." = FIELD("Work Order No.")));

        }
        field(600; Stage; Enum StageOption)
        {
            //OptionMembers = Default,Quote,"In Process",Complete;
        }
        field(700; REC; Text[90])
        {
        }
        field(705; "REC Date"; Date)
        {
        }
        field(710; DIS; Text[90])
        {
        }
        field(715; "DIS Date"; Date)
        {
        }
        field(720; QOT; Text[90])
        {
        }
        field(725; "QOT Date"; Date)
        {
        }
        field(730; "B-O"; Text[90])
        {
        }
        field(735; "B-O Date"; Date)
        {
        }
        field(740; CLN; Text[90])
        {
        }
        field(745; "CLN Date"; Date)
        {
        }
        field(750; ASM; Text[90])
        {
        }
        field(755; "ASM Date"; Date)
        {
        }
        field(760; TST; Text[90])
        {
        }
        field(765; "TST Date"; Date)
        {
        }
        field(770; PNT; Text[90])
        {
        }
        field(775; "PNT Date"; Date)
        {
        }
        field(780; QC; Text[90])
        {
        }
        field(785; "QC Date"; Date)
        {
        }
        field(790; SHP; Text[90])
        {
        }
        field(791; "SHP Date"; Date)
        {
        }
        field(795; Ship; Boolean)
        {
        }
        field(796; "Ship Date"; Date)
        {
        }
        field(800; "Ship To Name"; Text[30])
        {
        }
        field(810; "Ship To Address 1"; Text[30])
        {
        }
        field(820; "Ship To Address 2"; Text[30])
        {
        }
        field(830; "Ship To City"; Text[30])
        {
        }
        field(840; "Ship To State"; Code[15])
        {
        }
        field(850; "Ship To Zip Code"; Code[15])
        {
        }
        field(860; Attention; Text[20])
        {
        }
        field(870; Expedite; Boolean)
        {
        }
        field(880; "Billing List"; Boolean)
        {
        }
        field(890; "Billing Notes"; Text[30])
        {
        }
        field(900; Unblocked; Boolean)
        {
        }
        field(910; "Unblocked SHP"; Boolean)
        {
        }
        field(1000; Complete; Boolean)
        {
        }
        field(1001; "Last User Modified"; Code[10])
        {
        }
        field(1005; "Payment Method"; Code[10])
        {
            TableRelation = "Payment Method".Code;
        }
        field(1010; "Card Type"; Enum CreditCardType)
        {
            //OptionMembers = " ",AM,DI,MC,VI;
        }
        field(1020; "Credit Card No."; Code[20])
        {
        }
        field(1030; "Credit Card Exp."; Code[6])
        {
        }
        field(1050; "Payment Terms"; Code[10])
        {
            TableRelation = "Payment Terms".Code;
        }
        field(2001; "Reason Deleted"; Text[50])
        {
        }
        field(2010; "Deletion Date"; Date)
        {
        }
        field(100003; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist ("ADVACO Comment Line" WHERE("Table Name" = CONST(WorkOrderDetail), "No." = FIELD("Work Order No.")));
        }
    }

    keys
    {
        key(Key1; "Work Order No.")
        {
        }
        key(Key2; "Work Order Master No.")
        {
        }
    }

    fieldgroups
    {
    }
}

