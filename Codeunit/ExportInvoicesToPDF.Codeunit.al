codeunit 50023 ExportInvoicesToPDF
{
    // version PDF10.02.01


    trigger OnRun();
    begin
    end;

    var
        customer: Record Customer;
        vendor: Record Vendor;
        sheader: Record "Sales Invoice Header";
        sheader2: Record "Sales Invoice Header";
        WOD2: Record WorkOrderDetail;
        header: Record "Purchase Header";
        header2: Record "Purchase Header";
        usersetup: Record "User Setup";
        pdfFileName: Text[250];
        statusFileName: Text[250];
        certificateFileName: Text[250];
        certificatePassword: Text[30];
        backgroundFileName: Text[250];
        mergeBeforeFileName: Text[250];
        mergeAfterFileName: Text[250];
        baseFolder: Text[250];
        //pdfSettings : Automation "'{A3F69B34-EAD8-4A3B-8DD5-C1C3FD300D67}' 4.0:'{F6C83BBD-F620-4F13-8320-9C51D1996EC4}':''{A3F69B34-EAD8-4A3B-8DD5-C1C3FD300D67}' 4.0'.ComPdfSettings";
        //pdfUtil : Automation "'{A3F69B34-EAD8-4A3B-8DD5-C1C3FD300D67}' 4.0:'{F9444F96-C32A-4745-9FF3-9059B92CDAB0}':''{A3F69B34-EAD8-4A3B-8DD5-C1C3FD300D67}' 4.0'.ComPdfUtil";
        pdfFolderName: Text[200];
        counter: Integer;

    procedure PrintToPDF(InvNo: Code[20]; CustNo: Code[20]; var FileFullName: Text[250]): Boolean;
    begin
        /*
        CREATE(pdfSettings);
        CREATE(pdfUtil);
        */
        customer.GET(CustNo);
        sheader.GET(InvNo);


        baseFolder := customer."Path to PDF";
        IF COPYSTR(baseFolder, STRLEN(baseFolder), 1) = '\' THEN
            baseFolder := COPYSTR(baseFolder, 1, STRLEN(baseFolder) - 1);

        // The status file is used to check for errors and determine when the PDF is ready.
        //statusFileName := baseFolder + '\status.ini';

        // Set file name for output file.
        pdfFileName := baseFolder + '\' + sheader."No." + '.pdf';
        FileFullName := pdfFileName;

        // Delete old output file if it already exist.
        //IF EXISTS(pdfFileName) THEN ERASE(pdfFileName);

        // Multiple PDF printers could be installed.
        // Let the automation know which one to control.
        //pdfSettings.printerName := pdfUtil.DefaultPrinterName;

        // Set output file name
        //pdfSettings.SetValue('Output', pdfFileName);

        // Make sure no dialogs are shown during conversion.
        /*
        pdfSettings.SetValue('ShowSaveAs', 'never');
        pdfSettings.SetValue('ShowSettings', 'never');
        pdfSettings.SetValue('ShowPDF', 'no');
        pdfSettings.SetValue('ShowProgress', 'no');
        pdfSettings.SetValue('ShowProgressFinished', 'no');
        pdfSettings.SetValue('ConfirmOverwrite', 'no');

        // Set file name of status file to wait for.
        pdfSettings.SetValue('StatusFile', statusFileName);

        // Do not show errors in PDF user interface.
        pdfSettings.SetValue('SuppressErrors', 'yes');

        // Write settings to printer.
        // This writes a file name runonce.ini. It is a configuration that is used
        // for the next print job. The printer will delete the runonce.ini after it
        // is read.
        pdfSettings.WriteSettings(TRUE);

        IF EXISTS(statusFileName) THEN ERASE(statusFileName);
        */
        sheader2.COPY(sheader);
        sheader2.SETRECFILTER;

        // to be replaced with Report.SaveAs function
        REPORT.RUNMODAL(50127, FALSE, FALSE, sheader2);

        /*
        IF pdfUtil.WaitForFile(statusFileName, 20000)  THEN BEGIN
          // Check status file for errors.
          IF pdfUtil.ReadIniString(statusFileName, 'Status', 'Errors', '') <> '0' THEN BEGIN
            ERROR('Error creating PDF. ' + pdfUtil.ReadIniString(statusFileName, 'Status', 'MessageText', ''));
          END;
        END ELSE BEGIN
          // The timeout elapsed. Something is wrong.
          ERROR('Error creating ' + pdfFileName);
          EXIT(FALSE);
        END;
        */
        EXIT(TRUE);
    end;

    procedure PrintPOToPDF(PONo: Code[20]; VendNo: Code[20]; var FileFullName: Text[250]): Boolean;
    begin
        //CREATE(pdfSettings);
        //CREATE(pdfUtil);

        vendor.GET(VendNo);
        header.GET(header."Document Type"::Order, PONo);

        baseFolder := vendor."Path to PDF";
        IF COPYSTR(baseFolder, STRLEN(baseFolder), 1) = '\' THEN
            baseFolder := COPYSTR(baseFolder, 1, STRLEN(baseFolder) - 1);

        // The status file is used to check for errors and determine when the PDF is ready.
        statusFileName := baseFolder + '\status.ini';

        // Set file name for output file.
        pdfFileName := baseFolder + '\' + header."No." + '.pdf';
        FileFullName := pdfFileName;

        // Delete old output file if it already exist.
        //IF EXISTS(pdfFileName) THEN ERASE(pdfFileName);

        /*
        // Multiple PDF printers could be installed.
        // Let the automation know which one to control.
        pdfSettings.printerName := pdfUtil.DefaultPrinterName;

        // Set output file name
        pdfSettings.SetValue('Output', pdfFileName);

        // Make sure no dialogs are shown during conversion.
        pdfSettings.SetValue('ShowSaveAs', 'never');
        pdfSettings.SetValue('ShowSettings', 'never');
        pdfSettings.SetValue('ShowPDF', 'no');
        pdfSettings.SetValue('ShowProgress', 'no');
        pdfSettings.SetValue('ShowProgressFinished', 'no');
        pdfSettings.SetValue('ConfirmOverwrite', 'no');

        // Set file name of status file to wait for.
        pdfSettings.SetValue('StatusFile', statusFileName);

        // Do not show errors in PDF user interface.
        pdfSettings.SetValue('SuppressErrors', 'yes');

        // Write settings to printer.
        // This writes a file name runonce.ini. It is a configuration that is used
        // for the next print job. The printer will delete the runonce.ini after it
        // is read.
        pdfSettings.WriteSettings(TRUE);

        IF EXISTS(statusFileName) THEN ERASE(statusFileName);
        */

        header2.COPY(header);
        header2.SETRECFILTER;

        // to be replaced with Report.SaveAs function
        REPORT.RUNMODAL(50129, FALSE, FALSE, header2);

        /*
        IF pdfUtil.WaitForFile(statusFileName, 20000) THEN BEGIN
            // Check status file for errors.
            IF pdfUtil.ReadIniString(statusFileName, 'Status', 'Errors', '') <> '0' THEN BEGIN
                ERROR('Error creating PDF. ' + pdfUtil.ReadIniString(statusFileName, 'Status', 'MessageText', ''));
            END;
        END ELSE BEGIN
            // The timeout elapsed. Something is wrong.
            ERROR('Error creating ' + pdfFileName);
            EXIT(FALSE);
        END;
        */

        EXIT(TRUE);
    end;

    procedure PrintQ2ToPDF(WODetail: Record WorkOrderDetail; var FileFullName: Text[250]): Boolean;
    begin
        //CREATE(pdfSettings);
        //CREATE(pdfUtil);

        customer.GET(WODetail."Customer ID");
        usersetup.GET(USERID);

        baseFolder := usersetup."PDF Path to Documents";
        IF COPYSTR(baseFolder, STRLEN(baseFolder), 1) = '\' THEN
            baseFolder := COPYSTR(baseFolder, 1, STRLEN(baseFolder) - 1);

        // The status file is used to check for errors and determine when the PDF is ready.
        statusFileName := baseFolder + '\status.ini';

        // Set file name for output file.
        pdfFileName := baseFolder + '\' + WODetail."Work Order No." + '.pdf';
        FileFullName := pdfFileName;

        /*
        // Delete old output file if it already exist.
        IF EXISTS(pdfFileName) THEN ERASE(pdfFileName);

        // Multiple PDF printers could be installed.
        // Let the automation know which one to control.
        pdfSettings.printerName := pdfUtil.DefaultPrinterName;

        // Set output file name
        pdfSettings.SetValue('Output', pdfFileName);

        // Make sure no dialogs are shown during conversion.
        pdfSettings.SetValue('ShowSaveAs', 'never');
        pdfSettings.SetValue('ShowSettings', 'never');
        pdfSettings.SetValue('ShowPDF', 'no');
        pdfSettings.SetValue('ShowProgress', 'no');
        pdfSettings.SetValue('ShowProgressFinished', 'no');
        pdfSettings.SetValue('ConfirmOverwrite', 'no');

        // Set file name of status file to wait for.
        pdfSettings.SetValue('StatusFile', statusFileName);

        // Do not show errors in PDF user interface.
        pdfSettings.SetValue('SuppressErrors', 'yes');

        // Write settings to printer.
        // This writes a file name runonce.ini. It is a configuration that is used
        // for the next print job. The printer will delete the runonce.ini after it
        // is read.
        pdfSettings.WriteSettings(TRUE);

        IF EXISTS(statusFileName) THEN ERASE(statusFileName);
        */

        WOD2.COPY(WODetail);
        WOD2.SETRECFILTER;

        // to be replaced with Report.SaveAs function
        REPORT.RUNMODAL(50093, FALSE, FALSE, WOD2);

        /*
        IF pdfUtil.WaitForFile(statusFileName, 20000) THEN BEGIN
            // Check status file for errors.
            IF pdfUtil.ReadIniString(statusFileName, 'Status', 'Errors', '') <> '0' THEN BEGIN
                ERROR('Error creating PDF. ' + pdfUtil.ReadIniString(statusFileName, 'Status', 'MessageText', ''));
            END;
        END ELSE BEGIN
            // The timeout elapsed. Something is wrong.
            ERROR('Error creating ' + pdfFileName);
            EXIT(FALSE);
        END;
        */

        EXIT(TRUE);
    end;

    procedure PrintQMToPDF(WODetail: Record WorkOrderDetail; var FileFullName: Text[250]; ReportToRun: Integer): Boolean;
    begin
        //CREATE(pdfSettings);
        //CREATE(pdfUtil);

        customer.GET(WODetail."Customer ID");
        usersetup.GET(USERID);

        baseFolder := usersetup."PDF Path to Documents";
        IF COPYSTR(baseFolder, STRLEN(baseFolder), 1) = '\' THEN
            baseFolder := COPYSTR(baseFolder, 1, STRLEN(baseFolder) - 1);

        // The status file is used to check for errors and determine when the PDF is ready.
        statusFileName := baseFolder + '\status.ini';

        // Set file name for output file.
        pdfFileName := baseFolder + '\' + WODetail."Work Order No." + '.pdf';
        FileFullName := pdfFileName;

        /*
        // Delete old output file if it already exist.
        IF EXISTS(pdfFileName) THEN ERASE(pdfFileName);

        // Multiple PDF printers could be installed.
        // Let the automation know which one to control.
        pdfSettings.printerName := pdfUtil.DefaultPrinterName;

        // Set output file name
        pdfSettings.SetValue('Output', pdfFileName);

        // Make sure no dialogs are shown during conversion.
        pdfSettings.SetValue('ShowSaveAs', 'never');
        pdfSettings.SetValue('ShowSettings', 'never');
        pdfSettings.SetValue('ShowPDF', 'no');
        pdfSettings.SetValue('ShowProgress', 'no');
        pdfSettings.SetValue('ShowProgressFinished', 'no');
        pdfSettings.SetValue('ConfirmOverwrite', 'no');

        // Set file name of status file to wait for.
        pdfSettings.SetValue('StatusFile', statusFileName);

        // Do not show errors in PDF user interface.
        pdfSettings.SetValue('SuppressErrors', 'yes');

        // Write settings to printer.
        // This writes a file name runonce.ini. It is a configuration that is used
        // for the next print job. The printer will delete the runonce.ini after it
        // is read.
        pdfSettings.WriteSettings(TRUE);

        IF EXISTS(statusFileName) THEN ERASE(statusFileName);
        */

        WOD2.COPY(WODetail);
        WOD2.SETRECFILTER;
        REPORT.RUNMODAL(ReportToRun, FALSE, FALSE, WOD2);

        /*
        IF pdfUtil.WaitForFile(statusFileName, 20000) THEN BEGIN
            // Check status file for errors.
            IF pdfUtil.ReadIniString(statusFileName, 'Status', 'Errors', '') <> '0' THEN BEGIN
                ERROR('Error creating PDF. ' + pdfUtil.ReadIniString(statusFileName, 'Status', 'MessageText', ''));
            END;
        END ELSE BEGIN
            // The timeout elapsed. Something is wrong.
            ERROR('Error creating ' + pdfFileName);
            EXIT(FALSE);
        END;
        */

        EXIT(TRUE);
    end;
}

