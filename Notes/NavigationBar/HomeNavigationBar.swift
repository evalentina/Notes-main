//
//  HomeNavigationBar.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation
import UIKit

class HomeNavigationBar {
    
    weak var homeViewController : UIViewController?
    
    init(homeViewController: UIViewController) {
        self.homeViewController = homeViewController
    }
    
    deinit {
        // HomeNavigationBar deinited
    }
    
    open func configurationNavigationBarItems() {
        let moreItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(alertConfiguration))
        moreItem.tintColor = UIColor.systemYellow
        
        let rightBarItem: [UIBarButtonItem] = [moreItem]
        homeViewController?.navigationItem.rightBarButtonItems = rightBarItem
        homeViewController?.navigationItem.rightBarButtonItem?.tintColor = .systemYellow
    }
    
    @objc private func alertConfiguration() {
        let alert = UIAlertController(title: "Notes", message: nil, preferredStyle: .actionSheet)
        let viewAsGallery = UIAlertAction(title: "View as Gallery", style: .default)
        let selectNotes = UIAlertAction(title: "Select Notes", style: .default)
        let attachments = UIAlertAction(title: "View Attachments", style: .default)
        
        alert.addAction(viewAsGallery)
        alert.addAction(selectNotes)
        alert.addAction(attachments)
        homeViewController?.present(alert, animated: true)
    }
}


