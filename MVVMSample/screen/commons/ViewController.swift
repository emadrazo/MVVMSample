import UIKit
import RxSwift

class ViewController: UIViewController {
    fileprivate var viewModel: ViewModelType
    let bag = DisposeBag()
    
    var errorView: ErrorView?
    var loadingView: LoadingView?
    
    // MARK: - Init
    init(viewModel: ViewModelType){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("INIT: \(self)")
    }
    
    deinit {
        print("DEINIT: \(self)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        applyStyle()

    }
    
    // MARK: - Rx
    private func setupRx() {
        viewModel.presentLoadingView
            .subscribe(onNext: {[weak self] show in
                guard let strongSelf = self else { return }
                
                if show {
                    strongSelf.presentLoadingView()
                } else {
                    strongSelf.hideLoadingView()
                }
                
            }).disposed(by:bag)
        
        viewModel.screenNameObservable
            .subscribe(onNext:{ [weak self] screenName in
                guard let strongSelf = self else { return }
                
                strongSelf.title = screenName
            })
            .disposed(by:bag)
        
        viewModel.presentErrorView
            .subscribe(onNext:{ [weak self] show in
                guard let strongSelf = self else { return }
                
                if show {
                    strongSelf.presentErrorView()
                } else {
                    strongSelf.hideErrorView()
                }
                
            }).disposed(by:bag)
    }
    
    func applyStyle(){
        self.navigationController?.navigationBar.style(.title)
    }
}

// MARK: - ViewController+Loading

extension ViewController {
    func presentLoadingView() {
        hideLoadingView()
        
        let frame = UIApplication.shared.keyWindow?.frame ?? self.view.frame
        let loadingView = LoadingView.instance(frame: frame)
        
        loadingView.isHidden = false
        self.loadingView = loadingView
        
        self.view.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        guard let loadingView = loadingView else { return }
        loadingView.removeFromSuperview()
        loadingView.isHidden = true
    }
}

extension ViewController {
    func presentErrorView() {
        hideErrorView()

        let frame = self.view.frame
        let errorView = ErrorView.instance(frame: frame, viewModel: self.viewModel)

        errorView.isHidden = false
        self.errorView = errorView
        
        self.view.addSubview(errorView)
    }

    func hideErrorView() {
        guard let errorView = errorView else { return }
        errorView.removeFromSuperview()
        errorView.isHidden = true
    }
}

// MARK: - ViewController+RefreshControl

extension ViewController {
    func addRefreshControl(toView view: UIScrollView) {
        let control = UIRefreshControl()
        
        if view is UITableView || view is UICollectionView {
            control.addTarget(self, action: #selector(ViewController.refreshData(sender:)), for: .valueChanged)
            control.tintColor = UIColor.greenAlphaWoom
            
            if #available(iOS 10.0, *) {
                view.refreshControl = control
            } else {
                view.addSubview(control)
            }
            
            viewModel.didLoad
                .subscribe(onNext: { didLoad in
                    control.endRefreshing()
                })
                .disposed(by:bag)
            
        } else {
            print("Unable to add refresh control to class diferent that UITableView or UICollectionView")
        }
    }
    
    @objc private func refreshData(sender: UIRefreshControl) {
        viewModel.refreshData()
    }
}
