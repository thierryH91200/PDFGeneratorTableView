//
//  MainWindowController.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit
import Quartz

class MainWindowController: NSWindowController {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet weak var infoLabel: NSTextField!
    
    @IBOutlet weak var view: NSView!
    let aPDFDocument = PDFDocument()

    /// the data for the table
    var datas = [[String: Any]]()
    var columnInformation = [[String: Any]]()
    
    
    override var windowNibName: NSNib.Name? {
        return  "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        datas.append(["givenName": "Noah", "familyName": "Vale", "age": "72"] )
        datas.append(["givenName": "Sarah", "familyName": "Yayvo", "age": "29"])
        datas.append(["givenName": "Shanda", "familyName": "Lear", "age": "45"])
        datas.append(["givenName": "Heidi", "familyName": "Clare", "age": "45"])
        datas.append(["givenName": "Helen", "familyName": "Back", "age": "45"])
        datas.append(["givenName": "Jack", "familyName": "Haas", "age": "33"])
        datas.append(["givenName": "Justin", "familyName": "Case", "age": "32"])
        datas.append(["givenName": "Ophelia", "familyName": "Payne", "age": "44"])
        datas.append(["givenName": "Justin", "familyName": "Case", "age": "54"])
        datas.append(["givenName": "Paige", "familyName": "Turner", "age": "55"])
        datas.append(["givenName": "Rick", "familyName": "O'Shea", "age": "65"])
        datas.append(["givenName": "Rick", "familyName": "Shaw", "age": "23"])
        datas.append(["givenName": "Sal", "familyName": "Minella", "age": "11"])
        datas.append(["givenName": "Seth", "familyName": "Poole", "age": "25"])
        datas.append(["givenName": "Russell", "familyName": "Leeves", "age": "33"])
        datas.append(["givenName": "Sonny", "familyName": "Day", "age": "76"])
        datas.append(["givenName": "Stan", "familyName": "Still", "age": "69"])
        datas.append(["givenName": "Stanley", "familyName": "Cupp", "age": "65"])
        datas.append(["givenName": "Sue", "familyName": "Flay", "age": "54"])
        datas.append(["givenName": "Tim", "familyName": "Burr", "age": "51"])
        datas.append(["givenName": "Tommy", "familyName": "Hawk", "age": "27"])
        datas.append(["givenName": "Warren", "familyName": "Peese", "age": "38"])
        datas.append(["givenName": "Sue", "familyName": "Scheph", "age": "41"])
        datas.append(["givenName": "Will", "familyName": "Power", "age": "42"])
        datas.append(["givenName": "Woody", "familyName": "Forrest", "age": "62"])
        datas.append(["givenName": "X.", "familyName": "Benedict", "age": "88"])
        
        // set up sorting
        let ageDescriptor = NSSortDescriptor(key: "age", ascending: true)
        let familyNameDescriptor = NSSortDescriptor(key: "familyName",
                                                    ascending: true,
                                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        let givenNameDescriptor = NSSortDescriptor(key: "givenName",
                                                   ascending: true,
                                                   selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        tableView.tableColumns[0].sortDescriptorPrototype = givenNameDescriptor
        tableView.tableColumns[1].sortDescriptorPrototype = familyNameDescriptor
        tableView.tableColumns[2].sortDescriptorPrototype = ageDescriptor
        
        tableView.reloadData()
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
    
}

extension MainWindowController: NSTableViewDataSource {
    
    func numberOfRows(in aTableView: NSTableView) -> Int {
        return datas.count
    }
    
}

// MARK: - NSTableViewDelegate
extension MainWindowController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let column = tableColumn {
            if let cellView = tableView.makeView(withIdentifier: column.identifier, owner: self) as? NSTableCellView {
                
                let person = datas[row]
                                
                if column.identifier.rawValue == "givenName" {
                    cellView.textField?.stringValue = person["givenName"] as! String
                    return cellView
                }
                if column.identifier.rawValue == "familyName" {
                    cellView.textField?.stringValue = person["familyName"] as! String
                    return cellView
                }
                if column.identifier.rawValue == "age" {
                    cellView.textField?.stringValue = person["age"] as! String
                    return cellView
                }
                
                return cellView
            }
        }
        return nil
    }
    
}
