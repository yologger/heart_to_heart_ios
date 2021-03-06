import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboard = AppStoryboard.home
    
    private var disposeBag = DisposeBag()
    var viewModel: HomeViewModel?
    
    @IBOutlet weak var postListContainer: UIView!
    @IBOutlet weak var searchHistoryContainer: UIView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    lazy var createPostButton: UIBarButtonItem = {
        
        let button = UIBarButtonItem(
            title: "POST",
            style: .plain,
            target: self,
            action: #selector(buttonPressed(_:))
        )
        button.tag = 2
        
        
        //        let button = UIBarButtonItem(
        //            title: "Create",
        //            style: .plain,
        //            target: self,
        //            action: #selector(buttonPressed(_:)))
        //        button.tag = 2
        
        return button
    }()
    
    lazy var testButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "TEST",
            style: .plain,
            target: self,
            action: #selector(buttonPressed(_:))
        )
        
        button.tag = 1
        
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        // self.initTableView()
        self.initNavigation()
        // self.initSearchBar()
        self.initBinding()
        //        searchController.hidesNavigationBarDuringPresentation = false
        //        searchController.searchResultsUpdater = self
        //        searchController.searchBar.delegate = self
        viewModel!.getAllPosts()
        viewModel!.showPostList()
        
        let behaviorSubject = PublishSubject<String>()  // 초기값
        let observable = behaviorSubject.asObservable()
        
        observable
            .subscribe(
                onNext: { data in print("onNext()")},
                onError: { error in print("onError()") },
                onCompleted: { print("onCompleted()")},
                onDisposed: { print("onDisposed()")}
            )
            .disposed(by: disposeBag)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
    }
    
    
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1:
                self.viewModel?.test()
            case 2:
                self.viewModel?.createPost()
            default:
                print("Button Error")
            }
        }
    }
    
    private func toggleSearchHistoryVisibility() {
        guard searchController.searchBar.isFirstResponder else {
            self.viewModel?.closeSearchHistory()
            return
        }
        self.viewModel?.showSearchHistory()
    }
}

// MARK: - Binding
extension HomeViewController {
    func initBinding() {
    }
}


// MARK: - Navigation
extension HomeViewController {
    func initNavigation() {
        self.navigationItem.rightBarButtonItem = self.createPostButton
//        self.navigationItem.rightBarButtonItems = [self.createPostButton, self.testButton]
        self.navigationController?.title = "Home"
        // self.navigationItem.title = "Home"
        self.navigationItem.largeTitleDisplayMode = .never
    }
}


// MARK: - Search Bar
//extension HomeViewController: UISearchControllerDelegate {
//
//    func initSearchBar() {
//        searchController.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        self.navigationItem.searchController = searchController
//    }
//
//    func willPresentSearchController(_ searchController: UISearchController) {
//        self.toggleSearchHistoryVisibility()
//    }
//
//    func willDismissSearchController(_ searchController: UISearchController) {
//        self.toggleSearchHistoryVisibility()
//    }
//
//    func didDismissSearchController(_ searchController: UISearchController) {
//        self.toggleSearchHistoryVisibility()
//    }
//}
//
//extension HomeViewController: UISearchBarDelegate {
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print("Result: \(text)")
//    }
//}
//
//extension HomeViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print("Current value: \(text)")
//    }
//}

