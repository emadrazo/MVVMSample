import UIKit

typealias AlbumPhotosRouterType = RouterType

class AlbumPhotosRouter: Router {

    override func start() {

        let viewModel = AlbumPhotosViewModel(router:self)
        let viewController = AlbumPhotosViewController(viewModel: viewModel)

        openPush(viewController)
    }
}
