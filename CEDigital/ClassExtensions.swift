//
//  ClassExtensions.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import UIKit
import SwiftyRSA


extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension String {
    
    func colorSpecificText(_ stringToColor: String, color: UIColor) -> NSAttributedString{
        
        let range = (self as NSString).range(of: stringToColor)
        
        let attribute = NSMutableAttributedString.init(string: self)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        
        return attribute
        
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var containsValidCharacter: Bool {
        guard self != "" else { return true }
        let hexSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz0123456789 ")
        let newSet = CharacterSet(charactersIn: self)
        return hexSet.isSuperset(of: newSet)
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
        
    }
    
    func hexaDecoededString() -> String {
        
        var newData = Data()
        var emojiStr: String = ""
        for char in self {
            
            let str = String(char)
            
            if str == "\\" || (str.lowercased() == "x" && emojiStr.hasPrefix("\\")) {
                emojiStr.append(str)
                
            }
            else if emojiStr.hasPrefix("\\x") || emojiStr.hasPrefix("\\X") {
                emojiStr.append(str)
                if emojiStr.count == 4 {
                    /// It can be a hexa value
                    let value = emojiStr.replacingOccurrences(of: "\\x", with: "")
                    
                    if let byte = UInt8(value, radix: 16) {
                        newData.append(byte)
                    }
                    else {
                        newData.append(emojiStr.data(using: .utf8)!)
                    }
                    /// Reset emojiStr
                    emojiStr = ""
                }
            }
            else {
                /// Append the data as it is
                newData.append(str.data(using: .utf8)!)
            }
        }
        
        let decodedString = String(data: newData, encoding: String.Encoding.utf8)
        return decodedString ?? ""
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
    
    func isExpresionValid(expression : String)->Bool {
        let emailRegex = expression
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func maskingText(expression: String) -> String {
        if let regex = try? NSRegularExpression(pattern: expression, options: .caseInsensitive) {
            
            return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length:  self.count), withTemplate: "*")
        }else{
            return ""
        }
    }
    
    
    func decrypt()->String {
        
        do {
            
            let myPrivateKey = RSAKeyManager.shared.getMyPrivateKey()
            let encrypted = try EncryptedMessage(base64Encoded: self)
            let clear = try encrypted.decrypted(with: myPrivateKey!, padding: .PKCS1)
            
            return try clear.string(encoding: .utf8)
            
            
        } catch _ {
            
            return ""
        }
        
        
    }
    
    
}



extension CEFloatingPlaceholderTextField {
    
    func emptyValidate(message: String)->Bool {
        
        if (self.textInput.text!.isEmpty) {
            self.setError(message)
            
            return false
        }else{
            self.setError("")
        }
        
        return true
    }
    
    func errorTextField(expression : String, message: String)->Bool {
        
        if (!self.textInput.text!.isExpresionValid(expression: expression)) {
            self.setError(message)
            
            return false
        }else{
            self.setError("")
        }
        
        return true
    }
    
    
}


extension UIColor {
    
    /**
     Convierte un valor hexadecimal a su color en UIColor
     
     :param: contexto, es la instancia actual de UIViewControllerManager que lo extendio
     :return: UIColor
     */
    class func getColorWithHex(colorHex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        
        if #available(iOS 13.0, *) {
            var rgb: UInt64 = 0;
            let scanner = Scanner(string: colorHex)
            
            if colorHex.hasPrefix("#") {
                // skip '#' character
                scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
            }
            scanner.scanHexInt64(&rgb)
            
            let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
            let b = CGFloat(rgb & 0xFF) / 255.0
            
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }else{
            var rgb: CUnsignedInt = 0;
            let scanner = Scanner(string: colorHex)
            
            
            if colorHex.hasPrefix("#") {
                // skip '#' character
                scanner.scanLocation = 1
            }
            scanner.scanHexInt32(&rgb)
            
            let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
            let b = CGFloat(rgb & 0xFF) / 255.0
            
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        
        
        
    }
    
    class func getColorWithRGB(rgbRed: CGFloat, rgbGreen: CGFloat, rgbBlue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: rgbRed, green: rgbRed, blue: rgbRed, alpha: alpha)
    }
    
    
}

extension UIPageControl {
    
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.borderColor = dotFillColor.cgColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
    
}



extension UIView {
    
    
    
    func blurBackground(style: UIBlurEffect.Style, fallbackColor: UIColor) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = UIParameters.COLOR_VACATION_BLACK_04
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(blurEffectView, at: 0)
            
            blurEffectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            blurEffectView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            blurEffectView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
            blurEffectView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
            
            
        } else {
            self.backgroundColor = fallbackColor
        }
    }
    
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    
}

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
    
    
}

extension UIFont {
    
    /**
     Will return the best font conforming to the descriptor which will fit in the provided bounds.
     */
    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
        let constrainingDimension = min(bounds.width, bounds.height)
        let properBounds = CGRect(origin: .zero, size: bounds.size)
        var attributes = additionalAttributes ?? [:]
        
        let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
        var bestFontSize: CGFloat = constrainingDimension
        
        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
            attributes[.font] = newFont
            
            let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
            
            if properBounds.contains(currentFrame) {
                bestFontSize = fontSize
                break
            }
        }
        return bestFontSize
    }
    
    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
        return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}

extension UILabel {
    
