import UIKit
import RxSwift
import RxCocoa

class AlbumListViewController: ViewController {
    
    // MARK: - Outlets
    
    
    // MARK: - Private
    private let viewModel: AlbumListViewModelType
    
    // MARK: - Init
    
    init(viewModel: AlbumListViewModelType) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit AlbumListViewController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        setupViews()
        applyStyle()
        viewModel.reload()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        
    }
    
    private func applyStyle() {
        
    }
    
    private func setupRx() {
        
    }
}

