import RxSwift

protocol ErrorViewModelType {
    var descriptionText: Observable<String> { get }
    var buttonText: Observable<String> { get }
    func buttonTaped()
}

