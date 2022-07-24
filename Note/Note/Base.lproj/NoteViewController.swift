//
//  NoteViewController.swift
//  Note
//
//  Created by Константин Малков on 27.05.2022.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!
    
    public var noteTitle: String = " "
    public var note: String = " "
    
    public var editCompletion: ((String,String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note
        noteLabel.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTextView))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func editTextView() {
        if let text = titleLabel.text, !text.isEmpty, !noteLabel.text.isEmpty {
            editCompletion?(text, noteLabel.text)
            
        } else {
            let alert = UIAlertController(title: "Empty fields!", message: "Enter text in textfields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Another one", style: .default))
            present(alert, animated: true)
        }
        
    }
}
    


