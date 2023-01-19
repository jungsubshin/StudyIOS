
import UIKit


struct Article: Codable {
    let id, mainGenreID, title: String?
    let publishDateTime: String?
    let imageOriginalSizeVersionURL, imageFullPageVersionURL, imagePreviewURL: String?
    let publisherID, publisherName: String?
    let publisherLogoURL: String?
    let publisherLogoDestinationURL: String?
    let publisherCopyright, contents: String?
    let relatedLinks: [RelatedLink]

    enum CodingKeys: String, CodingKey {
        case id
        case mainGenreID = "mainGenreId"
        case title, publishDateTime
        case imageOriginalSizeVersionURL = "imageOriginalSizeVersionUrl"
        case imageFullPageVersionURL = "imageFullPageVersionUrl"
        case imagePreviewURL = "imagePreviewUrl"
        case publisherID = "publisherId"
        case publisherName
        case publisherLogoURL = "publisherLogoUrl"
        case publisherLogoDestinationURL = "publisherLogoDestinationUrl"
        case publisherCopyright, contents, relatedLinks
    }

}

// MARK: - RelatedLink
struct RelatedLink: Codable {
    let title: String?
    let url: String?
}
