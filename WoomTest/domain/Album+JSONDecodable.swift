extension Album:JSONDecodable{
    init(dictionary: JSONDictionary) throws {
        guard let identifier = dictionary["id"] as? Int else{
            throw JSONError.MandatoryFieldNotFound
        }
        
        guard let userId = dictionary["userId"] as? Int else{
            throw JSONError.MandatoryFieldNotFound
        }
        
        self.identifier = identifier
        self.userId = userId
        self.title = dictionary["title"] as? String ?? ""
    }
}
