//
//  BasePDFPage.swift
//  PDFGeneratorTableView
//
//  Created by thierry hentic on 18/05/2019.
//  Copyright © 2019 thierryH24. All rights reserved.
//

import AppKit
import Quartz

class BasePDFPage :PDFPage{
    
    var hasMargin = true
    var headerText = "Default Header Text"
    var footerText = "Default Footer Text"
    
    var hasPageNumber = true
    var pageNumber = 1
    
    var pdfHeight = CGFloat(1024.0) //This is configurable
    var pdfWidth = CGFloat(768.0)   //This is configurable and is calculated based on the number of columns
    
    init(hasMargin:Bool,
         headerText:String,
         footerText:String,
         pageWidth:CGFloat,
         pageHeight:CGFloat,
         hasPageNumber:Bool,
         pageNumber:Int)
    {
        super.init()
        self.hasMargin = hasMargin
        self.headerText = headerText
        self.footerText = footerText
        self.pdfWidth = pageWidth
        self.pdfHeight = pageHeight
        self.hasPageNumber = hasPageNumber
        self.pageNumber = pageNumber
    }
    
    override func draw(with box: PDFDisplayBox, to context: CGContext)  {
        if hasPageNumber ==  true {
            self.drawPageNumbers()
        }
        if hasMargin == true {
            self.drawMargins()
        }
        if headerText.count > 0 {
            self.drawHeader()
        }
        if footerText.count > 0 {
            self.drawFooter()
        }
    }
    
    override func bounds(for box: PDFDisplayBox) -> NSRect
    {
        return NSRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight)
    }

    func drawLine( _ fromPoint:NSPoint,  toPoint:NSPoint){
        let path = NSBezierPath()
        NSColor.lightGray.set()
        path.move(to: fromPoint)
        path.line(to: toPoint)
        path.lineWidth = 0.5
        path.stroke()
    }
    
    func drawHeader(){
        let headerTextX = leftMargin
        let headerTextY = self.pdfHeight - CGFloat(35.0)
        let headerTextWidth = self.pdfWidth - leftMargin - rightMargin
        let headerTextHeight = CGFloat(20.0)
        
        let headerFont = NSFont(name: "Helvetica", size: 15.0)
        
        let headerParagraphStyle = NSMutableParagraphStyle()
        headerParagraphStyle.alignment = .right
        
        let headerFontAttributes : [NSAttributedString.Key: Any] = [
            .font: headerFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle : headerParagraphStyle,
            .foregroundColor : NSColor.lightGray
        ]
        let headerRect = NSMakeRect(headerTextX, headerTextY, headerTextWidth, headerTextHeight)
        self.headerText.draw(in: headerRect, withAttributes: headerFontAttributes)
    }
    
    func drawFooter(){
        let footerTextX = leftMargin
        let footerTextY = CGFloat(15.0)
        let footerTextWidth = self.pdfWidth / 2.1
        let footerTextHeight = CGFloat(20.0)
        
        let footerFont = NSFont(name: "Helvetica", size: 15.0)
        
        let footerParagraphStyle = NSMutableParagraphStyle()
        footerParagraphStyle.alignment = .left
        
        let footerFontAttributes : [NSAttributedString.Key: Any] = [
            .font: footerFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle:footerParagraphStyle,
            .foregroundColor:NSColor.lightGray
        ]
        
        let footerRect = NSMakeRect(footerTextX, footerTextY, footerTextWidth, footerTextHeight)
        self.footerText.draw(in: footerRect, withAttributes: footerFontAttributes)
        
    }
    
    func drawMargins(){
        let borderLine = NSMakeRect(leftMargin, bottomMargin, self.pdfWidth - leftMargin - rightMargin, self.pdfHeight - topMargin - bottomMargin)
        NSColor.gray.set()
        __NSFrameRectWithWidth(borderLine, 0.5)
    }
    
    func drawPageNumbers()
    {
        let pageNumTextX = self.pdfWidth / 2
        let pageNumTextY = CGFloat(15.0)
        let pageNumTextWidth = CGFloat(40.0)
        let pageNumTextHeight = CGFloat(20.0)
        
        let pageNumFont = NSFont(name: "Helvetica", size: 15.0)
        
        let pageNumParagraphStyle = NSMutableParagraphStyle()
        pageNumParagraphStyle.alignment = .center
        
        let pageNumFontAttributes : [NSAttributedString.Key: Any] = [
            .font: pageNumFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle: pageNumParagraphStyle,
            .foregroundColor: NSColor.darkGray
        ]
        
        let pageNumRect = NSMakeRect(pageNumTextX, pageNumTextY, pageNumTextWidth, pageNumTextHeight)
        let pageNumberStr = "\(self.pageNumber)"
        pageNumberStr.draw(in: pageNumRect, withAttributes: pageNumFontAttributes)
    }
    
}
