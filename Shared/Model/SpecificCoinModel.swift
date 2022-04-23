//
//  SpecificCoinModel.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 05-04-22.
//

import Foundation

// MARK: - CoinModel
struct SpecificCoinModel: Decodable, Hashable {
    let id: String?
    let symbol, name: String?
    let assetPlatformID: String?
    let platforms: Platforms?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
//    let categories: [String?]
    let publicNotice: String?
    let additionalNotices: [String?]
    let localization, coinModelDescription: Tion?
    let links: Links?
    let image: AssetImage?
    let countryOrigin, genesisDate: String?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
    let marketCapRank, coingeckoRank: Int?
    let coingeckoScore, developerScore, communityScore, liquidityScore: Double?
    let publicInterestScore: Int?
    let marketData: MarketData?
    let communityData: CommunityData?
    let developerData: DeveloperData?
    let publicInterestStats: PublicInterestStats?
//    let statusUpdates: [String?]
    let lastUpdated: String?
    let tickers: [Ticker?]
    
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
    let en, de, es, fr: String?
    let it, pl, ro, hu: String?
    let nl, pt, sv, vi: String?
    let tr, ru, ja, zh: String?
    let zhTw, ko, ar, th: String?
    let id, cs, da, el: String?
    let hi, no, sk, uk: String?
    let he, fi, bg, hr: String?
    let lt, sl: String?
    
    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}

// MARK: - CommunityData
struct CommunityData: Decodable, Hashable  {
    let facebookLikes: Int?
    let twitterFollowers: Int?
    let redditAveragePosts48H, redditAverageComments48H: Double?
    let redditSubscribers, redditAccountsActive48H: Int?
    let telegramChannelUserCount: Int?
    
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
    let forks, stars, subscribers, totalIssues: Int?
    let closedIssues, pullRequestsMerged, pullRequestContributors: Int?
    let codeAdditionsDeletions4_Weeks: CodeAdditionsDeletions4_Weeks?
    let commitCount4_Weeks: Int?
    let last4_WeeksCommitActivitySeries: [Int?]
    
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
    let additions, deletions: Int?
}

// MARK: - Image
struct AssetImage: Decodable, Hashable  {
    let thumb, small, large: String?
}

//// MARK: - Links
struct Links: Decodable, Hashable  {
    let homepage: [String?]
    let blockchainSite, officialForumURL: [String?]
    let chatURL, announcementURL: [String?]
    let twitterScreenName: String?
    let facebookUsername: String?
    let bitcointalkThreadIdentifier: Double?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    let reposURL: ReposURL?
    
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
    let github: [String?]
    let bitbucket: [String?]
}

// MARK: - MarketData
struct MarketData: Decodable, Hashable  {
    let currentPrice: [String: Double]
//    let totalValueLocked, mcapToTvlRatio, fdvToTvlRatio: Double?
    let roi: Roi?
    let ath, athChangePercentage: [String: Double]
    let athDate: [String: String]
    let atl, atlChangePercentage: [String: Double]
    let atlDate: [String: String]
    let marketCap: [String: Double]
    let marketCapRank: Int?
    let fullyDilutedValuation, totalVolume, high24H, low24H: [String: Double]
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double?
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double?
    let marketCapChange24H, marketCapChangePercentage24H: Double?
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]
    let priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]
    let totalSupply, maxSupply, circulatingSupply: Double?
    let lastUpdated: String?
    
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
        case lastUpdated = "last_updated"
    }
}

// MARK: - Platforms
struct Platforms: Decodable, Hashable  {
    let empty: String?
    
    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - PublicInterestStats
struct PublicInterestStats: Decodable, Hashable  {
    let alexaRank: Int?
    let bingMatches: Int?
    
    enum CodingKeys: String, CodingKey {
        case alexaRank = "alexa_rank"
        case bingMatches = "bing_matches"
    }
}

// MARK: - Ticker
struct Ticker: Decodable, Hashable  {
    let base, target: String?
    let market: Market?
    let last, volume: Double?
//    let convertedLast, convertedVolume: [String?: Double?]
    let trustScore: String?
    let bidAskSpreadPercentage: Double?
    let timestamp, lastTradedAt, lastFetchAt: String?
    let isAnomaly, isStale: Bool?
    let tradeURL: String?
    let tokenInfoURL: String?
    let coinID: String?
    let targetCoinID: String?
    
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
    let name, identifier: String?
    let hasTradingIncentive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
    }
}


// MARK: - Roi
struct Roi: Decodable, Hashable  {
    let times: Double?
    let currency: String?
    let percentage: Double?
    
    enum CodingKeys: String, CodingKey {
        case times, currency, percentage
    }
}
