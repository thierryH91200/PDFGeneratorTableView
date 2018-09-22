//
//  PrintFormController.swift
//  PDFGeneratorTableView
//
//  Created by thierryH24 on 16/09/2018.
//  Copyright © 2018 thierryH24. All rights reserved.
//

import Cocoa

class PrintFormController: NSViewController {
    
    @IBOutlet var listView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    var printDataSource = [[String: Any]]()
    
    var topBorderRows = [Int]()
    var bottomBorderRows = [Int]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PrintFormController", bundle: nil)
//        printDataSource.removeAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareContentForPage( pInfo: NSPrintInfo, asList listFlag: Bool) -> Bool {
        
//        printDataSource.removeAll()
        
        let formView = listFlag ? listView : view
        var optSize = pInfo.paperSize
        
        let scale = pInfo.scalingFactor
        
        optSize.height /= scale
        if optSize.height > (formView?.frame.size.height ?? 0.0) {
            optSize.height = (optSize.height) / floor(optSize.height ) - 1
        } else {
            optSize.height = (formView?.frame.size.height ?? 0.0) - 1
        }
        
        formView?.setFrameSize(optSize )
        return true
    }
    

}


extension PrintFormController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return printDataSource.count
    }
}

extension PrintFormController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if let column = tableColumn {
            if let cellView = tableView.makeView(withIdentifier: column.identifier, owner: self) as? NSTableCellView {
                
                let person = printDataSource[row]
                
                if column.identifier.rawValue == "givenName" {
                    let name = person["givenName"] as! String
                    cellView.textField?.stringValue = name
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
                
                return nil
            }
        }
        return nil

        
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 20.0 //printDataSource[row].size().height
    }
}

