
//
//  MyPrintView.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit

class MyPrintViewTable: NSView
{
    weak var tableToPrint: NSTableView?
    
    var header = ""
    var attributes: [NSAttributedString.Key : Any] = [:]
    
    var listFont = NSFont(name: "Helvetica", size: 10.0)
    var headerHeight : CGFloat = 0.0
    var footerHeight : CGFloat = 0.0
    var lineHeight   : CGFloat = 0.0
    var entryHeight  : CGFloat = 0.0
    var pageRect               = NSRect.zero
    var linesPerPage           = 0
    var currentPage            = 0
    
    override  var printJobTitle : String {
        return ""
    }
    
    init(tableView tableToPrint: NSTableView?, andHeader header: String?) {
        // Initialize with dummy frame
        super.init(frame: NSMakeRect(0, 0, 700, 700))
        
        self.tableToPrint = tableToPrint
        self.header = header!
        listFont = NSFont(name: "Helvetica", size: 10.0)
        
        lineHeight = listFont!.boundingRectForFont.size.height
        entryHeight = listFont!.capHeight * 3
        headerHeight = 20 + entryHeight
        footerHeight = 20
        
        attributes = [NSAttributedString.Key.font: listFont!]
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Pagination
    override func knowsPageRange(_ range: NSRangePointer) -> Bool {
        
        let printInfo = NSPrintOperation.current?.printInfo
        pageRect = (printInfo?.imageablePageBounds)!
 
        var newFrame = NSRect.zero
        newFrame.size = printInfo?.paperSize ?? CGSize.zero
        self.frame = newFrame
        
        // Number of lines per page
        linesPerPage = Int((pageRect.size.height - headerHeight - footerHeight) / entryHeight - CGFloat(1))
        
        // Number of full pages
        var noPages: Int = tableToPrint!.numberOfRows / linesPerPage
        
        // Rest of lines on last page
        if tableToPrint!.numberOfRows % linesPerPage > 0 {
            noPages += 1
        }
        range.pointee.location = 1
        range.pointee.length = noPages
        return true
    }
    
    override func rectForPage(_ page: Int) -> NSRect {
        currentPage = page - 1
        return pageRect
    }
    
    override var pageHeader: NSAttributedString {
        return NSAttributedString(string: header)
    }
    
    // MARK: Drawing
    
    // Origin top left
    override var isFlipped: Bool {
        return true
    }

    // This is where the drawing takes place
    override func draw(_ dirtyRect: NSRect) {
        
        let margin: CGFloat = 20
        let leftMargin = pageRect.origin.x + margin
        let topMargin = pageRect.origin.y + headerHeight
        NSBezierPath.defaultLineWidth = 0.25
        
        var originalWidth: CGFloat = 0
        for column in tableToPrint!.tableColumns {
            originalWidth += column.width
        }
        let widthQuotient = (pageRect.size.width - margin) / originalWidth
        let inset = (entryHeight - lineHeight - 1.0) / 2.0
        
        // Column titles
        var horizontalOffset: CGFloat = 0
        for column in tableToPrint!.tableColumns {
            
            let headerRect = NSMakeRect(
                leftMargin + horizontalOffset,
                topMargin,
                widthQuotient * column.width,
                entryHeight)
            
            horizontalOffset += widthQuotient * column.width
            
            let bpath = NSBezierPath(rect: headerRect)
            NSColor.red.setFill()
            bpath.fill()
            
            NSColor.blue.set()
            bpath.stroke()
            bpath.close()
            
            let columnTitle = column.title
            columnTitle.draw(in: NSInsetRect(headerRect, inset, inset), withAttributes: attributes)
        }
        
        let firstEntryOfPage = currentPage * linesPerPage
        let lastEntryOfPage = ((currentPage + 1) * linesPerPage) > tableToPrint!.numberOfRows ? tableToPrint!.numberOfRows : ((currentPage + 1) * linesPerPage)
        
        for i in 0..<( lastEntryOfPage - firstEntryOfPage) {
            
            let row = firstEntryOfPage + i
            var horizontalOffset: CGFloat = 0
            var numCol = 0
            for column in tableToPrint!.tableColumns {
                
                var valueAsStr = ""
                
                let tableCellView = tableToPrint?.view(atColumn: numCol, row: row, makeIfNecessary: true) as! NSTableCellView
                valueAsStr = (tableCellView.textField?.stringValue)!
                let color = (tableCellView.textField?.textColor)!
                attributes[.foregroundColor] = color

                let rect = NSMakeRect(
                    leftMargin + horizontalOffset,
                    topMargin + CGFloat(i + 1) * entryHeight,
                    widthQuotient * column.width,
                    entryHeight)
                
                horizontalOffset += widthQuotient * column.width
                
                // Now we can finally draw the entry
                let bezierPath = NSBezierPath(rect: rect)
                
                NSColor.black.set()
                bezierPath.stroke()
                bezierPath.close()

                let stringRect = NSInsetRect(rect, inset, inset)
                valueAsStr.draw(in: stringRect, withAttributes: attributes)
                
                numCol += 1
            }
        }
    }
}



