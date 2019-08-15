//
//  NoteListViewController.swift
//  MokuMokuNotes_iOS
//
//  Created by Yoshitaka Seki on 2018/04/28.
//  Copyright © 2018年 takasek. All rights reserved.
//

import UIKit

final class NoteListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var presenter: NotePresenter!

    private var items: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = NotePresenter(repository: NoteRepository())
        presenter.delegate = self
        tableView.delegate = self

        presenter.getNotes()
    }

    @IBAction func addButtonDidTap() {
        presenter.addNewNote()
    }
}

extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let item = items[indexPath.row]
        cell.bind(note: item)

        return cell
    }
}

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        vc.note = items[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NoteListViewController: NotePresenterDelegate {
    func notePresenterDidReceiveNotes(_ notes: [Note]) {
        items = notes
        tableView.reloadData()
    }
}
