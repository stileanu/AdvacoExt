report 50015 "Shipping Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50015_ShippingLabel.rdl';

    dataset
    {
        dataitem("Bill of Lading"; BillOfLading)
        {
            RequestFilterFields = "Bill of Lading", "Order No.";
            column(Bill_of_Lading__Bill_of_Lading_; "Bill of Lading")
            {
            }
            column(Bill_of_Lading__Ship_To_Name_; "Ship To Name")
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Att; Att)
            {
            }
            column(Bill_of_Lading__Ship_To_Address_; "Ship To Address")
            {
            }
            //column(Bill_of_Lading__Quantity_Printed_; "Quantity Printed")
            //{
            //}
            column(OF__; ' OF ')
            {
            }
            column(Bill_of_Lading__Label_Quantity_; "Label Quantity")
            {
            }
            column(BOL__; 'BOL#')
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(number);

                column(Bill_of_Lading__Quantity_Printed_; CopyNo)
                {
                }

                trigger OnPreDataItem()
                begin
                    NoLoops := ABS(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then
                        CurrReport.Break();

                    CopyNo := CopyNo + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "RMA No." <> '' then
                    Att := 'RMA: ' + "RMA No."
                else
                    Att := 'ATTN: ' + Attention;

                if "Ship To Address2" = '' then begin
                    ShipToAd2 := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                    ShipTo := '';
                end else begin
                    ShipToAd2 := "Ship To Address2";
                    ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                end;

                NoCopies := "Label Quantity";
                //if "Label Quantity" > "Quantity Printed" then
                //    "Quantity Printed" := "Quantity Printed" + 1;

                //Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ShipToAddress: Record "Ship-to Address";
        ShipToAd2: Text[50];
        ShipTo: Text[50];
        Att: Code[50];
        NoLoops: Integer;
        NoCopies: Integer;
        CopyNo: Integer;
}

