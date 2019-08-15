//
//  NotePresenter.swift
//  MokuMokuNotes_iOS
//
//  Created by Yoshitaka Seki on 2018/04/28.
//  Copyright © 2018年 takasek. All rights reserved.
//

import Foundation

protocol NotePresenterDelegate: class {
    func notePresenterDidReceiveNotes(_ notes: [Note])
}

final class NotePresenter {
    private let repository: NoteRepository
    weak var delegate: NotePresenterDelegate!

    init(repository: NoteRepository) {
        self.repository = repository
        self.repository.delegate = self
    }

    func getNotes() {
        repository.getNotes()
    }

    func addNewNote() {
        let note = Note(createdAt: Date())
        repository.save(note: note)
    }
}

extension NotePresenter: NoteRepositoryDelegate {
    func noteRepositoryDidReceiveNotes(_ notes: [Note]) {
        delegate.notePresenterDidReceiveNotes(notes)
    }
}
