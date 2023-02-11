//
//  NewNoteDelegate.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation

protocol NewNoteDelegate: AnyObject {
    
    func willSaveNewNote()
    func didClearNewNote()
}
