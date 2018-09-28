
//
//  MyPrintView.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit

class MyPrintViewOutline: NSView
{
    weak var tableToPrint: NSOutlineView?
    
    var header = ""
    var attributes: [NSAttributedString.Key : Any] = [:]
    
    var listFont = NSFont(name: "Helvetica", size: 10.0)
    var headerHeight : CGFloat = 0.0
    var footerHeight : CGFloat = 0.0
    var lineHeight   : CGFloat = 0.0
    var rowHeight  : CGFloat = 0.0
    var pageRect               = NSRect.zero
    var linesPerPage           = 0
    var currentPage            = 0
    
    var rightMargin          = CGFloat(20.0)
    let bottomMargin         = CGFloat (40.0)
    var leftMargin : CGFloat = 0
    var topMargin  : CGFloat = 0
    var numberOfRows         = 0
    var numberOfRowsByPage   = 0

    let margin: CGFloat = 20
    
    var  widthQuotient : CGFloat = 0

    override  var printJobTitle : String {
        return ""
    }
    
    init(tableView tableToPrint: NSOutlineView?, andHeader header: String?) {
        // Initialize with dummy frame
        super.init(frame: NSMakeRect(0, 0, 700, 700))
        
        self.tableToPrint = tableToPrint
        
        self.header = header!
        listFont = NSFont(name: "Helvetica", size: 10.0)
        
        lineHeight = listFont!.boundingRectForFont.size.height
        rowHeight = listFont!.capHeight * 2.5
        headerHeight = margin + rowHeight
        footerHeight = margin
        
        leftMargin = pageRect.origin.x + margin
        topMargin = pageRect.origin.y + headerHeight
        numberOfRows = tableToPrint!.numberOfRows
        
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
        linesPerPage = Int((pageRect.size.height - headerHeight - footerHeight) / rowHeight - CGFloat(1))
        
        // Number of full pages
        var noPages: Int = numberOfRows / linesPerPage
        
        // Rest of lines on last page
        if numberOfRows % linesPerPage > 0 {
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
        
        NSBezierPath.defaultLineWidth = 0.1
        
        var originalWidth: CGFloat = 0
        for column in tableToPrint!.tableColumns {
            originalWidth += column.width
        }
        widthQuotient = (pageRect.size.width - margin) / originalWidth

        
        let inset = (rowHeight - lineHeight - 1.0) / 2.0
        
        // Column titles
        var horizontalOffset: CGFloat = 0
        for column in tableToPrint!.tableColumns {
            
            let headerRect = NSMakeRect(
                leftMargin + horizontalOffset,
                topMargin,
                widthQuotient * column.width,
                rowHeight)
            
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
        numberOfRowsByPage = lastEntryOfPage - firstEntryOfPage
        
        for i in 0..<( lastEntryOfPage - firstEntryOfPage) {
            
            let row = firstEntryOfPage + i
            var horizontalOffset: CGFloat = 0
            var numCol = 0
            var ofx : CGFloat = 16
            
            for column in tableToPrint!.tableColumns {
                
                var valueAsStr = ""
                
                // Header ???
                if let tableCellView = tableToPrint?.view(atColumn: numCol, row: row, makeIfNecessary: true) as? KSHeaderCellView {
                    
                    // draw triangle
                    let rectDis = NSMakeRect( leftMargin + horizontalOffset, topMargin +  rowHeight * CGFloat(i + 1) + 4, 8 , 8)
                    
                    let center = CGPoint(x: rectDis.midX, y: rectDis.midY)
                    let side = rectDis.width
                    let bezierPathDis = trianglePathWithCenter(center: center, side: side)
                    
                    bezierPathDis.stroke()
                    bezierPathDis.fill()
                    bezierPathDis.close()

                    // Now we can finally draw the entry
                    valueAsStr = (tableCellView.textField?.stringValue)!
                    attributes[.foregroundColor] = (tableCellView.textField?.textColor)!
                    
                    let fillColor = tableCellView.fillColor
                    
                    let rect = NSMakeRect(
                        leftMargin + horizontalOffset + 10 ,
                        topMargin + rowHeight * CGFloat(i + 1),
                        (pageRect.size.width - margin - 10 ) ,
                        rowHeight)
                    
                    horizontalOffset += widthQuotient * column.width
                    
                    let bezierPath = NSBezierPath(rect: rect)
                    fillColor.set()
                    bezierPath.fill()
                    
                    NSColor.lightGray.set()
                    bezierPath.stroke()
                    bezierPath.close()
                    
                    let stringRect = NSInsetRect(rect, inset, inset)
                    valueAsStr.draw(in: stringRect, withAttributes: attributes)
                }
                else
                    
                    if let tableCellView = tableToPrint?.view(atColumn: numCol, row: row, makeIfNecessary: true) as? NSTableCellView {
                        valueAsStr = (tableCellView.textField?.stringValue)!
                        attributes[.foregroundColor] = (tableCellView.textField?.textColor)!
                        
                        let rect = NSMakeRect(
                            leftMargin + horizontalOffset + ofx,
                            topMargin +  rowHeight * CGFloat(i + 1),
                            widthQuotient * column.width - 2,
                            rowHeight)
                        
                        horizontalOffset += widthQuotient * column.width
                        
                        let stringRect = NSInsetRect(rect, inset, inset)
                        valueAsStr.draw(in: stringRect, withAttributes: attributes)
                        
                        if ofx == 16 {
                            ofx = 2
                        }

                }
                numCol += 1
            }
            drawVerticalGrids()
            drawHorizontalGrids()

        }
    }
    
    func trianglePathWithCenter(center: CGPoint, side: CGFloat) -> NSBezierPath {
        let path = NSBezierPath()
        
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.line(to: CGPoint(x: startX + side, y: startY ))
        path.line(to: CGPoint(x: startX + side/2, y: startY + side))
        path.close()
        
        return path
    }
    
    func drawVerticalGrids(){
        
        let columns = tableToPrint!.tableColumns
        var offsetX : CGFloat = 0.0
        
        var fromPoint = CGPoint(x : leftMargin, y: topMargin + rowHeight )
        var toPoint   = CGPoint(x : leftMargin, y: topMargin + rowHeight * CGFloat(numberOfRowsByPage + 1 ))
        drawLine(fromPoint, toPoint: toPoint)

        for i in 0..<columns.count {
            
            offsetX += widthQuotient * columns[i].width

            //draw the vertical lines
            fromPoint = NSMakePoint(
                leftMargin + offsetX ,
                topMargin + rowHeight )
            
            toPoint = NSMakePoint(
                leftMargin + offsetX ,
                topMargin + rowHeight * CGFloat(numberOfRowsByPage + 1 ) )
            
            drawLine(fromPoint, toPoint: toPoint)
        }
    }
    
    func drawHorizontalGrids() {
        
        for i in 0...numberOfRowsByPage {
            let fromPoint = NSMakePoint(
                leftMargin ,
                topMargin + rowHeight + (CGFloat(i) * rowHeight)
            )
            let toPoint = NSMakePoint(
                leftMargin + pageRect.size.width - rightMargin,
                topMargin + rowHeight + (CGFloat(i) * rowHeight)
            )
            drawLine(fromPoint, toPoint: toPoint)
        }
    }
    
    func drawLine( _ fromPoint:NSPoint,  toPoint:NSPoint){
        let path = NSBezierPath()
        NSColor.gray.set()
        path.move(to: fromPoint)
        path.line(to: toPoint)
        path.lineWidth = 0.5
        path.stroke()
    }

}



