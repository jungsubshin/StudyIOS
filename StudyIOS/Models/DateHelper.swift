
import UIKit


class DateHelper {
    
    let dateFormatter = DateFormatter()

    func getFormattedPublishDate(rawDate: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        let date = dateFormatter.date(from: rawDate)
        dateFormatter.dateFormat = "M月dd日 HH:mm"
        return dateFormatter.string(from: date!)
    }
}
