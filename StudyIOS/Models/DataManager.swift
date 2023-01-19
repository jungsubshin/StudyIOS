//
//  DataManager.swift
//  TableView
//
//  Created by Allen H on 2022/01/17.
//

import UIKit

class DataManager {
    private var articleDataArray: [Article] = []
    
    func makeArticleData() {
        articleDataArray = [
            Article(id: "fullcount_123", mainGenreID: "sport", title: "ホークス先発は東浜、西武山川は不動の4番　沖縄凱旋の両選手の対決に注目", publishDateTime: "2019-05-21T09:03:00Z", imageOriginalSizeVersionURL: "https://media.image.infoseek.co.jp/isnews/photos/fullcount/fullcount_382777_0.jpg", imageFullPageVersionURL: "https://media.image.infoseek.co.jp/isnews/photos/fullcount/fullcount_382777_0-enlarge.jpg", imagePreviewURL: "https://media.image.infoseek.co.jp/isnews/photos/fullcount/fullcount_382777_0-small.jpg", publisherID: "fullcount", publisherName: "Full-Count", publisherLogoURL: "https://image.infoseek.rakuten.co.jp/content/news/icon/full-count.png", publisherLogoDestinationURL: "https://full-count.jp/", publisherCopyright: "Copyright © Full-Count. All Rights Reserved.", contents: "<p>■ソフトバンクは内川がスタメンから外れ、明石が一塁</p><p>■西武 – ソフトバンク（21日・那覇）</p><p>　西武は21日、沖縄・那覇市の沖縄セルラースタジアム那覇でソフトバンクと対戦する。試合開始に先立って両チームのスタメンが発表された。</p><p>　西武は1番に秋山が入り、外崎、源田、山川の並びに。主砲・山川は故郷凱旋の試合で一発を放つことができるか。先発マウンドには十亀が上がる。</p><p>　ソフトバンクは沖縄出身の東浜が先発。1番に釜元が入り、周東、今宮、デスパイネの上位打線に。この日は内川がスタメンから外れ、一塁には明石が起用される。</p><p>　両チームのスタメンは以下の通り。</p><p>【西武】<br />1（中）秋山<br />2（二）外崎<br />3（遊）源田<br />4（一）山川<br />5（捕）森<br />6（三）中村<br />7（指）栗山<br />8（右）木村<br />9（左）金子侑<br />投手　十亀</p><p>【ソフトバンク】<br />1（中）釜元<br />2（右）周東<br />3（遊）今宮<br />4（指）デスパイネ<br />5（三）松田宣<br />6（左）グラシアル<br />7（一）明石<br />8（二）牧原<br />9（捕）甲斐<br />投手　東浜（福谷佑介 / Yusuke Fukutani）</p>", relatedLinks: [])
        
        ]
    }
    
    func getArticleData() -> [Article] {
        return articleDataArray
    }
    
}
