import Foundation

public typealias ParametersDictionary = [String : Any]

public struct Resource {
    public var url: URL
    public var parameters: ParametersDictionary?
    
    public init(url: URL, parameters: ParametersDictionary?) {
        self.url = url
        self.parameters = parameters
    }
}
