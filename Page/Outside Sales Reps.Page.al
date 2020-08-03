page 50050 "Outside Sales Reps"
{
    PageType = List;
    SourceTable = "Outside Sales Reps";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Rep Code";"Rep Code")
                {
                }
                field("Rep Name";"Rep Name")
                {
                }
                field("Rep Company";"Rep Company")
                {
                    Visible = false;
                }
                field("Rep Address 1";"Rep Address 1")
                {
                    Visible = false;
                }
                field("Rep City";"Rep City")
                {
                    Visible = false;
                }
                field("Rep State";"Rep State")
                {
                    Visible = false;
                }
                field("Rep Zip";"Rep Zip")
                {
                    Visible = false;
                }
                field("Commission %";"Commission %")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

