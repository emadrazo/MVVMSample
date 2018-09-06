import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.backgroundColor = UIColor.backgroundColor
            
            let nav=UINavigationController()
            AlbumListRouter(navigationController: nav).start()
            
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
