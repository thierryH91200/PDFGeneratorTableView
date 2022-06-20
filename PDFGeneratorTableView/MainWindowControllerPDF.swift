//
//  MainWindowController.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit
import Quartz

extension MainWindowController {
    
    @IBAction func generatePDF (_ sender:NSButton) {
        
        aPDFDocument = PDFDocument()
        
        // Option
        let coverPage = CoverPDFPage(hasMargin: true,
                                     title: "This is the cover page title. Keep it short or keep it long",
                                     creditInformation: "Created By: github.com \r June 2022",
                                     headerText: "Some confidential info",
                                     footerText: "www.github.com",
                                     pageWidth: CGFloat(595),
                                     pageHeight: CGFloat(842),
                                     hasPageNumber: true,
                                     pageNumber: 1)
        
        aPDFDocument.insert(coverPage, at: 0)
        
        let tableColumns = tableView.tableColumns
        columnInformation.removeAll()
        
        var offsetX = CGFloat(0)
        var sumWidth = CGFloat(0)
        for tableColumn in tableColumns {
            sumWidth += tableColumn.width
        }
        let rapport = 900.0 / sumWidth
        
        for tableColumn in tableColumns {
            let width = tableColumn.width * rapport
            let title = tableColumn.title
            let id = tableColumn.identifier.rawValue
            
            let dic = ["title": title, "id": id, "width": width, "offsetX": offsetX] as [String : Any]
            columnInformation.append( dic)
            
            offsetX += width
        }
        
        let pageWidth = offsetX + leftMargin + rightMargin
        let pageHeight = topMargin + verticalPadding + (CGFloat(numberOfRowsPerPage + 1) * defaultRowHeight) + verticalPadding + bottomMargin
        
        var numberOfPages = self.datas.count / numberOfRowsPerPage
        
        if self.datas.count % numberOfRowsPerPage > 0 {
            numberOfPages += 1
        }
        
        for i in 0 ..< numberOfPages
        {
            let startIndex = i * numberOfRowsPerPage
            var endIndex = i * numberOfRowsPerPage + numberOfRowsPerPage
            
            if endIndex > self.datas.count{
                endIndex = self.datas.count
            }
            
            let pdfDataArray:[AnyObject] = Array(self.datas[startIndex..<endIndex]) as [AnyObject]
            
            let tabularDataPDF = TabularPDFPage (hasMargin: true,
                                                 headerText: "confidential info...",
                                                 footerText: "www.github.com",
                                                 pageWidth: pageWidth,
                                                 pageHeight: pageHeight,
                                                 hasPageNumber: true,
                                                 pageNumber: i + 2,
                                                 pdfData: pdfDataArray as [AnyObject],
                                                 columnArray: columnInformation as [AnyObject])
            
            aPDFDocument.insert(tabularDataPDF, at: i + 1)
        }
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0] + "/sample1.pdf"
        
        aPDFDocument.write(toFile: userDesktopDirectory)
        
        self.infoLabel.isHidden = false
        self.infoLabel.stringValue = "Document saved to: " + userDesktopDirectory
        
//        if let path = Bundle.main.path(forResource: "sample1", ofType: "pdf"){
//            let url = URL.init(fileURLWithPath: path)
//            if let pdfDocument = PDFDocument(url: url) {
//                let count = pdfDocument.majorVersion
//
//                myPDFViewObject.document = pdfDocument
//                myPDFViewObject.autoScales = true
//                myPDFViewObject.layoutDocumentView()
//            }
//        }

    }
    
    @IBAction func sendMail (_ sender:NSButton) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0] + "/sample1.pdf"

        let fileURL = URL(fileURLWithPath: userDesktopDirectory)
        SendEmail.send(fileURL: fileURL)

    }
    
    @IBAction func actionThumb (_ sender:NSButton) {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0] + "/sample1.pdf"
        
        let url = URL(fileURLWithPath: userDesktopDirectory)
        aPDFDocument = PDFDocument(url: url)!
        myPDFViewObject.document = aPDFDocument
        myPDFViewObject.autoScales = true
        myPDFViewObject.layoutDocumentView()
        
        var thumbSize: NSSize = NSSize()
        thumbSize.width = 120
        thumbSize.height = 200
        self.pdfThumbnailView.thumbnailSize = thumbSize
        pdfThumbnailView.backgroundColor = .lightGray
        pdfThumbnailView.pdfView = myPDFViewObject
    }
    
    @IBAction func actionPrint (_ sender:NSButton) {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0] + "/sample1.pdf"
        
        let url = URL(fileURLWithPath: userDesktopDirectory)
        aPDFDocument = PDFDocument(url: url)!

        printDoc(aPDFDocument, using: window!)
    }
    
    func printDoc(_ pdfDocument: PDFDocument, using window: NSWindow) {
        
        let printInfo = NSPrintInfo.shared
        printInfo.isHorizontallyCentered = true
        printInfo.isVerticallyCentered = true
        printInfo.orientation = .portrait
        
        // create a hidden pdf view with the document
        let pdfView = PDFView()
        pdfView.document = aPDFDocument
        pdfView.autoScales = true
        pdfView.displaysPageBreaks = false
        pdfView.frame = NSMakeRect(0.0, 0.0, 50.0, 50.0)
        pdfView.isHidden = true
        
        // add the view to the window and print
        self.window!.contentView!.addSubview(pdfView)
        pdfView.print(with: printInfo, autoRotate: true, pageScaling: .pageScaleToFit)
        
        pdfView.removeFromSuperview()
    }
}

class SendEmail: NSObject {
    static func send(fileURL : URL) {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
        service.recipients = ["email@yourEmail.eu"]
        service.subject = "Send Pdf"
        
        let items: [Any] = ["see attachment", fileURL]
        service.perform(withItems: items)
    }
}

