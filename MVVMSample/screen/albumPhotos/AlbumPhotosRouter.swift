import UIKit

typealias AlbumPhotosRouterType = RouterType & ExternalURLNavigable

class AlbumPhotosRouter: Router, ExternalURLNavigable {

    let album:Album
    
    init(navigationController: UINavigationController?, album:Album) {
        self.album = album
        super.init(navigationController: navigationController)  
    }
    
    override func start() {

        let viewModel = container.resolve(AlbumPhotosViewModel.self, arguments: self as AlbumPhotosRouterType, album)!

        let viewController = AlbumPhotosViewController(viewModel: viewModel)

        openPush(viewController)
    }
    
    func navigateToURL(_ url: URL) {
        url.openInApp()
    }
}
