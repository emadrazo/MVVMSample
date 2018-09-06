import UIKit

extension UINavigationBar: Stylable {
    func style(_ style: TextStyle) {
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: style.foregroundColor,
            NSAttributedStringKey.font: style.font
        ]
        
        self.titleTextAttributes = attrs
        self.backgroundColor = style.backgroundColor
    }
}
