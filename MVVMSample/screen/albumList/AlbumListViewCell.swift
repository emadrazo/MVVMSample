import UIKit

class AlbumListViewCell: UITableViewCell {
    
    @IBOutlet weak var albumNameLabel: UILabel!

    static let height: CGFloat = 67.0
    static let cellId = String(describing: AlbumListViewCell.self)

    private var album:Album?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(album:Album) {
        self.album = album
        
        albumNameLabel.text = album.title
        
        applyStyle()
    }
    
    private func applyStyle() {

        albumNameLabel.style(TextStyle.text)
        self.selectionStyle = .none
    }
}
