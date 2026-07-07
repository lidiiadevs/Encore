//
//  AddEditShowView.swift
//  Encore
//
//  Created by Lidiia Diachkovskaia on 7/1/26.
//

import SwiftUI
import SwiftData

struct AddEditShowView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: AddEditShowViewModel
    
    let existingShow: Show?
    init(show: Show? = nil, initialStatus: ShowStatus = .upcoming) {
        self.existingShow = show
        self._viewModel = //is accessing @State property itself, not the wrapped value. You handing it a pre-constructed viewModel at the moment the state is initialized. Without it you will get a compilation error. You'd be assigning to viewModel before the property even exists with it.
        State(initialValue:  AddEditShowViewModel(show: show, initialStatus: initialStatus))
    }
    
    
    var body: some View {
        @Bindable var vm = viewModel //vm just gives us the dollar sign syntax for form binding
        
        NavigationStack {
            Form {
                Section("Show Info") {
                    TextField("Artist", text: $vm.artistName)
                        .autocorrectionDisabled()
                    TextField("Venue", text: $vm.venueName)
                        .autocorrectionDisabled()
                    TextField("City", text: $vm.city)
                    DatePicker("Date", selection: $vm.date, displayedComponents: .date)
                    Picker("status", selection: $vm.status) {
                        ForEach(ShowStatus.allCases, id:\.self) { status in
                            Text(status.rawValue.capitalized)
                                .tag(status) //to match the value
                        }
                    }
                }
                if viewModel.status == .attended {
                    Section("Rating") {
                        StarRatingView(rating: $vm.rating)
                            .padding(.vertical, 4)
                    }
                }
                
                Section("Notes") {
                    TextField("Add notes ...", text: $vm.notes, axis: .vertical)
                        .lineLimit(3...6) //up to 6 lines
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.sentences)
                }
                Section("Setlist") {
                    ForEach(viewModel.setlist.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundStyle(.secondary)
                                .frame(width: 28, alignment: .leading)
                            Text(viewModel.setlist[index])
                        }
                    }
                    .onDelete {
                        viewModel.setlist.remove(atOffsets: $0)}
                    .onMove { viewModel.setlist.move(fromOffsets: $0, toOffset: $1)}
                    
                    TextField("Add Song", text: $vm.newSetlistEntry)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.sentences)
                    Button("Add") {
                        viewModel.addSetlistEntry()
                    }
                    .disabled(viewModel.newSetlistEntry.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle(existingShow == nil ? "Add Show" : "Edit Show")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.save(to: modelContext, existing: existingShow)
                        dismiss()
                    }
                    .disabled(!viewModel.isValid)
                }
            }
        }
    }
}

#Preview {
    AddEditShowView()
}
