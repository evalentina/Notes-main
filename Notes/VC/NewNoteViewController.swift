//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var note : Note?
    var newNoteNavigationBar : NewNoteNavigationBar?
    var noteSceneType: NoteSceneType = .isCreatingNewNote
    weak var notesDelegate: NotesDelegate?
    var noteIndexPath = IndexPath(row: 0, section: 0)
    var notes: Notes? 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configurationNavigationBar()
        configureNoteWhileEditing()
        newNoteNavigationBar?.newNoteDelegate = self
        configureNoteIfEditing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        noteTitleField.becomeFirstResponder()
    }
    
    private func configureNoteIfEditing() {
        
        guard let note = self.note else { return }
        noteTitleField.text = note.title
        noteTextView.text = note.content
    }
    
    private func configurationNavigationBar() {
        
        newNoteNavigationBar = NewNoteNavigationBar(newNoteViewController: self)
        newNoteNavigationBar?.configurationNavigationItems()
    }
    
    private func configureNoteWhileEditing() {
        
        guard let note = self.note else { return }
        noteTitleField.text = note.title
        noteTextView.text = note.content
    }
}



