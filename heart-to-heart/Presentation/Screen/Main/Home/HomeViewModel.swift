import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    let didCoordinatorChange = PublishSubject<HomeCoordinatorOptions>()
    
    private let getAllPostsUseCase: GetAllPostsUseCase
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
    }
    
    func showPostList() {
        didCoordinatorChange.onNext(.showPostListVC)
    }
    
    func getAllPosts() {
        print("getAllPosts() from HomeViewModel")
    }
    
    func createPost() {
        self.didCoordinatorChange.onNext(.showCreatePostVC)
    }
    
    func showSearchHistory() {
        self.didCoordinatorChange.onNext(.showSearchHistoryVC)
    }
    
    func closeSearchHistory() {
        self.didCoordinatorChange.onNext(.closeSearchHistoryVC)
    }
    
    func test() {
        self.didCoordinatorChange.onNext(.openTestVC)
    }
}
