import UIKit
import RxSwift
import RxCocoa

class AlbumPhotosViewController: ViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var albumPhotosCollectionView: UICollectionView!  {
        didSet {
            albumPhotosCollectionView.register(UINib.init(nibName: AlbumPhotoViewCell.cellId, bundle: nil), forCellWithReuseIdentifier: AlbumPhotoViewCell.cellId)
        }
    }
    
    // MARK: - Private
    private let viewModel: AlbumPhotosViewModelType
    
    // MARK: - Init
    
    init(viewModel: AlbumPhotosViewModelType) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit AlbumPhotosViewController")
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let padding:CGFloat = 24.0
        let side = albumPhotosCollectionView.frame.width/2 - padding
        layout.itemSize = CGSize(width: side, height: side)
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 0, 16)
        albumPhotosCollectionView.collectionViewLayout = layout
    }
    
    private func setupViews() {
        
    }
    
    override func applyStyle() {
        super.applyStyle()
        titleLabel.style(TextStyle.title)
    }
    
    private func setupRx() {
        viewModel.albumNameObservable.bind(to: titleLabel.rx.text).disposed(by: bag)
        
        viewModel.albumPhotosObservable
            .bind(to: albumPhotosCollectionView.rx
                .items(cellIdentifier: AlbumPhotoViewCell.cellId,
                       cellType: UICollectionViewCell.self)) { row , item, cell in
                        guard let cell = cell as? AlbumPhotoViewCell else { return }
    
                        cell.configure(albumPhoto: item)
            }
            .disposed(by:bag)
        
        albumPhotosCollectionView.rx.itemSelected
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.didSelectCell(indexPath: indexPath)
                
            }).disposed(by:bag)
        
    }
}

