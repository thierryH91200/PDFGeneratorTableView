//
//  MainWindowController.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 02/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import AppKit
import Quartz
//import PDFKit


class MainWindowController: NSWindowController {
    
    let defaultRowHeight  = CGFloat(23.0)
    let defaultColumnWidth = CGFloat(150.0)
    let numberOfRowsPerPage = 60
    
    let topMargin = CGFloat(40.0)
    let leftMargin = CGFloat(20.0)
    let rightMargin = CGFloat(20.0)
    let bottomMargin = CGFloat (40.0)
    let textInset = CGFloat(5.0)
    let verticalPadding = CGFloat (10.0)
    
    var myPDFViewObject = PDFView()
    var aPDFDocument = PDFDocument()

    
    
    @IBOutlet weak var pdfThumbnailView: PDFThumbnailView!
    
    @IBOutlet weak var tabView: NSTabView!
    
    @IBOutlet weak var tableViewBinding: NSTableView!
    @IBOutlet var tableView: NSTableView!
    @IBOutlet weak var outlineView: NSOutlineView!
    
    @IBOutlet weak var infoLabel: NSTextField!
    
    @IBOutlet var arrayController: NSArrayController!
    
    @IBOutlet var mainWindow: NSWindow!
    @IBOutlet weak var view: NSView!
    
    var data = [Person]()
    
    var creatures = [Creatures]()
    
    
    /// the data for the table
    @objc var datas = [[String: Any]]()
    var columnInformation = [[String: Any]]()
    
    override var windowNibName: NSNib.Name? {
        return  "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        data = dataArray()
        
        for dat in data {
            let d = dat.convertIntoDict()
            datas.append(d)
        }
        
        let creatureDict = ["Animals": [["Cat", "12"],["Dog","22"], ["Horse", "33"]],
                            "Birds":   [["Eagle", "Hawk"]],
                            "Birds1":   [["Eagle1", "Hawk"], ["Eagle11", "Hawk"]],
                            "Birds2":   [["Eagle2", "Hawk"], ["Eagle21", "Hawk"]],
                            "Birds3":   [["Eagle3", "Hawk"], ["Eagle31", "Hawk"]],
                            "Birds4":   [["Eagle4", "Hawk"], ["Eagle41", "Hawk"]],
                            "Birds5":   [["Eagle5", "Hawk"], ["Eagle51", "Hawk"]],
                            "Birds6":   [["Eagle6", "Hawk"], ["Eagle61", "Hawk"]],
                            "Birds7":   [["Eagle7", "Hawk"], ["Eagle71", "Hawk"]],
                            "Birds8":   [["Eagle8", "Hawk"], ["Eagle81", "Hawk"]],
                            "Fish":    [["Cod", "Mackeral"], ["Salmon", "Tilapia"]]]
        
        var other = [Others]()
        for (type, things) in creatureDict {
            other.removeAll()
            for thing in things {
                let data = Others(name: thing[0], things: thing[1])
                other.append(data)
            }
            let aCreatureList = Creatures(type: type, other: other)
            creatures.append(aCreatureList)
        }
        
        outlineView.dataSource = self
        outlineView.delegate = self
        outlineView.expandItem(nil, expandChildren: true)
        
        
        // set up sorting
        let ageDescriptor = NSSortDescriptor(key: "age", ascending: true)
        let familyNameDescriptor = NSSortDescriptor(key: "familyName",
                                                    ascending: true,
                                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        let givenNameDescriptor = NSSortDescriptor(key: "givenName",
                                                   ascending: true,
                                                   selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        tableView.sortDescriptors = [givenNameDescriptor, familyNameDescriptor, ageDescriptor]
//        tableView.tableColumns[1].sortDescriptorPrototype = familyNameDescriptor
//        tableView.tableColumns[2].sortDescriptorPrototype = ageDescriptor

        
        tableView.reloadData()
        tableViewBinding.reloadData()
    }
    
    @objc func dataArray()->[Person]{
        var arr = [Person]()
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))
        arr.append(Person.createPerson(fName: "Debasis", lName: "Das", age: "27"))
        arr.append(Person.createPerson(fName: "Woody", lName: "Forrest", age: "27"))
        arr.append(Person.createPerson(fName: "Will", lName: "Power", age: "27"))
        arr.append(Person.createPerson(fName: "Sue", lName: "Scheph", age: "27"))
        arr.append(Person.createPerson(fName: "Warren", lName: "Peese", age: "27"))
        arr.append(Person.createPerson(fName: "Tommy", lName: "Hawk", age: "27"))
        arr.append(Person.createPerson(fName: "John", lName: "ccdd", age: "28"))
        arr.append(Person.createPerson(fName: "Jane", lName: "eeff", age: "55"))

        return arr
    }
    
    @IBAction func printAction(_ sender: Any) {
        
        var headerLine = ""
        var myPrintView = NSView()
        
        let printOpts: [NSPrintInfo.AttributeKey: Any] = [.headerAndFooter: true, .orientation : 1]
        let printInfo = NSPrintInfo(dictionary: printOpts)
        
        printInfo.leftMargin = 20
        printInfo.rightMargin = 20
        printInfo.topMargin = 40
        printInfo.bottomMargin = 20
        
        printInfo.horizontalPagination = .fit
        printInfo.verticalPagination = .automatic
        
        printInfo.scalingFactor = 1.0
        printInfo.paperSize = NSMakeSize(595, 842)
        
        let select = tabView.selectedTabViewItem
        let label = select?.label
        switch label {
        case "Table":
            headerLine = "My printed Table View"
            myPrintView = MyPrintViewTable(tableView: tableView, andHeader: headerLine)
        case "Outline":
            headerLine = "My printed Outline View"
            myPrintView = MyPrintViewOutline(tableView: outlineView, andHeader: headerLine)
        case "Table Binding":
            headerLine = "My printed Table Binding View"
            myPrintView = MyPrintViewTable(tableView: tableViewBinding, andHeader: headerLine)
            
        default:
            headerLine = "My printed Table View"
            myPrintView = MyPrintViewTable(tableView: tableView, andHeader: headerLine)
        }
        
        let printOperation = NSPrintOperation(view: myPrintView, printInfo: printInfo)
        printOperation.printPanel.options.insert(NSPrintPanel.Options.showsPaperSize)
        printOperation.printPanel.options.insert(NSPrintPanel.Options.showsOrientation)
        
        printOperation.run()
        printOperation.cleanUp()
    }
    
    @IBAction func pagesteup(_ sender: Any) {
        let printInfo = NSPrintInfo.shared
        let pageLayout = NSPageLayout()
        pageLayout.beginSheet(with: printInfo, modalFor: window!, delegate: mainWindow, didEnd: #selector(self.pageLayoutDidEnd(pageLayout:returnCode:contextInfo:)), contextInfo: nil)
        
    }    
    
    @objc func pageLayoutDidEnd( pageLayout: NSPageLayout?, returnCode: Int, contextInfo: UnsafeMutableRawPointer?) {
        if returnCode == Int(Float(NSApplication.ModalResponse.OK.rawValue)) {
        }
    }
}

final class KSHeaderCellView: NSTableCellView {
    
    var fillColor = NSColor.lightGray
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let bPath = NSBezierPath(rect: dirtyRect)
        
        fillColor.set()
        bPath.fill()
    }
}




