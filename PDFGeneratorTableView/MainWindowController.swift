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
                            "Birds1":   [["Eagle", "Hawk"]],
                            "Fish":    [["Cod", "Mackeral"], ["Salmon", "Tilapia"]]]
        
        var ot = [Others]()
        for (type, things) in creatureDict {
            ot.removeAll()
            for thing in things {
                let data = Others(name: thing[0], things: thing[1])
                ot.append(data)
            }
            let aCreatureList = Creatures(type: type, other: ot)
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
            return creatures.other[index]
        }
        return creatures[index]
    }
    
    
    // Tell the view controller whether an item can be expanded (i.e. it has children) or not
    // (i.e. it doesn't)
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let creatures = item as? Creatures {
            return creatures.other.count >  0
        }
        return false
    }
    
    
    // Tell the view how many children an item has
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil  {
            return creatures.count
        }
        
        if let folder = item as? Creatures {
            return folder.other.count
        }
        return 0
    }
    
    // indicates whether a given row should be drawn in the “group row” style.
    public func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool
    {
        return isSourceGroupItem(item)
    }
    
    func isSourceGroupItem(_ item: Any) -> Bool
    {
        if item is Creatures {
            return true
        }
        return false
    }


}


extension MainWindowController: NSOutlineViewDelegate {
    // Add text to the view. 'item' will either be a Creature object or a string. If it's the former we just
    // use the 'type' attribute otherwise we downcast it to a string and use that instead.
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        var cellView: NSTableCellView?
        var text = ""
        
        if let creatures = item as? Creatures {
            text = creatures.type
            let cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCellHeader"), owner: self) as? KSHeaderCellView
            cellView!.textField!.stringValue = text
            cellView!.fillColor = NSColor.lightGray
            return cellView
            
        }
        else {
            if let item1 = item as? Others {
                
                let identifier = tableColumn!.identifier
                
                if identifier.rawValue == "name"
                {
                    cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "FeedCell"), owner: self) as? NSTableCellView
                    text = (item1.name)
                    
                    cellView!.textField!.stringValue = text                    
                    return cellView

                }
                else
                {
                    cellView = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
                }

                text = item1.things

                cellView!.textField!.stringValue = text
                return cellView

            }
            
        }
        return cellView
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

@objc class Person:NSObject {
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
    
    func convertIntoDict() -> Dictionary<String, String> {
        var dict = Dictionary<String, String>()
        dict["givenName"] = self.givenName
        dict["familyName"] = self.familyName
        dict["age"] = self.age
        return dict
    }
}

final class KSHeaderCellView: NSTableCellView {
    
    var fillColor = NSColor.clear
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let bPath = NSBezierPath(rect: dirtyRect)
        
        fillColor.set()
        bPath.fill()
    }
}




