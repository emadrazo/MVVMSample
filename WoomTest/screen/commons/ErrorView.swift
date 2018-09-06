import UIKit
import Foundation
import RxSwift

class ErrorView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    
    var viewModel: ErrorViewModelType?
    let bag = DisposeBag()
    
    //MARK: - Init
    class func instance(frame: CGRect, viewModel:ErrorViewModelType) ->  ErrorView {
        let view: ErrorView = UINib(nibName: String(describing: ErrorView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ErrorView
        view.viewModel = viewModel
        view.frame = frame
        
        view.configure()
        return view
    }
    
    private func configure() {
        setupViews()
        setupRx()
    }
    
    //MARK: - Setup
    private func setupViews() {
        errorDescriptionLabel.style(TextStyle.text)
    }
    
    private func setupRx() {
        viewModel?.buttonText.bind(to: retryButton.rx.title()).disposed(by: bag)
        viewModel?.descriptionText.bind(to: errorDescriptionLabel.rx.text).disposed(by: bag)
        
        retryButton.rx.controlEvent(.touchUpInside)
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext:{ [weak self] event in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel?.buttonTaped()
            }).disposed(by:bag)
    }
    
}
