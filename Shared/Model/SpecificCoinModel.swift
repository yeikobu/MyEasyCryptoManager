//
//  SpecificCoinModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

// MARK: - CoinModel
struct SpecificCoinModel: Decodable, Hashable {
    var id: String? = ""
    var symbol: String? = ""
    var name: String? = ""
    var assetPlatformID: String? = ""
    var platforms: Platforms?
    var blockTimeInMinutes: Int? = 0
    var hashingAlgorithm: String? = ""
//    varet categories: [String?]
    var publicNotice: String? = ""
    var additionalNotices: [String?] = []
    var localization, coinModelDescription: Tion?
    var links: Links?
    var image: AssetImage?
    var countryOrigin: String? = ""
    var genesisDate: String? = ""
    var sentimentVotesUpPercentage: Double? = 0
    var sentimentVotesDownPercentage: Double? = 0
    var marketCapRank: Int? = 0
    var coingeckoRank: Int? = 0
    var coingeckoScore: Double? = 0
    var developerScore: Double? = 0
    var communityScore: Double? = 0
    var liquidityScore: Double? = 0
    var publicInterestScore: Int? = 0
    var marketData: MarketData?
    var communityData: CommunityData?
    var developerData: DeveloperData?
    var publicInterestStats: PublicInterestStats?
//    varet statusUpdates: [String?]
    var lastUpdated: String? = ""
    var tickers: [Ticker?] = []
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case assetPlatformID = "asset_platform_id"
        case platforms
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
//        case categories
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case localization
        case coinModelDescription = "description"
        case links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case coingeckoScore = "coingecko_score"
        case developerScore = "developer_score"
        case communityScore = "community_score"
        case liquidityScore = "liquidity_score"
        case publicInterestScore = "public_interest_score"
        case marketData = "market_data"
        case communityData = "community_data"
        case developerData = "developer_data"
        case publicInterestStats = "public_interest_stats"
//        case statusUpdates = "status_updates"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - Tion
struct Tion: Decodable, Hashable {
    var en: String? = "", de: String? = "", es: String? = "", fr: String? = ""
    var it: String? = "", pl: String? = "", ro: String? = "", hu: String? = ""
    var nl: String? = "", pt: String? = "", sv: String? = "", vi: String? = ""
    var tr: String? = "", ru: String? = "", ja: String? = "", zh: String? = ""
    var zhTw: String? = "", ko: String? = "", ar: String? = "", th: String? = ""
    var id: String? = "", cs: String? = "", da: String? = "", el: String? = ""
    var hi: String? = "", no: String? = "", sk: String? = "", uk: String? = ""
    var he: String? = "", fi: String? = "", bg: String? = "", hr: String? = ""
    var lt: String? = "", sl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}

// MARK: - CommunityData
struct CommunityData: Decodable, Hashable  {
    var facebookLikes: Int? = 0
    var twitterFollowers: Int? = 0
    var redditAveragePosts48H: Double? = 0, redditAverageComments48H: Double? = 0
    var redditSubscribers: Int? = 0, redditAccountsActive48H: Int? = 0
    var telegramChannelUserCount: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case facebookLikes = "facebook_likes"
        case twitterFollowers = "twitter_followers"
        case redditAveragePosts48H = "reddit_average_posts_48h"
        case redditAverageComments48H = "reddit_average_comments_48h"
        case redditSubscribers = "reddit_subscribers"
        case redditAccountsActive48H = "reddit_accounts_active_48h"
        case telegramChannelUserCount = "telegram_channel_user_count"
    }
}

// MARK: - DeveloperData
struct DeveloperData: Decodable, Hashable  {
    var forks: Int? = 0, stars: Int? = 0, subscribers: Int? = 0, totalIssues: Int? = 0
    var closedIssues: Int? = 0, pullRequestsMerged: Int? = 0, pullRequestContributors: Int? = 0
    var codeAdditionsDeletions4_Weeks: CodeAdditionsDeletions4_Weeks?
    var commitCount4_Weeks: Int? = 0
    var last4_WeeksCommitActivitySeries: [Int?] = []
    
    enum CodingKeys: String, CodingKey {
        case forks, stars, subscribers
        case totalIssues = "total_issues"
        case closedIssues = "closed_issues"
        case pullRequestsMerged = "pull_requests_merged"
        case pullRequestContributors = "pull_request_contributors"
        case codeAdditionsDeletions4_Weeks = "code_additions_deletions_4_weeks"
        case commitCount4_Weeks = "commit_count_4_weeks"
        case last4_WeeksCommitActivitySeries = "last_4_weeks_commit_activity_series"
    }
}

// MARK: - CodeAdditionsDeletions4_Weeks
struct CodeAdditionsDeletions4_Weeks: Decodable, Hashable  {
    var additions: Int? = 0, deletions: Int? = 0
}

