import UIKit

extension UILabel: Stylable {
    func style(_ style: TextStyle) {
        self.backgroundColor = style.backgroundColor
        self.textColor = style.foregroundColor
        self.font = style.font
    }
}
