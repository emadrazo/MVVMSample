import UIKit
import RxSwift
import Swinject

protocol RouterType {
    func start()
}

class Router: RouterType {
    
    let container = DependencyInjection.shared.container
    
    weak var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("DEINIT: \(self)")
    }
    
    func start() {
        fatalError("not implemented")
    }
    
    func navigateToParent() {
        if (navigationController?.presentedViewController != nil) {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Push, Modal and Replace root view controller
    func openModal(_ viewController: UIViewController) -> UINavigationController  {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.navigationController?.present(navVC, animated: true, completion: nil)
        }
        
        return navVC
    }
    
    func openPush(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
