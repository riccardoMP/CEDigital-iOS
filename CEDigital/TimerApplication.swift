//
//  TimerApplication.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class TimerApplication: UIApplication {
    
    private var sessionAppSeconds: TimeInterval {
        // 2 minutes for for timer to fire first time
        return 5 * 60 // 5 minutes
        //return 20
    }
    
    private var sessionClosePopUp: TimeInterval {
        // 2 minutes for for timer to fire first time
        return 4.98 * 60 // 5 minutes
        //return 10
    }
    
    private var willExpireSeconds: TimeInterval {
        // 2 minutes for for timer to fire first time
        return 4.5 * 60 // 4 minutes and 30 seconds
        //return 5
    }
    
    
    private var idleTimer: Timer?
    private var idleTimerClosePopUp: Timer?
    private var idleTimerWillExpire: Timer?
    
    // resent the timer because there was user interaction
    private func resetIdleTimer() {
        
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: sessionAppSeconds,
                                         target: self,
                                         selector: #selector(TimerApplication.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
        
    }
    
    private func resetClosePopUpTimer() {
        
        if let idleTimerClosePopUp = idleTimerClosePopUp {
            idleTimerClosePopUp.invalidate()
        }
        
        idleTimerClosePopUp = Timer.scheduledTimer(timeInterval: sessionClosePopUp,
                                         target: self,
                                         selector: #selector(TimerApplication.timeClosePopUp),
                                         userInfo: nil,
                                         repeats: false
        )
        
    }
    
    
    private func resetIdleWillExporeTimer() {
        
        if let idleTimerWillExpire = idleTimerWillExpire {
            idleTimerWillExpire.invalidate()
        }
        
        idleTimerWillExpire = Timer.scheduledTimer(timeInterval: willExpireSeconds,
                                                   target: self,
                                                   selector: #selector(TimerApplication.timeWillExpire),
                                                   userInfo: nil,
                                                   repeats: false
        )
        
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        NotificationCenter.default.post(name: .appTimeout,
                                        object: nil
        )
    }
    
    @objc private func timeWillExpire() {
        NotificationCenter.default.post(name: .appTimeWillExpire,
                                        object: nil
        )
    }
    
    @objc private func timeClosePopUp() {
        NotificationCenter.default.post(name: .appTimeClosePopUp,
                                        object: nil
        )
    }
    /*override func sendEvent(_ event: UIEvent) {
     
     super.sendEvent(event)
     
     if idleTimer != nil {
     self.resetIdleTimer()
     }
     
     if let touches = event.allTouches {
     for touch in touches where touch.phase == UITouch.Phase.began {
     self.resetIdleTimer()
     }
     }
     }*/
    
    func startSession() {
        self.resetIdleTimer()
        self.resetIdleWillExporeTimer()
        self.resetClosePopUpTimer()
    }
    
    func stopTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        if let idleTimerWillExpire = idleTimerWillExpire {
            idleTimerWillExpire.invalidate()
        }
        
        if let idleTimerClosePopUp = idleTimerClosePopUp {
            idleTimerClosePopUp.invalidate()
        }
    }
    
    
}
