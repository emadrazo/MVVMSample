import RxSwift

protocol AlbumListViewModelType: ViewModelType {

    // var xxxObservable: Observable<type> {get}

}

class AlbumListViewModel: ViewModel,  AlbumListViewModelType {

    // MARK: - Input
    //private var xxxVariable: Variable<type> = Variable()
    
    // MARK: - Output
    //lazy var xxxObservable: Observable<type> = self.xxxVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: AlbumListRouterType

    // MARK: - Init
    
    override init(router: AlbumListRouterType) {

        self.router = router
        super.init(router: router)
    }
    
    // MARK: - Setup
    
    override func requestData() {
        super.requestData()
    }
}


