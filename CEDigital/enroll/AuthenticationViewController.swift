//
//  AuthenticationViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class AuthenticationViewController: GenericViewController, ViewControllerProtocol {
    
    var coordinator: AuthenticationFlow?
    var showDialogLogout:Bool?
    
    
    @IBOutlet weak var contentView: UIView!
    
    private lazy var CEDocumentViewController: AuthDocumentViewController = {
        
        let vc = AuthDocumentViewController.instantiate(storyboard: StoryboardConstants.SB_MAIN)
        vc.coordinator = self.coordinator
        vc.typeDocument = Constants.DOCUMENT_TYPE_CE
        vc.imageDocument = "img_ce"
        
        
        self.add(asChildViewController: vc)
        
        return vc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initializeUI()
        self.setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtils.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtils.lockOrientation(.all)
    }
    
    // MARK: - Method
    
    func initializeUI() {
        self.titleNavigationBar(title: "auth_title".localized)
        
        self.add(asChildViewController: self.CEDocumentViewController)
    }
    
    func setup() {
        if(showDialogLogout ?? false){
            showMsgAlert(title: "general_oops".localized, message: "general_session_logout".localized, dismissAnimated: false)
        }
    }
    
    
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        contentView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.contentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    
    
    
}

