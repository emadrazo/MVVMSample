import UIKit

typealias AlbumListRouterType = RouterType & AlbumPhotosNavigable

class AlbumListRouter: Router, AlbumPhotosNavigable {

    override func start() {

        let viewModel = container.resolve(AlbumListViewModel.self, argument: self as AlbumListRouterType)!
        let viewController = AlbumListViewController(viewModel: viewModel)

        openPush(viewController)
    }
    
    func navigateToPhotos(forAlbum album: Album) {
        AlbumPhotosRouter(navigationController: self.navigationController, album:album).start()
    }
}
