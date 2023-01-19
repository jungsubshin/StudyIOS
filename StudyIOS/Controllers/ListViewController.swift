
import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 테이블뷰의 데이터를 표시하기 위한 배열
    var articleArray: [Article] = [] {
        didSet {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }
    }
    
    var networkManager = NetworkManager.shared
    var dateHelper = DateHelper()
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var dataManager = DataManager()
    
    var currentPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ISNEWS"
        setupTableView()
        //setupDatas()
        setupDatasFromApi(page: currentPage)
    }
    
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 120
    }
    
    func setupDatas() {
        dataManager.makeArticleData()
        articleArray = dataManager.getArticleData()
        print(#function)
        print(articleArray.count)
        //setupDatasFromApi()
    }
    
    // 데이터 셋업
    func setupDatasFromApi(page: Int) {
        // 네트워킹의 시작
        networkManager.fetchArticles(genre: "all", page: page) { result in
            print(#function)
            switch result {
            case .success(let articleData):
                // 데이터(배열)을 받아오고 난 후
                self.articleArray.append(contentsOf: articleData)
                
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        currentPage += 1
        setupDatasFromApi(page: currentPage)
    }
}

extension ListViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! MyTableViewCell
        
        cell.previewImageUrl = articleArray[indexPath.row].imagePreviewURL
        cell.articleTitleLabel.text = articleArray[indexPath.row].title
        cell.publishDateLabel.text = dateHelper.getFormattedPublishDate(rawDate: articleArray[indexPath.row].publishDateTime!)
        cell.publisherLabel.text = articleArray[indexPath.row].publisherName
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이를 실행
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    // prepare세그웨이(데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let index = sender as! IndexPath
            
            // 배열에서 아이템을 꺼내서, 다음화면으로 전달
            detailVC.articleData = articleArray[index.row]
        }
    }
}


