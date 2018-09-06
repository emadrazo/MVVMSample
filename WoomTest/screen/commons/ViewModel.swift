import RxSwift

protocol ViewModelType: ErrorViewModelType {
    var screenNameObservable: Observable<String> {get}
    
    var didLoad: Observable<Error?> { get }
    var presentLoadingView: Observable<Bool> { get }
    var presentErrorView: Observable<Bool> { get }
    
    /// Request first page data with loadingView
    func reload()
    func requestData()
    func refreshData()
}

class ViewModel: ViewModelType {

    // MARK: - LyfeCycle properties
    var setDidLoad: PublishSubject<Error?> = PublishSubject()
    lazy var didLoad: Observable<Error?> = self.setDidLoad.asObservable()
    
    // MARK: - Present Views properties
    lazy var screenNameObservable: Observable<String> = self.screenNameVariable.asObservable()
    var screenNameVariable: Variable<String> = Variable("")
    lazy var presentLoadingView: Observable<Bool> = self.presentLoadingViewVariable.asObservable()
    var presentLoadingViewVariable: Variable<Bool> = Variable(false)
    lazy var presentErrorView: Observable<Bool> = self.presentErrorViewVariable.asObservable()
    var presentErrorViewVariable: Variable<Bool> = Variable(false)
    
    var errorDescriptionViewVariable: Variable<String> = Variable("")
    
    // MARK: - Private
    fileprivate let router: RouterType
    fileprivate let bag = DisposeBag()

    init(router: RouterType) {
        self.router = router
        setupCommonRx()
    }
    
    deinit {
        print("DEINIT: \(self)")
    }
    
    // MARK: - Request Data
    func reload() {
        presentLoadingViewVariable.value = true
        requestData()
    }
    
    func refreshData() {
        requestData()
    }
    
    func requestData() {
        
    }
    
    func setupCommonRx() {

        didLoad
            .subscribe(onNext:{ [weak self] error in
                guard let strongSelf = self else { return }
                
                strongSelf.presentLoadingViewVariable.value = false
                if let error = error {
                    strongSelf.manageError(error)
                } else {
                    strongSelf.presentErrorViewVariable.value = false
                }
            })
            .disposed(by:bag)
 
    }

    // MARK: - Errors
    func manageError(_ error: Error) {
        switch error {

       // Internet Errors
        case ApiError.noInternetConection:
            presentErrorViewVariable.value = true
            errorDescriptionViewVariable.value = "noInternetConection".localized
        case ApiError.networkException:
            presentErrorViewVariable.value = true
            errorDescriptionViewVariable.value = "noInternetConection".localized
        case ApiError.timeOut:
            presentErrorViewVariable.value = true
            errorDescriptionViewVariable.value = "noInternetConection".localized
            
        default:
            break
        }
    }
}



extension ViewModel: ErrorViewModelType {
    var descriptionText: Observable<String> {
        return errorDescriptionViewVariable.asObservable()
    }
    
    var buttonText: Observable<String> {
        return Observable.of("retry".localized)
    }
    
    func buttonTaped() {
        self.reload()
    }
    
}
