import RxSwift
import Alamofire

struct ApiClientConstants {
    static let timeout: TimeInterval = 10
}

public enum ApiError: Error {
    case noInternetConection
    case networkException
    case wrongJSONFormat
    case timeOut
}

fileprivate var afManager:SessionManager?

open class ApiClient: ApiClientType {
    public typealias T = JSONDecodable

    static let shared = ApiClient()
    
    private init() {
        afManager = SessionManager.default
    }
    
    // MARK: - Methods
    
    public func getEntity<T:JSONDecodable>(forResource resource: Resource) -> Observable<T> {
        return request(forResource: resource, method: .get)
            .map { data in
                
                guard let entity: T = decode(data) else {
                    throw ApiError.wrongJSONFormat
                }
                return entity
        }
    }

    public func getEntitiyList<T:JSONDecodable>(forResource resource: Resource) -> Observable<[T]>{
        return request(forResource: resource, method: .get)
            .map { data in
                
                guard let entities: [T] = decode(data) else {
                    throw ApiError.wrongJSONFormat
                }
                
                return entities
        }
    }

    // MARK: - Request
    private func request(forResource resource: Resource, method: HTTPMethod) -> Observable<Data> {
        if !NetworkReachabilityManager()!.isReachable {
            return Observable.error(ApiError.noInternetConection)
        }
        guard let afManager = afManager else {
            return Observable.error(ApiError.networkException)
        }
        
        return Observable.create { observer in

            let request = afManager
                .request(resource.url,
                         method: method,
                         parameters: resource.parameters,
                         encoding: URLEncoding.queryString,
                         headers: HTTPHeaders())
                .validate()
                .responseData(completionHandler: { [weak self] response in
                    guard let strongSelf = self else { fatalError() }

                    strongSelf.printStatus(response, resource: resource)
                    
                    // MARK: - Request Success
                    if response.result.isSuccess, let data = response.result.value {
                        observer.onNext(data)
                        return observer.onCompleted()
                    }
                    
                    // MARK: - Error Handle
                    if response.result.isFailure {
                        strongSelf.printStatus(response, resource: resource)
                        return observer.onError(ApiError.networkException)
                    }
                })
            return Disposables.create(with: {
                request.cancel()
            })
            }

            .timeout(ApiClientConstants.timeout,
                     other: Observable.error(ApiError.timeOut),
                     scheduler: MainScheduler.instance)
    }
}

extension ApiClient {
    fileprivate func printStatus(_ response: DataResponse<Data>, resource: Resource) {
        print("-------------------------------------")
        let status = response.result.isSuccess ? "🎊🎊🎊 REQUEST SUCCESS 👍👍👍" : "💥💥💥 REQUEST WITH ERROR 🕷🕷🕷"
        
        if let request = response.request {
            print("\(status): \(String(describing: response.response?.statusCode)) \(String(describing: request.httpMethod))\n\(request.url?.absoluteString ?? "") ")
            if response.result.isFailure { print (String(describing: response.error.debugDescription)) }
            print("HEADERS: \(String(describing: response.request?.allHTTPHeaderFields))")
            print("PARAMETERS: \(String(describing: resource.parameters))")
        }
        response.result.isSuccess ? print("-------------------------------------") : print()
    }
}


