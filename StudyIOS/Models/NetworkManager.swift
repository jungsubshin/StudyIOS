
import Foundation

//MARK: - 네트워크에서 발생할 수 있는 에러 정의

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking (서버와 통신하는) 클래스 모델

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    var url = "https://external-api.news.infoseek.co.jp/news/link/v2/genre-tabs/all/articles"
    var gunosyUrl = "https://external-api.news.infoseek.co.jp/news/link/v1/all/articles"
    
    typealias NetworkCompletion = (Result<[Article], NetworkError>) -> Void

    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
    func fetchArticles(genre: String, page: Int, completion: @escaping NetworkCompletion) {
        performRequest(with: url + "?page=" + String(page)) { result in
            completion(result)
        }
        
    }
    
    // 실제 Request하는 함수 (비동기적 실행 ===> 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        //print(#function)
        guard let url = URL(string: urlString) else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.setValue("API-Access-Token", forHTTPHeaderField: "App")
        request.allHTTPHeaderFields = ["API-Access-Token": "App"]
//        request.allHTTPHeaderFields = ["X-DEVICE-APP-VERSION": "1"]
//        request.allHTTPHeaderFields = ["X-DEVICE-BUNDLE-IDENTIFIER": "test"]
//        request.allHTTPHeaderFields = ["X-DEVICE-INSTALLED-AT": "0"]
//        request.allHTTPHeaderFields = ["X-DEVICE-OS": "android"]
//        request.allHTTPHeaderFields = ["X-DEVICE-OS-VERSION": "29"]
//        request.allHTTPHeaderFields = ["X-DEVICE-NAME": "null"]
//        request.allHTTPHeaderFields = ["X-DEVICE-DUID": "null"]
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            print(safeData)
            
            // 메서드 실행해서, 결과를 받음
            if let articles = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(articles))
            } else {
                dump(request)
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ articleData: Data) -> [Article]? {
        //print(#function)
    
        // 성공
        do {
            let articles = try JSONDecoder().decode([Article].self, from: articleData)
            return articles
        // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
