//
//  FriendListViewModel.swift
//  FriendList
//
//  Created by Huy Nguyen on 07/06/2021.
//

import Foundation
import Contacts
import ContactsUI

struct FriendListViewModelActions {
    let showFriendDetails: (Friend) -> Void
    let showFriendQueriesSuggestions: (@escaping (_ didSelect: FriendQuery) -> Void) -> Void
    let closeFriendQueriesSuggestions: () -> Void
}

protocol FriendListViewModelInput {
    func viewDidLoad()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
    func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void)
}

protocol FriendListViewModelOutput {
    var friendListItemViewModel: Observable<[FriendListItemViewModel]> { get }
    var contactList: Observable<[CNContact]> { get }
    var selectedHorizontalContact: Observable<FriendListItemViewModel?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var authorizedContact: Observable<Bool> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol FriendListViewModel: FriendListViewModelInput, FriendListViewModelOutput {}

final class DefaultFriendListViewModel: FriendListViewModel {
    
    private let fetchFriendFrequentsUseCase: FetchFriendsFrequentUseCase
    private let actions: FriendListViewModelActions?
    
    private var friendListLoadTask: Cancellable? { willSet { friendListLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let friendListItemViewModel: Observable<[FriendListItemViewModel]> = Observable([])
    let contactList: Observable<[CNContact]> = Observable([])
    var selectedHorizontalContact: Observable<FriendListItemViewModel?> = Observable(nil)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var authorizedContact: Observable<Bool> = Observable(false)
    var isEmpty: Bool { return friendListItemViewModel.value.isEmpty || contactList.value.isEmpty }
    let screenTitle = NSLocalizedString("Friends", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Friends", comment: "")
    
    // MARK: - Init
    
    init(fetchFriendFrequentsUseCase: FetchFriendsFrequentUseCase,
         actions: FriendListViewModelActions? = nil) {
        self.fetchFriendFrequentsUseCase = fetchFriendFrequentsUseCase
        self.actions = actions
    }
    
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading friends", comment: "")
    }
}

extension DefaultFriendListViewModel {
    
    func viewDidLoad() {
        friendListLoadTask = fetchFriendFrequentsUseCase.execute(completion: { result in
            switch result {
            case .success(let friendFrequents):
                var friendListItem = [FriendListItemViewModel]()
                friendFrequents.friends.forEach {
                    friendListItem.append(FriendListItemViewModel(friend: $0))
                }
                self.friendListItemViewModel.value.append(contentsOf: (friendListItem))
            case .failure(let error):
                self.handle(error: error)
            }
        })
        
        self.requestAccess { authorized in
            self.authorizedContact.value = authorized
            if authorized {
                self.contactList.value.append(contentsOf: self.getContactFromCNContact())
            }
        }
        
    }
    
    func didSearch(query: String) {
        
    }
    
    func didCancelSearch() {
        
    }
    
    func showQueriesSuggestions() {
        
    }
    
    func closeQueriesSuggestions() {
        
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        
    }
}

extension DefaultFriendListViewModel {
    
    fileprivate func getContactFromCNContact() -> [CNContact] {
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactEmailAddressesKey,
        ] as [Any]
        
        //Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        var results: [CNContact] = []
        allContainers.forEach {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: $0.identifier)
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        return results
    }
    
    fileprivate func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied:
            showSettingsAlert(completionHandler)
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        self.showSettingsAlert(completionHandler)
                    }
                }
            }
        @unknown default:
            fatalError("Can not request access for contact")
        }
    }
}
