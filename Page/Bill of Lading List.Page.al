page 50035 "Bill of Lading List"
{
    Editable = false;
    PageType = List;
    SourceTable = BillofLading;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill of Lading";"Bill of Lading")
                {
                }
                field(Type;Type)
                {
                }
                field("Order No.";"Order No.")
                {
                }
                field(Customer;Customer)
                {
                }
                field(Employee;Employee)
                {
                }
                field("Shipment Date";"Shipment Date")
                {
                }
                field("Container Quantity";"Container Quantity")
                {
                }
                field("Container Type";"Container Type")
                {
                }
                field(Carrier;Carrier)
                {
                }
                field("Shipping Method";"Shipping Method")
                {
                }
                field("Shipping Charge";"Shipping Charge")
                {
                }
                field("Shipping Account";"Shipping Account")
                {
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

