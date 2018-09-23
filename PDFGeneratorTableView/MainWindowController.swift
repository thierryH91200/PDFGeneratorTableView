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
    
    @IBOutlet weak var infoLabel: NSTextField!
    
    @IBOutlet var arrayController: NSArrayController!
    
    @IBOutlet var mainWindow: NSWindow!
    @IBOutlet weak var view: NSView!
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
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
        
        let creatureDict = ["Animals": ["Cat", "Dog", "Horse"],
                            "Birds":   ["Eagle", "Hawk"],
                            "Fish":    ["Cod", "Mackeral", "Salmon", "Tilapia"]]
        
        for (type, things) in creatureDict {
            let aCreatureList = Creatures(type: type, things: things)
            creatures.append(aCreatureList)
        }
        
        outlineView.dataSource = self
        outlineView.delegate = self

        
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
            myPrintView = MyPrintViewTable(tableView: tableView, andHeader: headerLine)
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

extension MainWindowController: NSTableViewDataSource {
    
    func numberOfRows(in aTableView: NSTableView) -> Int {
        return data.count
    }
    
}

// MARK: - NSTableViewDelegate
extension MainWindowController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let column = tableColumn {
            if let cellView = tableView.makeView(withIdentifier: column.identifier, owner: self) as? NSTableCellView {
                
                let person = data[row]
                
                if column.identifier.rawValue == "givenName" {
                    cellView.textField?.stringValue = person.givenName
                    cellView.textField?.textColor = NSColor.blue
                    return cellView
                }
                if column.identifier.rawValue == "familyName" {
                    cellView.textField?.stringValue = person.familyName
                    cellView.textField?.textColor = NSColor.red
                    return cellView
                }
                if column.identifier.rawValue == "age" {
                    cellView.textField?.stringValue = person.age
                    cellView.textField?.textColor = NSColor.black
                    return cellView
                }
                
                return cellView
            }
        }
        return nil
    }
    
}

extension MainWindowController: NSOutlineViewDataSource {
    // Find and return the child of an item. If item == nil, we need to return a child of the
    // root node otherwise we find and return the child of the parent node indicated by 'item'
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let creatures = item as? Creatures {
            return creatures.things[index]
        }
        return creatures[index]
    }
    
    
    // Tell the view controller whether an item can be expanded (i.e. it has children) or not
    // (i.e. it doesn't)
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let creatures = item as? Creatures {
            return creatures.things.count >  0
        }
        return false
    }
    
    
    // Tell the view how many children an item has
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let creatures = item as? Creatures {
            return creatures.things.count
        }
        return creatures.count
    }
}


extension MainWindowController: NSOutlineViewDelegate {
    // Add text to the view. 'item' will either be a Creature object or a string. If it's the former we just
    // use the 'type' attribute otherwise we downcast it to a string and use that instead.
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        var text = ""
        if let creatures = item as? Creatures {
            text = creatures.type
        }
        else {
            text = item as! String
        }
        
        // Create our table cell -- note the reference to 'creatureCell' that we set when configuring the table cell
        let tableCell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "creatureCell"), owner: self) as! NSTableCellView
        tableCell.textField!.stringValue = text
        return tableCell
    }
}

class Creatures {
    var type: String
    var things: [String]
    
    init(type: String, things: [String]) {
        self.type = type
        self.things = things
    }
}


@objc class Person:NSObject{
    @objc var givenName  = ""
    @objc var familyName = ""
    @objc var age        = ""
    
    class func createPerson(fName:String, lName:String, age: String)->Person{
        let person        = Person()
        person.givenName  = fName
        person.familyName = lName
        person.age        = age
        return person
        
    }
}

