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
        
        let coverPage = CoverPDFPage(hasMargin: true,
                                     title: "This is the cover page title. Keep it short or keep it long",
                                     creditInformation: "Created By: github.com \r Sep 2018",
                                     headerText: "Some confidential info",
                                     footerText: "www.github.com",
                                     pageWidth: CGFloat(900.0),
                                     pageHeight: CGFloat(1200.0),
                                     hasPageNumber: true,
                                     pageNumber: 1)
        
        for page in 0..<aPDFDocument.pageCount {
            aPDFDocument.removePage(at: page)
        }
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
        let rap = pageWidth / pageHeight
        print(rap)
        
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
                                                 pageNumber: i+1,
                                                 pdfData: pdfDataArray as [AnyObject],
                                                 columnArray: columnInformation as [AnyObject])
            
            aPDFDocument.insert(tabularDataPDF, at: i+1)
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0] + "/sample1.pdf"
        aPDFDocument.write(toFile: userDesktopDirectory)
        
        self.infoLabel.isHidden = false
        self.infoLabel.stringValue = "Document saved to: " + userDesktopDirectory
        
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

