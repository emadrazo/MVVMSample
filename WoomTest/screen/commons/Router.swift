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
    
    // MARK: - Navigate to
    
    func navigateToRoot() {
        if (navigationController?.presentedViewController != nil) {
            navigationController?.dismiss(animated: true, completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            navigationController?.popToRootViewController(animated: false)
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func navigateToResetTab(_ tabBarComponent: TabBarComponent) {
        navigateToTab(tabBarComponent)
        resetTab(tabBarComponent)
    }
    
    func navigateToTab(_ tabBarComponent: TabBarComponent) {
        if let presentedVC = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            presentedVC.dismiss(animated: true, completion: nil)
        }
        if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = tabBarComponent.rawValue
        }
    }
    //MARK: - LoginNavigable
    
    func navigateToLogin() -> Observable<ResultType> {
        let router = LoginRouter(navigationController: self.navigationController)
        router.start()
        return router.result
    }
    
    //MARK: - ScanNavigable
    
    func navigateToScanner() {
        ProductScannerRouter(navigationController: self.navigationController).start()
    }
    
    //MARK: - SearchNavigable
    
    func navigateToSearch() {
        _ = SearchRouter(navigationController: self.navigationController).start()
    }
    
    //MARK: - ProfileNavigable
    
    func navigateToProfile() {
        _ = MyDataRouter(navigationController: self.navigationController).start()
    }
    
    //MARK: - CategoryDetailNavigable
    
    func navigateToCategoryDetail(_ element: CategoryBaseEntity) {
        //TODO: - nos deberian informar si tenemos que presentar LastProductsViewedView en las siguienes escenas
        switch element.lastLevel {
        case true:
            switch element.isOutletFlash {
            case true:
                OutletFlashRouter(navigationController: self.navigationController, element: element).start()
            case false:
                ProductListRouter(navigationController: self.navigationController, element: element).start()
            }
        case false:
            CategoryDetailRouter(navigationController: self.navigationController, element: element).start()
        }
    }
    
    //MARK: - ProductDetailNavigable
    
    func navigateToProductDetail(_ product: ProductBaseEntityType) {
        if product.isSerie == true {
            ProductSerieRouter(navigationController: self.navigationController, product: product).start()
        } else {
            ProductDetailRouter(navigationController: self.navigationController, product: product).start()
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
    
    func openReplaceRoot(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: false)
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
    
    // MARK: - Reset
    
    func resetAllTabs() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let mainRouter = appDelegate.mainRouter {
            mainRouter.recreateAllTabs()
        }
    }
    
    // MARK: - Utils
    
    func resetTab(_ tabBarComponent: TabBarComponent) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let mainRouter = appDelegate.mainRouter {
            mainRouter.recreateTab(tabBarComponent)
        }
    }
    
}
