import UIKit

class AlbumPhotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumPhotoNameLabel: UILabel!
    @IBOutlet weak var albumPhotoImage: UIImageView!
    
    static let height: CGFloat = 67.0
    static let cellId = String(describing: AlbumPhotoViewCell.self)
    
    private var albumPhoto:AlbumPhoto?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(albumPhoto:AlbumPhoto) {
        self.albumPhoto = albumPhoto
        
        albumPhotoNameLabel.text = albumPhoto.title
        albumPhotoImage.setImageFailable(withUrlString: albumPhoto.url)
        applyStyle()
    }
    
    private func applyStyle() {
        albumPhotoNameLabel.style(TextStyle.text)
    }
}
