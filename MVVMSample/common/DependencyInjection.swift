import Swinject

final class DependencyInjection {
    let container: Container
    
    static let shared = DependencyInjection()
    
    private init() {
        container = Container()
        setup()
    }
    
    private func setup() {
        //MARK: - APIClient
        container.register( ApiClient.self ) { _ in
            ApiClient.shared
        }
        
        //MARK: - Services
        container.register( AlbumService.self ) { r in
            AlbumService(apiClient: r.resolve(ApiClient.self)!)
        }
        
        //MARK: - ViewModels
        container.register( AlbumListViewModel.self ) { r, router in
            AlbumListViewModel(router: router as AlbumListRouterType,
                          service: r.resolve( AlbumService.self)! )
        }
        
        container.register( AlbumPhotosViewModel.self ) { r, router, album in
            AlbumPhotosViewModel(router: router as AlbumPhotosRouterType,
                                 service: r.resolve( AlbumService.self)!,
                                 album: album  )
        }
    }
}
