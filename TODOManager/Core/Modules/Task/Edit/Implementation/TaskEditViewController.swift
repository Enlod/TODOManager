//
//  TaskEditViewController.swift
//  TemplateProject
//
//  Created by Roman Voskovskyi on 8/25/18.
//  Copyright © 2018 Roman Voskovskyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskEditViewController: TableViewController {
    private var taskObserver = TaskObserver(task: Task())
    private let presenter: TaskEditPresenterProtocol
    
    init(presenter: TaskEditPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        local {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
            cancelButton.rx.tap
                .subscribe(onNext: { _ in self.presenter.cancelEdit() })
                .disposed(by: self)
            
            navigationItem.leftBarButtonItem = cancelButton
        }
        
        local {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            doneButton.rx.tap
                .subscribe(onNext: { _ in self.presenter.doneEdit(self.taskObserver.task) })
                .disposed(by: self)
            
            navigationItem.rightBarButtonItem = doneButton
        }
        
        presenter.requestTask()
    }
}

//MARK: - TaskEditViewProtocol

extension TaskEditViewController: TaskEditViewProtocol {
    func show(_ task: Task) {
        taskObserver = TaskObserver(task: task)
        
        let nameGroup = TableViewCellGroupController(configurator:
            TableViewCellIndexConfigurator(
                dequeueCell: { [unowned self] cellProvider, _ in
                    let cell: TextFieldTableViewCell = cellProvider.reusableCell()
                    cell.maxInputLength = 20
                    
                    let textField = cell.textField
                    textField.placeholder = "Name"
                    
                    (textField.rx.text <-> self.taskObserver.name)
                        .disposed(by: cell.reuseDisposableBag.value)
                    
                    return cell
            }))
        
        let datePikcerGroup = TableViewCellGroupController(configurator:
            TableViewCellIndexConfigurator(
                dequeueCell: { [unowned self] cellProvider, _ in
                    let cell = cellProvider.reusableCell() as DatePikerTableViewCell

                    self.taskObserver.date
                        .asObservable()
                        .flatMap(Observable.from(optional:))
                        .bind(to: cell.datePicker.rx.date)
                        .disposed(by: cell.reuseDisposableBag.value)
                    
                    cell.datePicker.rx.date
                        .asObservable()
                        .subscribe(onNext: self.taskObserver.date.accept)
                        .disposed(by: cell.reuseDisposableBag.value)
                    
                    return cell
            }))
        datePikcerGroup.hidden = true
        
        let dateGroup = TableViewCellGroupController(configurator:
            TableViewCellIndexConfigurator(
                dequeueCell: { [unowned self] cellProvider, _ in
                    let cell = cellProvider.reusableCell() as TitleWithValueTableViewCell
                    cell.titleLabel.text = "Date"
                    cell.accessoryType = .disclosureIndicator
                    
                    self.taskObserver.date
                        .asObservable()
                        .map { date in
                            date.map { date in
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateStyle = .short
                                dateFormatter.timeStyle = .long
                                
                                return dateFormatter.string(from: date)
                            } ?? "Select date"
                        }
                        .bind(to: cell.valueLabel.rx.text )
                        .disposed(by: cell.reuseDisposableBag.value)
                    
                    return cell
                }, onSelect: { _, deselect in
                    deselect()
                    
                    datePikcerGroup.hidden.toggle()
            }))
        
        let section = TableViewSectionController(
            name: "New Task",
            cellGroups: [nameGroup, dateGroup, datePikcerGroup]
        )
        
        let sections = TableViewSectionsController(sections: [section])
        sections.rowAnimation.insert = .left
        sections.rowAnimation.delete = .right
        
        self.sectionsController = sections
    }
}
