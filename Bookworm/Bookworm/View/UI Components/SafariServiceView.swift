//
//  SafariServiceView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/11/23.
//

import SafariServices
import SwiftUI

struct SafariServiceView: UIViewControllerRepresentable {
    let seachText: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariServiceView>) -> SFSafariViewController {
        let urlString = URL(string: "https://en.wikipedia.org/wiki/\(seachText)")
        let controller = SFSafariViewController(url: urlString!)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariServiceView>) {
        
    }
}
