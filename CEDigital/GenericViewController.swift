//
//  GenericViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import Alamofire
import QuickLook

class GenericViewController: UIViewController, Storyboarded, SessionProtocol {
    
    
    
    lazy var  previewDocument = NSURL()
    private let viewModel = BaseViewModel()
    
    var delegate : LogoutProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.addLogoToNavigationBarItem()
        backButtonClean()
        
        
        self.setupBaseViewModel()
    }
    
    
    func updateUI<T>(object : T){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    
    
    func hideNavigationBar(){
        self.navigationController?.isNavigationBarHidden = true
        //UIApplication.shared.statusBarView?.backgroundColor = UIParameters.COLOR_ICON_NAV_BAR
    }
    
    func showNavigationBar(){
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    func titleNavigationBar(title : String ){
        
        
        let label = LabelFluentBuilder.init(label: UILabel())
            .setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setBackground(.clear)
            .setText(title)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        label.numberOfLines = 2
        label.textAlignment = .center
        
        self.navigationItem.titleView = label
    }
    func showNavigationBar(title:String = "", hideBlackLine:Bool = false){
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title = title
        //self.navigationController?.navigationBar.topItem?.title = " " //Hide BackButton Text
        
        //Ocultar barra negra debajo del navigation bar
        if(hideBlackLine){
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        
        //UIApplication.shared.statusBarView?.backgroundColor = UIParameters.COLOR_ICON_NAV_BAR
        
    }
    
    // MARK: - Navigation bar Button
    func removeRighBarButtons(){
        self.navigationItem.rightBarButtonItems = []
    }
    
    

    
    // MARK: - Session
    
    private func setupBaseViewModel(){
        
        viewModel.refreshTokenObserver.bind {  device in
            guard device != nil else { return }
            
            (TimerApplication.shared as! TimerApplication).startSession()

        }
        
        
        viewModel.isViewLoading.bind { isViewLoading in
            guard isViewLoading != nil else { return }
            
            
            if(isViewLoading!){
                LoadingIndicatorView.show("general_loading".localized)
            }else{
                LoadingIndicatorView.hide()
            }
            
        }
    }
    
    
    func onSessionWillExpire() {
        
        self.showGenericAlert(title: "general_oops".localized,
                              message: "general_session_will_expire".localized,
                              alertStyle: .alert,
                              actionTitles: ["general_yes".localized, "general_no".localized],
                              actionStyles: [.default, .cancel],
                              actions: [
                                {_ in
                                    self.viewModel.doRefreshToken()
                                },
                                { [self]_ in
                                    
                                    (TimerApplication.shared as! TimerApplication).stopTimer()
                                    ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
                                        .cleanParametry()
                                        .build()
                                    delegate?.onLogout()
                                    
                                }
                              ])
    }
    
    func onSessionLogout() {
        
        
        (TimerApplication.shared as! TimerApplication).stopTimer()
        ParametryCEFluentBuilder(builder: AppPreferences.init().parametryCEObject)
            .cleanParametry()
            .build()
        delegate?.onLogout()
    }
    
    // MARK: - Navigation
    
    
    
    func backButtonClean(){
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
        self.tabBarController?.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem //Used for VC in Tabs
    }
    
    
    func showMsgAlert(title:String, message:String, dismissAnimated:Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "general_ok".localized, style: UIAlertAction.Style.default)
        {
            (action: UIAlertAction!) -> Void in
            alert.dismiss(animated: dismissAnimated, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

    
    // MARK: - WebService
    
    func doDownloadFile(url : String, showLoader : Bool = true) {
        
        if (showLoader){
            LoadingIndicatorView.show("general_loading".localized)
        }
        
        APIClient.downloadFile(url : url) { result in
            
            LoadingIndicatorView.hide()
            
            switch result {
            case .success(let response):
                
                
                self.previewDocument = response
                
                let previewController = QLPreviewController()
                previewController.dataSource = self
                
                
                self.present(previewController, animated: true, completion: nil)
                
            case .failure(let error):
                
                print(error)
                self.showMsgAlert(title: error.title, message: error.body, dismissAnimated: true)
            }
        }
        
    }
    
    
    
}


// MARK: GenericViewControllerProtocol



extension GenericViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        return self.previewDocument as QLPreviewItem
    }
}
