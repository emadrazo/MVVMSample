import UIKit

protocol Stylable {
    associatedtype Style
    func style(_ style: Style)
}

public struct TextStyle {
    let font: UIFont
    let foregroundColor: UIColor
    let backgroundColor: UIColor
    
    //MARK: - Init
    private init(font: UIFont,
                 foregroundColor: UIColor = UIColor.blackWoom,
                 backgroundColor: UIColor = UIColor.clear) {
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    //MARK: - Styles
    public static var title: TextStyle {
        return TextStyle(font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
                         foregroundColor: UIColor.greenAlphaWoom)
    }
    
    public static var text: TextStyle {
        return TextStyle(font: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
    }
}
