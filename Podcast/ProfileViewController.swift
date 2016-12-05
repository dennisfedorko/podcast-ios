//
//  ProfileViewController.swift
//  Podcast
//
//  Created by Drew Dunne on 10/12/16.
//  Copyright © 2016 Cornell App Development. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProfileHeaderViewDelegate, UICollectionViewDataSource {
    
    private var activity: NSMutableArray?
    
    var profileHeaderView: ProfileHeaderView!
    var miniHeader: ProfileMiniHeader!
    var profileTableView: UITableView!
    
    let headerViewHeight = PHVConstants.height
    let sectionHeaderHeight: CGFloat = 37
    
    var user: User!
    var favorites: [Episode]!
    var subscriptions: [Series]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .podcastWhite
        
        // Instantiate tableView
        profileTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .grouped)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.backgroundColor = .podcastWhite
        profileTableView.register(ProfileFavoritesCell.self, forCellReuseIdentifier: "FavoritesCellIdentifier")
        profileTableView.separatorStyle = .none
        profileTableView.scrollIndicatorInsets.top = PHVConstants.statusBarHeight
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(profileTableView)
        
        // Instantiate tableViewHeader and the minified header
        profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: headerViewHeight))
        profileHeaderView.subscriptions.dataSource = self
        miniHeader = ProfileMiniHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: PHVConstants.miniHeight))
        
        // Will want to get user's info before if acting as detail
        // Will want to get THE user (as in the app user) if using the profile tab
        user = User()
        user.name = "Paul Dugg"
        user.username = "doglover12"
        user.followersCount = 100
        user.followingCount = 50
        
        // These could very well change, depends on how we will model data from backend
        favorites = user.favorites
        subscriptions = user.subscriptions
        
        // Set the user in the headers and set the header to the table header
        profileHeaderView.user = user
        miniHeader.user = user
        profileTableView.tableHeaderView = profileHeaderView
        profileHeaderView.delegate = self
        
        // Add mini header last (make sure it's on top of hierarchy)
        view.addSubview(miniHeader)
        profileTableView.reloadData()
    }
    
    // Mark: - ProfileHeaderView
    func followButtonPressed(follow: Bool) {
        // Follow or unfollow a person
    }
    
    func buttonBarPressed(buttonBarNum: Int) {
        // Buttons (following/followers) pressed [Go to detail view]
    }
    
    func collectionViewCellDidSelectItemAtPath(path: IndexPath) {
        // Get subscription pressed from indexPath and show detail
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This depends on the cell we're going to use
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use this when we actually have data
//        return favorites.count
        return 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get episode from favorites and display it. Right now this is activity, will be favorite episodes later.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellIdentifier") as! ProfileFavoritesCell
        let episode = Episode(id: 0)
        episode.title = "Puppies Galore and how to feed your puppy the proper food so it does not die from starvation."
        let series = Series()
        series.title = "Backyard Puppies Podcast"
        episode.series = series
        episode.dateCreated = Date()
        episode.smallArtworkImage = #imageLiteral(resourceName: "fillerImage")
        cell.episode = episode
//        cell.episodeDescriptionLabel.text = "This episode is about how awesome puppies are, just like every other episode."
        // Use this when we actually have data
//        cell.episode = favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorites"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileSectionHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: sectionHeaderHeight))
        header.sectionTitle.text = self.tableView(tableView, titleForHeaderInSection: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Need something here to figure in tab bar height.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.tabBarController.tabBar.frame.size.height+3
//        return CGFloat.leastNormalMagnitude
//        return 16
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProfileFavoritesCell().height+2*ProfileFavoritesCell().contentPaddingY
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        profileHeaderView.animateByYOffset(scrollView.contentOffset.y)
        let yOffset = scrollView.contentOffset.y
        let belowThreshold = (yOffset <= (PHVConstants.bottomBarDist-PHVConstants.miniHeight))
        miniHeader.setTopOpacity(belowThreshold ? 0 : 1)
    }
    
    // MARK: - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return subscriptions.count
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell", for: indexPath) as! SeriesCollectionViewCell
        cell.seriesImage = #imageLiteral(resourceName: "fillerImage")
        // Will want to grab from subscriptions array
        return cell
    }

}
