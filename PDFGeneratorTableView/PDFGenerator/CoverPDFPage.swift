//
//  CoverPDFPage.swift
//  PDFGeneratorTableView
//
//  Created by thierry hentic on 18/05/2019.
//  Copyright © 2019 thierryH24. All rights reserved.
//

import AppKit
import Quartz


// option
class CoverPDFPage: BasePDFPage{
    var pdfTitle = "Default PDF Title"
    var creditInformation = "Default Credit Information"
    
    init(hasMargin:Bool,
         title:String,
         creditInformation:String,
         headerText:String,
         footerText:String,
         pageWidth:CGFloat,
         pageHeight:CGFloat,
         hasPageNumber:Bool,
         pageNumber:Int)
    {
        super.init(hasMargin: hasMargin,
                   headerText: headerText,
                   footerText: footerText,
                   pageWidth: pageWidth,
                   pageHeight: pageHeight,
                   hasPageNumber: hasPageNumber,
                   pageNumber: pageNumber)
        
        self.pdfTitle = title
        self.creditInformation = creditInformation
    }
    
    override func draw(with box: PDFDisplayBox , to context: CGContext) {
        super.draw(with: box, to : context)
        
        NSUIGraphicsPushContext(context)

        self.drawPDFTitle()
        self.drawPDFCreditInformation()
        
        NSUIGraphicsPopContext()
    }
    
    func drawPDFTitle()
    {
        let pdfTitleX = 1/4 * self.pdfWidth
        let pdfTitleY = self.pdfHeight / 2
        let pdfTitleWidth = 1/2 * self.pdfWidth
        let pdfTitleHeight = 1/5 * self.pdfHeight
        let titleFont = NSFont(name: "Helvetica Bold", size: 30.0)
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center
        
        let titleFontAttributes : [NSAttributedString.Key: Any] = [
            .font: titleFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle: titleParagraphStyle,
            .foregroundColor: NSColor.blue
        ]
        
        let titleRect = NSRect(x: pdfTitleX, y: pdfTitleY, width: pdfTitleWidth, height: pdfTitleHeight)
        self.pdfTitle.draw(in: titleRect, withAttributes: titleFontAttributes)

    }
    
    func drawPDFCreditInformation()
    {

        let pdfCreditX = 1/4 * self.pdfWidth
        let pdfCreditY = self.pdfHeight / 2 - 1/5 * self.pdfHeight
        let pdfCreditWidth = 1/2 * self.pdfWidth
        let pdfCreditHeight = CGFloat(40.0)
        let creditFont = NSFont(name: "Helvetica", size: 15.0)
        
        let creditParagraphStyle = NSMutableParagraphStyle()
        creditParagraphStyle.alignment = .center
        
        let creditFontAttributes : [NSAttributedString.Key: Any] = [
            .font: creditFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle: creditParagraphStyle,
            .foregroundColor: NSColor.darkGray
        ]
        
        let creditRect = NSMakeRect(pdfCreditX, pdfCreditY, pdfCreditWidth, pdfCreditHeight)
        self.creditInformation.draw(in: creditRect, withAttributes: creditFontAttributes)
    }
    
}