    func setMargins(margin: CGFloat = 8) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = self.lineBreakMode
        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UINavigationController {
    func backgroundBar (){
        
        self.navigationBar.barTintColor = UIParameters.COLOR_ICON_NAV_BAR
        self.navigationBar.tintColor = UIParameters.COLOR_ICON_NAV_BAR
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIParameters.COLOR_WHITE]
        
        
        
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(AppPreferences.init().prefHeightCell!)).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named : "img_logo")
        //imageView.backgroundColor = .lightGray
        
        // In order to center the title view image no matter what buttons there are, do not set the
        // image view as title view, because it doesn't work. If there is only one button, the image
        // will not be aligned. Instead, a content view is set as title view, then the image view is
        // added as child of the content view. Finally, using constraints the image view is aligned
        // inside its parent.
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    // Global Alert
    // Define Your number of buttons, styles and completion
    public func showGenericAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
}


extension UIImageView {
    
    func tintColorUIImageView( nameImage:String, color:UIColor){
        
        
        let origImage = UIImage(named: nameImage);
        let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        self.image = tintedImage
        self.tintColor = color
    }
    
    
  
    func setColorImage(color: UIColor, nameImage:String){
        
        let origImage = UIImage(named: nameImage);
        let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        self.image = tintedImage
        self.tintColor = color
        
    }
    
}




extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    func resized(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
        let widthRatio  = width / size.width
        let heightRatio = height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension Date
{
    func toString( dateFormat format  : String = Constants.DATE_FORMAT_DATE ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)! + 1
    }
    
    static func getDate(dateString:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DATE_FORMAT_DATE
        
        if let date = dateFormatter.date(from: dateString){
            return date
        }else{
            return Date()
        }
    }
    
    static func addDaysToDate(daysAdd:Int, dateString:String) -> Date{
        let date = Date.getDate(dateString: dateString)
        if let dateDaysAdded = Calendar.current.date(byAdding: .day, value: daysAdd, to: date){
            return dateDaysAdded
        }else{
            return Date()
        }
    }
    
    static func addMonthsToDate(monthsAdd:Int, date:Date) -> Date{
        if let dateMonthsAdded = Calendar.current.date(byAdding: .month, value: monthsAdd, to: date){
            return dateMonthsAdded
        }else{
            return Date()
        }
    }
    
    static func addYearsToDate(yearsAdd:Int, date:Date) -> Date{
        if let dateMonthsAdded = Calendar.current.date(byAdding: .year, value: yearsAdd, to: date){
            return dateMonthsAdded
        }else{
            return Date()
        }
    }
    
    static func isDayWeekValid(date:Date) -> Bool{
        let dayWeek = Calendar.current.component(.weekday, from: date)
        if 2..<7 ~= dayWeek{
            return true
        }else{
            return false
        }
    }
    static func weekDayString(date:Date) -> String{
        let dayWeek = Calendar.current.component(.weekday, from: date)
        
        switch dayWeek {
        case 1:
            return "Domingo"
        case 2:
            return "Lunes"
        case 3:
            return "Martes"
        case 4:
            return "Miércoles"
        case 5:
            return "Jueves"
        case 6:
            return "Viernes"
        case 7:
            return "Sábado"
        default:
            return "Fecha no Disponible"
        }
        
        
    }
    
    func isSmaller(to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedAscending ? true : false
    }
    
    func isEqual(to: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: to)
    }
    
    
    
}


extension Result where Success == Data {
    func decode<T: Decodable>(with decoder: JSONDecoder = .init()) -> Result<T, Error> {
        do {
            let data = try get()
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
}

extension DateFormatter
{
    
    func nameMonthById( indexMonth month  : Int ) -> String
    {
        self.locale = Locale.init(identifier: "es_PE")
        
        return self.monthSymbols[month].capitalized
    }
}
extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}


extension UIApplication {
    
    /// The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    static func topTabBarController(base: UIViewController? = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topTabBarController(base: nav.visibleViewController)
        }
        if (base as? UITabBarController) != nil {
            return base
        }
        
        return base
    }
}

extension Array where Element: Hashable {
    
    /// Remove duplicates from the array, preserving the items order
    func filterDuplicates() -> Array<Element> {
        var set = Set<Element>()
        var filteredArray = Array<Element>()
        for item in self {
            if set.insert(item).inserted {
                filteredArray.append(item)
            }
        }
        return filteredArray
    }
}

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}


extension URLRequest /*: CustomStringConvertible*/{
    public var description: String{
        get{
            return "HEADERS \n \(String(describing: allHTTPHeaderFields))"
        }
    }
}



extension Bundle {
    
    var versionCode: String? {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    var versionNumber: Int? {
        let version = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
        return Int(version ?? "0")
    }
    
}




extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}


extension Encodable {
    var convertToString: String {
        let jsonEncoder = JSONEncoder()
        if #available(iOS 13.0, *) {
            jsonEncoder.outputFormatting = .withoutEscapingSlashes
        } else {
            //jsonEncoder.outputFormatting = .
        }
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}

extension Notification.Name {
    
    static let appTimeout = Notification.Name("appTimeout")
    static let appTimeWillExpire = Notification.Name("appTimeWillExpire")
    static let appTimeClosePopUp = Notification.Name("appTimeClosePopUp")
    static let actionImage = Notification.Name("actionImage")
    
}

