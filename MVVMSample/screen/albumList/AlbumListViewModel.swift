import RxSwift

protocol AlbumListViewModelType: ViewModelType {

    var albumsObservable: Observable<[Album]> {get}
    func didSelectCell(indexPath: IndexPath)
}

class AlbumListViewModel: ViewModel, AlbumListViewModelType {

    // MARK: - Input
    private var albumsVariable: Variable<[Album]> = Variable([])
    
    // MARK: - Output
    lazy var albumsObservable: Observable<[Album]> = self.albumsVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: AlbumListRouterType
    private let service: AlbumServiceType

    // MARK: - Init
    init(router: AlbumListRouterType, service:AlbumServiceType) {
        self.router = router
        self.service = service
        super.init(router: router)
        
        self.screenNameVariable.value = "AlbumsTitle".localized
    }
    
    // MARK: - Setup
    override func requestData() {
        super.requestData()
        
        service.getAlbums()
            .subscribe(onNext: { [weak self] albums in
                guard let strongSelf = self else  { return }
                strongSelf.albumsVariable.value = albums
                strongSelf.setDidLoad.onNext(nil)
                },
                       onError: {[weak self] error in
                        guard let strongSelf = self else  { return }
                        strongSelf.setDidLoad.onNext(error)
            })
            .disposed(by:self.bag)
    }
    
    func didSelectCell(indexPath: IndexPath) {
        let album = albumsVariable.value[indexPath.row]
        router.navigateToPhotos(forAlbum: album)
    }
}
