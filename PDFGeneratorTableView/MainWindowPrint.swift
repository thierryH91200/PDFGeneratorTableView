//
//  MainWindowToolBar.swift
//  Soroban Account
//
//  Created by thierryH24 on 07/02/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit

class PaginatedTable : NSTableView {
    
    var table : NSTableView!
    
    var topBorderRows = [Int]()
    var bottomBorderRows = [Int]()
    
    var datas = [[String: Any]]()
    
    
    
    override func adjustPageHeightNew(_ newBottom: UnsafeMutablePointer<CGFloat>, top oldTop: CGFloat, bottom oldBottom: CGFloat, limit bottomLimit: CGFloat) {
        
        topBorderRows.removeAll()
        bottomBorderRows.removeAll()
        
        let cutoffRow = row(at: NSMakePoint(0, oldBottom))
        var rowBounds = NSRect.zero
        
        newBottom.pointee = oldBottom
        if cutoffRow != -1
        {
            rowBounds = rect(ofRow: cutoffRow)
            if oldBottom < NSMaxY(rowBounds) {
                newBottom.pointee = NSMinY(rowBounds)
                let row = cutoffRow
                let previousRow = cutoffRow - 1
                
                // Mark which rows need which border, ignore ones we've already seen, and adjust ones that need different borders
                if !(topBorderRows.last == row) {
                    if bottomBorderRows.last == row {
                        topBorderRows.removeLast()
                        bottomBorderRows.removeLast()
                    }
                    topBorderRows.append(row)
                    bottomBorderRows.append(previousRow)
                }
            }
        }
    }
    
    // Draw the row as normal, and add any borders to cells that were pushed down due to pagination
    override func drawRow(_ rowIndex: Int, clipRect: NSRect) {
        super.drawRow(rowIndex, clipRect: clipRect)
        guard topBorderRows.count != 0  else { return  }
        
        let rowRect = rect(ofRow: rowIndex)
        let gridPath = NSBezierPath()
        let color = NSColor.darkGray
        
        for i in 0..<topBorderRows.count {
            let rowNeedingTopBorder = topBorderRows[i]
            if rowNeedingTopBorder == rowIndex {
                gridPath.move(to: rowRect.origin)
                gridPath.line(to: NSMakePoint(rowRect.origin.x + rowRect.size.width, rowRect.origin.y))
                color.setStroke()
                gridPath.stroke()
            }
            let rowNeedingBottomBorder = bottomBorderRows[i]
            if rowNeedingBottomBorder == rowIndex {
                gridPath.move(to: NSMakePoint(rowRect.origin.x, rowRect.origin.y + rowRect.size.height))
                gridPath.line(to: NSMakePoint(rowRect.origin.x + rowRect.size.width, rowRect.origin.y + rowRect.size.height))
                color.setStroke()
                gridPath.stroke()
            }
        }
    }
    
    override var pageHeader: NSAttributedString {
        return NSAttributedString(string: "bla bla bla")
        
    }
    override var pageFooter: NSAttributedString {
        return NSAttributedString(string: "ribla ribla ribla")
    }
    
    
    func drawPageNumber(_ pageNum: Int) {
        
        let pageString = "Page \(pageNum)"
        
        let attribut = [NSAttributedString.Key.font : NSFont.systemFont(ofSize: 12)]
        let pageStringSize = pageString.size(withAttributes:attribut)
        
        let stringRect = CGRect(x: (612.0 - pageStringSize.width) / 2.0, y: 720.0 + ((72.0 - pageStringSize.height) / 2.0), width: pageStringSize.width, height: pageStringSize.height)
        pageString.draw(in: stringRect, withAttributes: attribut)
    }
    
    //    func rowArray(forItem item: datas) -> [String] {
    //        var dateString = ""
    //
    //        let aDate = item.dateCree
    //        dateString = DateFormatter.localizedString(from: aDate!, dateStyle: .medium, timeStyle: .none)
    //
    //
    //        var amountString = ""
    //        let anAmount = item.montant as NSNumber
    //        let formatter = NumberFormatter()
    //        formatter.numberStyle = .currency
    //        formatter.string(from: anAmount)
    //        amountString = formatter.string(from: anAmount)!
    //
    //        let descriptionString = item.libelle
    //        let categoryString = item.category!.name
    //
    //        return [dateString, amountString, descriptionString!, categoryString!]
    //    }
    
    //    func printOperation(withSettings printSettings: [NSPrintInfo.AttributeKey : Any]) throws -> NSPrintOperation {
    //
    //
    //        var pInfo = NSPrintInfo()
    //        pInfo.horizontalPagination = .fit // This will keep the text table from spanning more than one page across.
    //        pInfo.isVerticallyCentered = false
    //
    //        pInfo.dictionary()[NSPrintInfo.AttributeKey.headerAndFooter] = 1
    //        for (k, v) in printSettings { pInfo.dictionary()[k] = v }
    //        var printView = NSTextView(frame: pInfo.imageablePageBounds) // Create a text view with one page as its size
    //
    //        printView.printJobTitle = "Expense Report" // The name used as default for save as PDF and for the default header
    //        var tPrint = MSTablePrint()
    //
    //        // Set up the fetch request to retrive all Expense entities
    //
    //        var entity = NSEntityDescription.entity(forEntityName: "Expense", in: mainObjectContext)
    //
    //        request.entity = entity
    //
    //        var items = try? mainObjectContext.fetch(request)
    //
    //        var anError: Error? = nil
    //        var headerArray = ["Date", "Amount", "Description", "Category"]
    //
    //        // create the first row of the text table with headers
    //        var itemArray: [AnyHashable] = [] // create the array we will be passing to MSTablePrint
    //        itemArray.append(headerArray) // whatever is at index 0 of this array will become the first row so we add the headers here
    //
    //        for z in items {
    //            // Step through each Expense entity in the array and create an array to represent the entity.
    //            itemArray.append(rowArray(forItem: z))
    //        }
    //
    //        var atString: NSAttributedString? = tPrint.attributedString(fromItems: itemArray) //create the text table
    //        if let aString = atString {
    //            printView.textStorage?.setAttributedString(aString)
    //        }
    //
    //        var printOp = NSPrintOperation(view: printView, printInfo: pInfo) // Setup the actual print operation
    //        return printOp
    //    }
    //
}

private func documentSizeForPrintInfo(printInfo: NSPrintInfo) -> NSSize
{
    var paperSize = printInfo.paperSize
    paperSize.width -= (printInfo.leftMargin + printInfo.rightMargin) - defaultTextPadding * 2.0
    paperSize.height -= (printInfo.topMargin + printInfo.bottomMargin)
    return paperSize
}

private var defaultTextPadding: CGFloat =
{
    let container = NSTextContainer()
    return container.lineFragmentPadding
}()

private func roundPercentage(_ input: CGFloat) -> CGFloat
{
    return (floor(input * 100.0) * 0.01)
}

extension PaginatedTable: NSTableViewDataSource {
    
    func numberOfRows(in aTableView: NSTableView) -> Int {
        return datas.count
    }
    
    
}
