//
//  Constant.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation


struct Keys {
    static let userDefaultsKey = "Key"
    static let noteCellKey = "NoteCell"
}


enum NoteSceneType {
  case isCreatingNewNote
  case isEditingNote
}

enum HomeConstants {
  static let goToNewNoteVCSegueId: String = "goToNewNoteVC"
  static let goToEditNoteSegueId: String = "goToEditNoteVC"
}