// MARK: - Image
struct AssetImage: Decodable, Hashable  {
    var thumb: String? = "", small: String? = "", large: String? = ""
}

//// MARK: - Links
struct Links: Decodable, Hashable  {
    var homepage: [String?] = []
    var blockchainSite: [String?] = [], officialForumURL: [String?] = []
    var chatURL: [String?] = [], announcementURL: [String?] = []
    var twitterScreenName: String? = ""
    var facebookUsername: String? = ""
    var bitcointalkThreadIdentifier: Double? = 0
    var telegramChannelIdentifier: String? = ""
    var subredditURL: String? = ""
    var reposURL: ReposURL?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
    }
}

// MARK: - ReposURL
struct ReposURL: Decodable, Hashable  {
    var github: [String?] = []
    var bitbucket: [String?] = []
}

// MARK: - MarketData
struct MarketData: Decodable, Hashable  {
    var currentPrice: [String: Double] = [:]
//varet totalValueLocked, mcapToTvlRatio, fdvToTvlRatio: Double?
    var roi: Roi?
    var ath: [String: Double] = [:], athChangePercentage: [String: Double] = [:]
    var athDate: [String: String] = [:]
    var atl: [String: Double] = [:], atlChangePercentage: [String: Double] = [:]
    var atlDate: [String: String] = [:]
    var marketCap: [String: Double] = [:]
    var marketCapRank: Int? = 0
    var fullyDilutedValuation: [String: Double] = [:], totalVolume: [String: Double] = [:], high24H: [String: Double] = [:], low24H: [String: Double] = [:]
    var priceChange24H: Double? = 0, priceChangePercentage24H: Double? = 0, priceChangePercentage7D: Double? = 0, priceChangePercentage14D: Double? = 0
    var priceChangePercentage30D: Double? = 0, priceChangePercentage60D: Double? = 0, priceChangePercentage200D: Double? = 0, priceChangePercentage1Y: Double? = 0
    var marketCapChange24H: Double? = 0, marketCapChangePercentage24H: Double?
    var priceChange24HInCurrency: [String: Double] = [:], priceChangePercentage1HInCurrency: [String: Double] = [:], priceChangePercentage24HInCurrency: [String: Double] = [:], priceChangePercentage7DInCurrency: [String: Double] = [:]
    var priceChangePercentage14DInCurrency: [String: Double] = [:], priceChangePercentage30DInCurrency: [String: Double] = [:], priceChangePercentage60DInCurrency: [String: Double] = [:], priceChangePercentage200DInCurrency: [String: Double]
    var priceChangePercentage1YInCurrency: [String: Double] = [:], marketCapChange24HInCurrency: [String: Double] = [:], marketCapChangePercentage24HInCurrency: [String: Double] = [:]
    var totalSupply, maxSupply, circulatingSupply: Double?
    var sparkline7D: Sparkline7D?
    var lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
//        case totalValueLocked = "total_value_locked"
//        case mcapToTvlRatio = "mcap_to_tvl_ratio"
//        case fdvToTvlRatio = "fdv_to_tvl_ratio"
        case roi, ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case sparkline7D = "sparkline_7d"
        case lastUpdated = "last_updated"
    }
}

struct Sparkline7D: Decodable, Hashable {
    var price: [Double] = []
}

// MARK: - Platforms
struct Platforms: Decodable, Hashable  {
    var empty: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - PublicInterestStats
struct PublicInterestStats: Decodable, Hashable  {
    var alexaRank: Int? = 0
    var bingMatches: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case alexaRank = "alexa_rank"
        case bingMatches = "bing_matches"
    }
}

// MARK: - Ticker
struct Ticker: Decodable, Hashable  {
    var base: String? = "", target: String? = ""
    var market: Market?
    var last: Double? = 0, volume: Double? = 0
//  varet convertedLast, convertedVolume: [String?: Double?]
    var trustScore: String? = ""
    var bidAskSpreadPercentage: Double? = 0
    var timestamp: String? = "", lastTradedAt: String? = "", lastFetchAt: String? = ""
    var isAnomaly: Bool? = false, isStale: Bool? = false
    var tradeURL: String? = ""
    var tokenInfoURL: String? = ""
    var coinID: String? = ""
    var targetCoinID: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case base, target, market, last, volume
//        case convertedLast = "converted_last"
//        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeURL = "trade_url"
        case tokenInfoURL = "token_info_url"
        case coinID = "coin_id"
        case targetCoinID = "target_coin_id"
    }
}

// MARK: - Market
struct Market: Decodable, Hashable  {
    var name: String? = "", identifier: String? = ""
    var hasTradingIncentive: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
    }
}


// MARK: - Roi
struct Roi: Decodable, Hashable  {
    var times: Double? = 0
    var currency: String? = ""
    var percentage: Double? = 0
    
    enum CodingKeys: String, CodingKey {
        case times, currency, percentage
    }
}
