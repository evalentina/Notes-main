//
//  Search.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation
import UIKit

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      filteredNotes = [Note]()
      tableSectionsAmount = 1

      DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
        if searchText == "" {
          self.filteredNotes = notes.notes
          self.isFiltering = false
          if self.notes.pinnedNotes.count > 0 {
            self.tableSectionsAmount = 2
          }
        } else {
          self.isFiltering = true
          self.notes.notes.forEach { note in
            if note.title.lowercased().contains(searchText.lowercased()) || note.content.lowercased().contains(searchText.lowercased()) {
              self.filteredNotes.append(note)
            }
          }
        }
        DispatchQueue.main.async {
          self.tableViewNotes.reloadData()
        }
      }
    }
    func configureGestures() {
      let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchBarDismissKeyboardTouchOutside))
      gestureRecognizer.cancelsTouchesInView = false
      view.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func searchBarDismissKeyboardTouchOutside() {
      searchNote.endEditing(true)
    }
  }


