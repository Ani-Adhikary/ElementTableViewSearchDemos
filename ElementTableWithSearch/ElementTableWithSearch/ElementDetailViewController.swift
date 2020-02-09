//
//  ElementDetailViewController.swift
//  ElementTableViewSegue
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    @IBOutlet weak var elementNameLabel: UILabel!    
    @IBOutlet weak var elementSymbolLabel: UILabel!
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        if let elementVal = element {
            elementNameLabel.text = elementVal.elementName
            elementSymbolLabel.text = elementVal.elementSymbol
            navigationItem.title = elementVal.elementName
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
