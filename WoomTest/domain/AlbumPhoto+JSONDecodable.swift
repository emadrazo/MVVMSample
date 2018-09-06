extension AlbumPhoto:JSONDecodable{
        init(dictionary: JSONDictionary) throws {
            guard let identifier = dictionary["id"] as? Int else{
                throw JSONError.MandatoryFieldNotFound
            }
            
            guard let albumId = dictionary["albumId"] as? Int else{
                throw JSONError.MandatoryFieldNotFound
            }
            
            self.identifier = identifier
            self.albumId = albumId
            self.title = dictionary["title"] as? String ?? ""
            self.url = dictionary["url"] as? String ?? ""
            self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        }
}
