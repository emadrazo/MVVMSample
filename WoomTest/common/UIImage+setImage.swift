import AlamofireImage

fileprivate var transitionTime = 0.2

extension UIImageView {
    
    func setImage(withURL url: URL, completion: ((UIImage?)->Void)? = nil) {
        af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(transitionTime),
            runImageTransitionIfCached: false,
            completion: { completion?($0.result.value) })
    }
    
    func setImageFailable(withUrlString urlString: String?) {
        guard let urlString = urlString else {
            return
        }
        guard let url = URL(string: urlString) else {
            setErrorImage()
            return
        }
        
        af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(transitionTime),
            runImageTransitionIfCached: false,
            completion: { dataResponse in
                if dataResponse.result.isFailure {
                    let error = dataResponse.error as? AFIError
                    if error == nil || AFIError.requestCancelled != error {
                        self.setErrorImage()
                    }
                }
        })
    }
    
    func cancelRequest() {
        af_cancelImageRequest()
    }
    
    private func setErrorImage() {
        image = #imageLiteral(resourceName: "logo")
    }
}
