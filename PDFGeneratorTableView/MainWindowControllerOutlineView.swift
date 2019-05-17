//
//  MainWindowControllerOutlineView.swift
//  PDFGeneratorTableView
//
//  Created by thierry hentic on 17/05/2019.
//  Copyright © 2019 thierryH24. All rights reserved.
//

import AppKit


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
            cellView!.fillColor = NSColor.clear
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
                    text = item1.things
                    cellView!.textField!.stringValue = text
                    return cellView
                }
            }
        }
        return nil
    }
}
