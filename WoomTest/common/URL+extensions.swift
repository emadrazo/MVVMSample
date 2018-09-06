import UIKit

extension URL {
    func openInApp() {
        if UIApplication.shared.canOpenURL(self) {
            UIApplication.shared.open(self)
        }
    }
}
