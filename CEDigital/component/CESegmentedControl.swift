//
//  CESegmentedControl.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/31/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

protocol CESegmentedControlDelegate:AnyObject {
    func changeToIndex(index:Int)
}

class CESegmentedControl: UIView {
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor:UIColor = #colorLiteral(red: 0.231372549, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    var selectorViewColor: UIColor = #colorLiteral(red: 0.6078431373, green: 0.8, blue: 0.4705882353, alpha: 1)
    var selectorTextColor: UIColor = #colorLiteral(red: 0.6078431373, green: 0.8, blue: 0.4705882353, alpha: 1)
    
    weak var delegate:CESegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.changeToIndex(index: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                
                btn.titleLabel?.font = UIFont.init(name: UIParameters.TTF_BOLD, size: 18 * AppUtils.getSizeFactor())
                btn.setTitleColor(selectorTextColor, for: .normal)
            }else{
                btn.titleLabel?.font = UIFont.init(name: UIParameters.TTF_REGULAR, size: 18 * AppUtils.getSizeFactor())
                btn.setTitleColor(textColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension CESegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
    }
    
    private func configSelectorView() {
        let viewHorizontal = UIView(frame: CGRect(x: 0, y: self.frame.height - 1.5, width: frame.width, height: 2))
        viewHorizontal.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        addSubview(viewHorizontal)
        
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 1.5, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CESegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.init(name: UIParameters.TTF_REGULAR, size: 18 * AppUtils.getSizeFactor())
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = UIFont.init(name: UIParameters.TTF_BOLD, size: 18 * AppUtils.getSizeFactor())
    }
    
    
}

