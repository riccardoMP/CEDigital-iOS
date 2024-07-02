//
//  LoadingIndicatorView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class LoadingIndicatorView {
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    static var currentLabel : UILabel?
    static var currentLoadingText: String?
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindowInConnectedScenes else {
            print("No main window.")
            return
        }
        show(currentMainWindow)
    }
    
    static func show(_ loadingText: String, showBackground:Bool = true) {
        guard let currentMainWindow = UIApplication.shared.keyWindowInConnectedScenes else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText, showBackground)
    }
    
    
    static func updateTextLoadingView(loadingText: String) {
        self.currentLabel!.text = loadingText
        
    }
    static func show(_ overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static func show(_ overlayTarget : UIView, loadingText: String?,_ showBackground:Bool = true) {
        // Clear it first in case it was already shown
        hide()
        
        if(showBackground){
            //UIApplication.shared.statusBarView?.backgroundColor = UIParameters.COLOR_BLACK_0
        }
        
        
        // Create the overlay
        let overlay = UIView()
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        // Create and animate the activity indicator
        var indicator : UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .medium)
        } else {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        }
        
        indicator.color = UIColor.white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.font = UIFont(name: UIParameters.TTF_BOLD, size: 18 * AppUtils.getSizeFactor())
            overlay.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 16).isActive = true
            label.centerXAnchor.constraint(equalTo: indicator.centerXAnchor).isActive = true
            
            currentLabel = label
        }
        
        
        // Animate the overlay to show
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        }, completion: nil)
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText
    }
    
    static func showViewIndicator(_ overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        
        // Create the overlay
        let overlay = UIView()
        overlay.backgroundColor = UIParameters.COLOR_WHITE
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        // Create and animate the activity indicator
        var indicator : UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        }
        indicator.color = UIParameters.COLOR_GREEN_INDICATOR
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        //indicator.heightAnchor.constraint(equalToConstant: CGFloat(AppPreferences.init().prefHeightCell!) ).isActive = true
        //indicator.widthAnchor.constraint(equalToConstant: CGFloat(AppPreferences.init().prefHeightCell!) ).isActive = true
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIParameters.COLOR_SEPARATOR
            label.font = UIFont(name: UIParameters.TTF_BOLD, size: 18 * AppUtils.getSizeFactor())
            overlay.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 8).isActive = true
            label.centerXAnchor.constraint(equalTo: indicator.centerXAnchor).isActive = true
            
            currentLabel = label
        }
        
        // Animate the overlay to show
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat,.autoreverse], animations: {
            //overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        }, completion: nil)
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText
        
    }
    
    static func hide() {
        if currentOverlay != nil {
            //UIApplication.shared.statusBarView?.backgroundColor = UIParameters.COLOR_ICON_NAV_BAR
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentLoadingText = nil
            currentLabel = nil
            currentOverlayTarget = nil
        }
    }
}
