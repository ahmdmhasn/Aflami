//
//  MovieDetailsPresenter+TableViewDataSource.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/10/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

extension MovieDetailsPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trailersCellID, for: indexPath) as! TrailersTableViewCell
        cell.trailer = trailers[indexPath.row]
        return cell
    }
    
}
