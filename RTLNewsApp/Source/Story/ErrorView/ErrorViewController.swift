//
//  ErrorViewController.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet private weak var errorTitle: UILabel!
    @IBOutlet private weak var errorDescription: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    var action: (() -> Void)? {
        didSet {
            actionButton.isHidden = action == nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.setTitle("ERROR_VIEW_BUTTON_TITLE".localized, for: .normal)
        actionButton.isHidden = action == nil
    }
    
    func setError(withTitle title: String?, andMessage message: String?) {
        errorTitle.text = title
        errorDescription.text = message
    }
    
    @IBAction private func didTapActionButton(_ sender: UIButton) {
        action?()
    }

}
