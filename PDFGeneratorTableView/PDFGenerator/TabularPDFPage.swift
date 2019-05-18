//
//  PDFManager.swift
//  PDFGenerator
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 SIC. All rights reserved.
//

import AppKit
import Quartz

class TabularPDFPage: BasePDFPage{
    
    var dataArray = [AnyObject]()
    var columnsArray = [AnyObject]()
//    var verticalPadding = CGFloat(10.0)
    
    init(hasMargin:Bool,
         headerText:String,
         footerText:String,
         pageWidth:CGFloat,
         pageHeight:CGFloat,
         hasPageNumber:Bool,
         pageNumber:Int,
         pdfData:[AnyObject],
         columnArray:[AnyObject])
    {
        super.init(hasMargin: hasMargin,
                   headerText: headerText,
                   footerText: footerText,
                   pageWidth: pageWidth,
                   pageHeight: pageHeight,
                   hasPageNumber: hasPageNumber,
                   pageNumber: pageNumber
        )
        self.dataArray = pdfData
        self.columnsArray = columnArray
    }
    
    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        super.draw(with: box, to: context)
        
        context.saveGState()
        let cx = NSGraphicsContext(cgContext: context, flipped: false)
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = cx

        self.drawTableData()
        self.drawVerticalGrids()
        self.drawHorizontalGrids()
        
        NSGraphicsContext.restoreGraphicsState()
        context.restoreGState()
    }
    
    func drawTableData(){
        
        //If draws column title = YES
        let titleFont = NSFont(name: "Helvetica Bold", size: 14.0)
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = .center

        let titleFontAttributes  : [NSAttributedString.Key: Any] = [
            .font: titleFont ?? NSFont.labelFont(ofSize: 12),
            .paragraphStyle: titleParagraphStyle,
            .foregroundColor: NSColor.gray
        ]
                
        for columnHeader in columnsArray {
            
            let columnTitle = columnHeader["title"] as! String
            
            let headerRect = NSMakeRect(
                leftMargin + (columnHeader["offsetX"] as! CGFloat),
                self.pdfHeight - topMargin - verticalPadding - defaultRowHeight,
                columnHeader["width"] as! CGFloat,
                defaultRowHeight + verticalPadding)
            
            let bpath = NSBezierPath(rect: headerRect)
            NSColor.red.setFill()
            bpath.fill()
            
            NSColor.blue.set()
            bpath.stroke()
            
            columnTitle.draw(in: headerRect, withAttributes: titleFontAttributes)
        }

        let keys = (0..<self.columnsArray.count).map { (i) -> String in
            return self.columnsArray[i]["id"] as! String
        }
        
        for row in 0 ..< self.dataArray.count
        {
            let dataDict = self.dataArray[row]
            for column in 0  ..< keys.count {
                
                let key = keys[column]
                let dataText = dataDict[ key ] as! String
                
                let dataRect = NSMakeRect(
                    leftMargin + textInset + (columnsArray[column]["offsetX"] as! CGFloat),
                    self.pdfHeight - topMargin - (2 * defaultRowHeight) - textInset - (CGFloat(row) * defaultRowHeight),
                    columnsArray[column]["width"] as! CGFloat - textInset,
                    defaultRowHeight - verticalPadding )
                
                dataText.draw(in: dataRect, withAttributes: nil)
            }
        }
        
    }
    
    func drawVerticalGrids(){
        
        for i in 0..<self.columnsArray.count {
            
            //draw the vertical lines
            let x = leftMargin + (columnsArray[i]["offsetX"] as! CGFloat)
            let fromPoint = NSPoint( x: x, y: self.pdfHeight - topMargin )
            let toPoint = NSPoint( x: x, y: bottomMargin )
            drawLine(fromPoint, toPoint: toPoint)
        }
    }
    
    func drawHorizontalGrids(){
        let rowCount = self.dataArray.count
        for i in 0...rowCount {
            let y = self.pdfHeight - topMargin - verticalPadding - defaultRowHeight - (CGFloat(i) * defaultRowHeight)
            let fromPoint = NSPoint( x: leftMargin ,                 y: y)
            let toPoint = NSPoint(   x: self.pdfWidth - rightMargin, y: y)
            
            drawLine(fromPoint, toPoint: toPoint)
        }
    }
    
}
