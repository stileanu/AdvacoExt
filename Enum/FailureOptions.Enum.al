enum 50021 FailureItem
{
    Extensible = true;

    value(0; " ") { }
    value(1; Pump) { }
    value(2; Motor) { }
    value(3; "Assembly") { }
    value(4; Component) { }
    value(5; Finish) { }
    value(6; Hardware) { }
    value(7; "Label") { }
    value(8; Cover) { }
    value(9; Base) { }
    value(10; "Belt Guard") { }
    value(11; Feet) { }
    value(12; Tubing) { }
    value(13; "Heat Exchanger") { }
    value(14; Pulley) { }
    value(15; Ballast) { }
    value(16; "Oil Prep.") { }
    value(17; "Line Cord") { }
    value(18; Documentation) { }
}
enum 50022 FailureCode
{
    Extensible = true;

    value(0; " ") { }
    value(1; Missing) { }
    value(2; Wrong) { }
    value(3; Loose) { }
    value(4; "Broken/Cracked") { }
    value(5; "Not Clean") { }
    value(6; "Defective/Damaged") { }
    value(7; Contaiminated) { }
    value(8; "Out of Dim") { }
    value(9; "Mis-Alignment") { }
    value(10; Peeling) { }
    value(11; "Surface Damage") { }
    value(12; "Vacuum Leak") { }
    value(13; "Poor Vacuum") { }
    value(14; "Poor Pumping Speed") { }
    value(15; "Leaks Oil") { }
    value(16; "Seal Leak") { }
    value(17; "Case Gasket Leaks") { }
    value(18; "Window Leaks") { }
    value(19; "Tubing Leaks") { }
    value(20; Seized) { }
    value(21; Noise) { }
    value(22; "Defective Bearings") { }
    value(23; "High Vibration") { }
    value(24; Configuration) { }
}
enum 50023 FailureDept
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Production Assembly") { }
    value(2; Test) { }
    value(3; "Quality Control") { }
}
enum 50024 PumpFailureDept
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Failure Analysis") { }
    value(2; "Production Assembly") { }
    value(3; Test) { }
    value(4; "Quality Control") { }
}
enum 50025 FailWorkReq
{
    Extensible = true;

    value(0; " ") { }
    value(1; "Repaired at Test") { }
    value(2; "Rework Required") { }
}