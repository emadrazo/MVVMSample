import RxSwift

protocol AlbumPhotosViewModelType: ViewModelType {

    // var xxxObservable: Observable<type> {get}

}

class AlbumPhotosViewModel: ViewModel,  AlbumPhotosViewModelType {

    // MARK: - Input
    //private var xxxVariable: Variable<type> = Variable()
    
    // MARK: - Output
    //lazy var xxxObservable: Observable<type> = self.xxxVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: AlbumPhotosRouterType

    // MARK: - Init
    
    override init(router: AlbumPhotosRouterType) {

        self.router = router
        super.init(router: router)
    }
    
    // MARK: - Setup
    
    override func requestData() {
        super.requestData()
    }
}


