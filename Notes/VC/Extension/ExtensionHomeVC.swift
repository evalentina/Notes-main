//
//  ExtensionHome.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.noteCellKey, for: indexPath) as! NoteTableViewCell
        let globalIndex: Int = getIndexForSection(in: indexPath)
        let note = filteredNotes[globalIndex]
        cell.note = note
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionsAmount
    }
    
    func getIndexForSection(in indexPath: IndexPath) -> Int {
        
        var sumRowsBySection: Int = 0
        for section in 0 ..< indexPath.section {
            sumRowsBySection += tableViewNotes.numberOfRows(inSection: section)
        }
        return sumRowsBySection + indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard tableView.numberOfSections > 1 else { return filteredNotes.count }
        var rowsInSection: Int {
            if tableView.numberOfSections == 2, section == 0 {
                return notes.pinnedNotes.count
            }
            return notes.notPinnedNotes.count
        }
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard tableView.numberOfSections == 2 else {
            return ""
        }
        return section == 0 ? "Pinned" : "Notes"
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] action, view, completionHandler in
            let globalIndex: Int = self.getIndexForSection(in: indexPath)
            self.notes.deleteNote(&self.filteredNotes, self.isFiltering, noteIndex: globalIndex)
            self.tableViewNotes.deleteRows(at: [indexPath], with: .left)
            if self.tableViewNotes.numberOfSections == 2, self.notes.pinnedNotes.count == 0 {
                self.tableSectionsAmount = 1
                self.tableViewNotes.deleteSections(IndexSet(arrayLiteral: 0), with: .left)
            }
            self.configureToolBar(notes: self.notes)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.image?.withTintColor(UIColor.yellow)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = true
        return swipeConfiguration
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let pinAction = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            if tableView.numberOfSections < 2 {
              self.tableSectionsAmount = 2
              tableView.insertSections(IndexSet(arrayLiteral: 0), with: .left)
            }
            let globalIndex: Int = self.getIndexForSection(in: indexPath)
            var pinnedIndexPath = IndexPath(row: 0, section: 0)
            var notPinnedIndexPath = indexPath
            
            if self.notes.pinnedNotes.count == 0 {
              notPinnedIndexPath = IndexPath(row: indexPath.row, section: 1)
            }
            
            if tableView.numberOfSections == 2, notPinnedIndexPath.section == 0 {
              pinnedIndexPath = indexPath
              notPinnedIndexPath = IndexPath(row: 0, section: 1)
              self.notes.unPinNote(&self.filteredNotes, noteIndex: globalIndex)
              tableView.moveRow(at: pinnedIndexPath, to: notPinnedIndexPath)
            } else {
              self.notes.pinNote(&self.filteredNotes, noteIndex: globalIndex)
              tableView.moveRow(at: notPinnedIndexPath, to: pinnedIndexPath)
            }

            if tableView.numberOfSections == 2, self.notes.pinnedNotes.count == 0 {
              self.tableSectionsAmount = 1
              tableView.deleteSections(IndexSet(arrayLiteral: 0), with: .left)
            }
        }
        pinAction.image = UIImage(systemName: "pin.fill")
        pinAction.backgroundColor = .systemOrange
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [pinAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        return swipeConfiguration
    }
}


