import Foundation

//MARK: - Localize
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
