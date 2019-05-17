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
    
    let aPDFDocument = PDFDocument()
    
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
                            "Birds1":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds2":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds3":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds4":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds5":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds6":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds7":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
                            "Birds8":   [["Eagle", "Hawk"], ["Eagle", "Hawk"]],
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
        return arr
    }
    
    @IBAction func printAction(_ sender: Any) {
        
        var headerLine = ""
        var myPrintView = NSView()
        
        let printOpts: [NSPrintInfo.AttributeKey: Any] =
            [NSPrintInfo.AttributeKey.headerAndFooter: true,
             NSPrintInfo.AttributeKey.orientation : 1]
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




class Others {
    var name = ""
    var things = ""
    
    init(name: String, things: String) {
        self.name = name
        self.things = things
    }
    
}

class Creatures {
    var type: String
    var other: [Others]
    
    init(type: String, other: [Others]) {
        self.type = type
        self.other = other
    }
}

@objcMembers class Person:NSObject {
    var givenName  = ""
    var familyName = ""
    var age        = ""
    
    class func createPerson(fName: String, lName: String, age: String)->Person {
        let person        = Person()
        person.givenName  = fName
        person.familyName = lName
        person.age        = age
        return person
        
    }
    
    func convertIntoDict() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        dict["givenName"] = self.givenName
        dict["familyName"] = self.familyName
        dict["age"] = self.age
        return dict
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




