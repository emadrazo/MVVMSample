import Foundation
public typealias JSONDictionary = [String: Any]

public protocol JSONDecodable {
    init(dictionary: JSONDictionary) throws
    
}

public enum JSONError: Error {
    case MandatoryFieldNotFound
}





public func decode<T: JSONDecodable>(_ dictionary: JSONDictionary) -> T? {
    do {
        let object = try T(dictionary: dictionary)
        return object
    } catch {
        print("Error decoding: \(error)")
    }
    return nil
}

public func decode<T: JSONDecodable>(_ dictionaries: [JSONDictionary]) -> [T]? {
    return dictionaries.compactMap(decode)
}

public func decode<T: JSONDecodable>(_ data: Data) -> T? {
    guard
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let jsonDictionary = jsonObject as? JSONDictionary,
        let object: T = decode(jsonDictionary) else {
            return nil
    }
    
    return object
}

public func decode<T: JSONDecodable>(_ data: Data) -> [T]? {
    guard
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let jsonDictionary = jsonObject as? [JSONDictionary],
        let object: [T] = decode(jsonDictionary) else {
            return nil
    }
    return object
}
