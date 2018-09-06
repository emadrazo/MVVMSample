import UIKit
import RxSwift
import RxCocoa

class AlbumListViewController: ViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var albumsTableView: UITableView! {
        didSet {
            albumsTableView.register(UINib.init(nibName: AlbumListViewCell.cellId, bundle: nil),
                                         forCellReuseIdentifier: AlbumListViewCell.cellId)
            albumsTableView.rowHeight = UITableViewAutomaticDimension
            albumsTableView.estimatedRowHeight = AlbumListViewCell.height
            albumsTableView.backgroundColor = UIColor.backgroundColor
            
            self.addRefreshControl(toView: albumsTableView)
        }
    }
    
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
    
    private func setupRx() {
        viewModel.albumsObservable
            .bind(to: albumsTableView.rx.items) { tableView, row, element in

                let indexPath = IndexPath(item: row, section: 0)
                let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
 
                if let cell = tableView.dequeueReusableCell(withIdentifier: AlbumListViewCell.cellId,
                                                            for: indexPath) as? AlbumListViewCell {
                    cell.configure(album: element)
                    return cell
                }
                
                return defaultCell
            }
            .disposed(by:bag)
        
        albumsTableView.rx.itemSelected
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.didSelectCell(indexPath: indexPath)
            }).disposed(by:bag)
    }
}

