import UIKit
import Foundation

class LoadingView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadingTitle: UILabel!
    
    //MARK: - Init
    class func instance(frame: CGRect) ->  LoadingView {
        let view: LoadingView = UINib(nibName: String(describing: LoadingView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
        
        view.frame = frame
        view.configure()
        return view
    }
    
    private func configure() {
        setupViews()
    }
    
    //MARK: - Setup
    private func setupViews() {
        loadingTitle.style(TextStyle.title)
    }
    
}
