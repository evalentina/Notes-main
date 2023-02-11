//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
        
    @IBOutlet weak var titleNote: UILabel!
    @IBOutlet weak var contentNote: UILabel!    
    
    var note: Note? {
        
      didSet {
        configureTitleLabel(text: note?.title)
        configureContentLabel(text: note?.content)
      }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureTitleLabel(text: String?) {
      guard let text = text else { return }
      titleNote.text = text
    }
    
    private func configureContentLabel(text: String?) {
      guard let text = text?.trimmingCharacters(in: .whitespaces) else { return }
      contentNote.text = text
    }
}
