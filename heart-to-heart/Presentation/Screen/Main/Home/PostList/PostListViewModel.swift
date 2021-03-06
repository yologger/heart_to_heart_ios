import UIKit
import RxSwift
import RxCocoa

class PostListViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    private let getAllPostsUseCase: GetAllPostsUseCase
    
    private var pageNumber = 0
    private let pageSize = 10
    private var hasMoreItems = true
    var isLoading = false
    
    var posts: [Post] = []
    let postsObservable = BehaviorSubject<[Post]>(value: [])
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
    }
    
    func clear() {
        pageNumber = 0
        hasMoreItems = true
        isLoading = false
        posts = []
        postsObservable.onNext([])
    }
    
    func getPosts() {
        if !self.isLoading {
            self.isLoading = true
            if (!hasMoreItems) { return }
            getAllPostsUseCase.pageNumber = pageNumber
            getAllPostsUseCase.pageSize = pageSize
            getAllPostsUseCase.execute()
                .take(1)
                .subscribe(onNext: { [weak self] (result) in
                    switch result {
                    case .success(let data):
                        self?.isLoading = false
                        self?.hasMoreItems = data.posts?.count == self?.pageSize
                        self?.posts.append(contentsOf: data.posts!)
                        self?.postsObservable.onNext(self?.posts ?? [])
                        self?.pageNumber += 1
                    case .failure(let error):
                        self?.isLoading = false
                    }
                    
                }, onError: { (error) in
                    
                }, onCompleted: {
                    
                }, onDisposed: {
                    
                }).disposed(by: disposeBag)
        }
    }
}
