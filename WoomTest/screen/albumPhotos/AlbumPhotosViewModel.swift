import RxSwift

protocol AlbumPhotosViewModelType: ViewModelType {
    var albumPhotosObservable: Observable<[AlbumPhoto]> {get}
    var albumNameObservable: Observable<String> {get}
    func didSelectCell(indexPath: IndexPath)
}

class AlbumPhotosViewModel: ViewModel,  AlbumPhotosViewModelType {

    // MARK: - Input
    private var albumPhotosVariable: Variable<[AlbumPhoto]> = Variable([])
    private var albumNameVariable: Variable<String> = Variable("")
    
    // MARK: - Output
    lazy var albumPhotosObservable: Observable<[AlbumPhoto]> = self.albumPhotosVariable.asObservable()
    lazy var albumNameObservable: Observable<String> = self.albumNameVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: AlbumPhotosRouterType
    private let service:AlbumServiceType
    private let album:Album

    // MARK: - Init
    init(router: AlbumPhotosRouterType, service:AlbumServiceType, album:Album) {
        self.router = router
        self.service = service
        self.album = album
        super.init(router: router)
        
        self.albumNameVariable.value = album.title
        self.screenNameVariable.value = "AlbumPhotosTitle".localized
    }
    
    // MARK: - Setup
    override func requestData() {
        super.requestData()
        
        service.getPhotos(forAlbum: album)
            .subscribe(onNext: { [weak self] photos in
                guard let strongSelf = self else  { return }
                strongSelf.albumPhotosVariable.value = photos
                strongSelf.setDidLoad.onNext(nil)
                },
                       onError: {[weak self] error in
                        guard let strongSelf = self else  { return }
                        strongSelf.setDidLoad.onNext(error)
            })
            .disposed(by:self.bag)
    }
    
    func didSelectCell(indexPath: IndexPath){
        let albumPhoto = albumPhotosVariable.value[indexPath.row]
        if let url = URL(string: albumPhoto.url){
            router.navigateToURL(url)
        }
    }
}


