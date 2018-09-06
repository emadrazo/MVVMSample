import UIKit

typealias AlbumListRouterType = RouterType

class AlbumListRouter: Router {

    override func start() {

        let viewModel = AlbumListViewModel(router:self)
        let viewController = AlbumListViewController(viewModel: viewModel)

        openPush(viewController)
    }
}
