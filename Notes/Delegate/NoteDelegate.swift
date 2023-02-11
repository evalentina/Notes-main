//
//  NoteDelegate.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation

protocol NotesDelegate: AnyObject {
    
    func didSaveNote(note: Note)
    func didEditNote(noteIndexPath: IndexPath, title: String, content: String)
    
}
