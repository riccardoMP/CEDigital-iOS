//
//  DigitalPassViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class DigitalPassViewController: GenericViewController, ViewControllerProtocol {
    
    
    var coordinator: DigitalPassFlow?
    var userLogin: UserLogin?
    
    var behaviorButton: AppUtils.EnumStateDocument = .STATE_FORWARD
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var butSeeReverse: UIButton!
    @IBOutlet weak var vDisclaimer: DisclaimerView!
    

    
    
    // MARK: - CE ContentView
    private lazy var ceForwardViewController: CEForwardViewController = {
        
        
        let viewController = CEForwardViewController.instantiate(storyboard: StoryboardConstants.SB_DIGITAL_CARD)
        viewController.userLogin = self.userLogin
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var ceBehindViewController: CEBehindViewController = {
        
        
        let viewController = CEBehindViewController.instantiate(storyboard: StoryboardConstants.SB_DIGITAL_CARD)
        viewController.userLogin = self.userLogin
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    // MARK: - PTP ContentView
    private lazy var ptpForwardViewController: PTPForwardViewController = {
        
        
        let viewController = PTPForwardViewController.instantiate(storyboard: StoryboardConstants.SB_DIGITAL_CARD)
        viewController.userLogin = self.userLogin
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var ptpBehindViewController: PTPBehindViewController = {
        
        
        let viewController = PTPBehindViewController.instantiate(storyboard: StoryboardConstants.SB_DIGITAL_CARD)
        viewController.userLogin = self.userLogin
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
    }
    
    // MARK: - Method
    
    func initializeUI() {
        
        self.titleNavigationBar(title: AppPreferences.shared.parametryCEObject.nameDocument)
        
        self.changeContentView()
        
        butSeeReverse = ButtonFluentBuilder.init(button: butSeeReverse)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("dp_see_reverse".localized)
            .build()
        
        
    }
    
    func setup() {
        if let arrayDisclaimer : [String] = userLogin?.mensajeAdvertencia?.getArrayDisclaimer() {
            
            if(arrayDisclaimer.isEmpty) {
                vDisclaimer.removeFromSuperview()
            }else{
                vDisclaimer.initializeUI(arrayDisclaimer: arrayDisclaimer )
            }
            
        } else {
            vDisclaimer.removeFromSuperview()
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
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    
    
    
    func changeContentView(){
        if(AppPreferences.init().parametryCEObject.idDocumento  == Constants.DOCUMENT_TYPE_CE){
            switch self.behaviorButton {
            case .STATE_FORWARD:
                
                remove(asChildViewController: ceBehindViewController)
                add(asChildViewController: ceForwardViewController)
                
            case .STATE_BEHIND:
                
                remove(asChildViewController: ceForwardViewController)
                add(asChildViewController: ceBehindViewController)
                
            }
        }else{
            switch self.behaviorButton {
            case .STATE_FORWARD:
                
                
                remove(asChildViewController: ptpBehindViewController)
                add(asChildViewController: ptpForwardViewController)
            case .STATE_BEHIND:
                
                remove(asChildViewController: ptpForwardViewController)
                add(asChildViewController: ptpBehindViewController)
                
            }
        }
        
        
    }
    
    
    
    
    // MARK: - Action
    
    @IBAction func onChangeState(_ sender: Any) {
        
        switch self.behaviorButton {
        case .STATE_FORWARD:
            
            self.behaviorButton = .STATE_BEHIND
            
            butSeeReverse = ButtonFluentBuilder.init(button: butSeeReverse)
                .setText("dp_see_behind".localized)
                .build()
            
            
            
        case .STATE_BEHIND:
            
            self.behaviorButton = .STATE_FORWARD
            
            butSeeReverse = ButtonFluentBuilder.init(button: butSeeReverse)
                .setText("dp_see_reverse".localized)
                .build()
        }
        
        self.changeContentView()
        
    }
    
    @IBAction func onGoToWeb(_ sender: Any) {
        AppUtils.openURL(url: self.userLogin!.sURL)
    }
    
}

