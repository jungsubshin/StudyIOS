
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var articleContentsLabel: UILabel!
    
    var articleData: Article?
    
    let dateHelper = DateHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = articleData?.contents!.data(using: String.Encoding.unicode)! else { return }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            articleContentsLabel.attributedText = attributedString
            let font = UIFont.systemFont(ofSize: 20)
            articleContentsLabel.font = font
        }
        
        loadMainImage()
        loadLogoImage()
        articleTitleLabel.text = articleData?.title
        publishDateLabel.text = dateHelper.getFormattedPublishDate(rawDate: (articleData?.publishDateTime!)!)
        publisherNameLabel.text = articleData?.publisherName
    }
    
    private func loadMainImage() {
        guard let mainImageUrlString = self.articleData?.imagePreviewURL, let mainImageUrl = URL(string: mainImageUrlString)  else {
            DispatchQueue.main.async {
                self.mainImageView.isHidden = true
                self.mainImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            }
            return
        }
        
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: mainImageUrl) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard self.articleData?.imagePreviewURL! == mainImageUrl.absoluteString else { return }
            
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func loadLogoImage() {
        guard let publisherImageUrlString = self.articleData?.publisherLogoURL, let publisherImageUrl = URL(string: publisherImageUrlString)  else { return }
        
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: publisherImageUrl) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard self.articleData?.publisherLogoURL! == publisherImageUrl.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.logoImageView.image = UIImage(data: data)
            }
        }
    }
    
}
