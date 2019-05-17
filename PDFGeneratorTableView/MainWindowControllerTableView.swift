//
//  MainWindowControllerTableView.swift
//  PDFGeneratorTableView
//
//  Created by thierry hentic on 17/05/2019.
//  Copyright © 2019 thierryH24. All rights reserved.
//

import AppKit


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
            }
        }
        return nil
    }
    
}
