//
//  Notes.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation

class Notes: Codable {
    
    var notes: [Note]
    
    var pinnedNotes : [Note] {
        return notes.filter( {$0.pinn })
    }
    var notPinnedNotes: [Note] {
        return notes.filter { !$0.pinn }
    }
    
    init() {
        self.notes = UserDefaults.standard.load(key: Keys.userDefaultsKey, obj: Notes.self)?.notes ?? [Note]()
    }
    
    init(notes: [Note]) {
      self.notes = notes
    }

    
    public func saveNotesToLocal() {
        UserDefaults.standard.save(key: Keys.userDefaultsKey, obj: self)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copiedNotes = Notes(notes: notes)
        return copiedNotes
        
    }
    
    public func updateNote(_ filteredNotes: inout [Note], _ isFiltering: Bool, noteIndex: Int, title: String, content: String) {
        let filteredNoteToEdit: Note = filteredNotes[noteIndex]
        filteredNoteToEdit.title = title
        filteredNoteToEdit.content = content
        saveNotesToLocal()
    }
    
    public func insertNewNote(_ filteredNotes: inout [Note], _ isFiltering: Bool, note: Note) {
        
      notes.insert(note, at: pinnedNotes.count == 0 ? 0 : pinnedNotes.count)
      if !isFiltering {
        filteredNotes = notes
      } else {
        filteredNotes.insert(note, at: 0)
      }
      saveNotesToLocal()
    }
    
    public func deleteNote(_ filteredNotes: inout [Note], _ isFiltering: Bool, noteIndex: Int) {
        let noteToDelete: Note = filteredNotes[noteIndex]
        notes.removeAll(where: { $0.id == noteToDelete.id })
        if !isFiltering {
            filteredNotes = notes
            
        } else {
            filteredNotes.removeAll(where: { $0.id == noteToDelete.id })
            
        }
        saveNotesToLocal()
    }

    public func pinNote(_ filteredNotes: inout [Note], noteIndex: Int) {
        let noteToPin: Note = notes[noteIndex]
        noteToPin.pinn = true
        notes.remove(at: noteIndex)
        notes.insert(noteToPin, at: 0)
        filteredNotes = notes
        saveNotesToLocal()
        
    }
    public func unPinNote(_ filteredNotes: inout [Note], noteIndex: Int) {
        guard let noteToUnPin: Note = notes.first(where: { $0.id == notes[noteIndex].id }) else { return }
        noteToUnPin.pinn = false
        notes.remove(at: noteIndex)
        notes.insert(noteToUnPin, at: pinnedNotes.count == 0 ? 0 : pinnedNotes.count)
        filteredNotes = notes
        saveNotesToLocal()
        
    }
}




