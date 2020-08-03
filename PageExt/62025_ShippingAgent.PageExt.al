pageextension 62025 ShippingAgentExt extends "Shipping Agents"
{
    layout
    {
        // Add changes to page layout here
        addafter("Internet Address")
        {
            field("Account No. Required"; "Account No. Required")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}