//
//  Note.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation

class Note: Codable, Identifiable {
    
    var title: String
    var content: String
    var id = UUID()
    var pinn: Bool = false
    
    init(title: String, content: String) {
        
        self.title = title
        self.content = content
    }
}
