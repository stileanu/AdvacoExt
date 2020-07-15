enum 50032 BankAcctFormat
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Bank Account No.") { }
    value(2; "Transit No.") { }
    value(3; "Check No.") { }
}
enum 50033 CheckLayout
{
    Extensible = true;

    value(0; "Stub-Check") { }
    value(1; "Stub-Check-Stub") { }
    value(2; "Stub-Stub-Check") { }
    value(3; "Check-Stub") { }
    value(4; "Check-Stub-Stub") { }
}
