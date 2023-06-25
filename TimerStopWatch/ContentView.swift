//
//  ContentView.swift
//  TimerStopWatch
//
//  Created by Alex Hudson on 6/24/23.
//

import SwiftUI

struct ContentView: View {

    @State private var viewModel = ViewModel()
    var startButtonText = "  Start   "

    var body: some View {

        VStack(spacing: 2) {
            HStack {
                if viewModel.clockType == .Timer {
                    Image(systemName: "chevron.up")
                        .offset(x: -21.0, y: 4)
                        .foregroundColor(.green)
                        .onTapGesture {
                            viewModel.incrementMinutes()
                        }
                    Image(systemName: "chevron.up")
                        .offset(x: 21.0, y: 4)
                        .foregroundColor(.green)
                        .onTapGesture {
                            viewModel.incrementSeconds()
                        }
                } else {
                    EmptyView()
                }
            }
            .font(.title)
            .frame(height: 30)

            HStack(spacing: 4) {
                Text(viewModel.minutesString())
                    .frame(width: 90, alignment: .trailing)

                Text(":")
                    .offset(y: -5)
                Text(viewModel.secondsString())
                    .frame(width: 90, alignment: .leading)
            }
            .font(.extraLargeTitle)

            HStack {
                if viewModel.clockType == .Timer {

                    Image(systemName: "chevron.down")
                        .offset(x: -21.0, y: -4)
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.decrementMinutes()
                        }
                    Image(systemName: "chevron.down")
                        .offset(x: 21.0, y: -4)
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.decrementSeconds()
                        }

                } else {
                    Group {
                        EmptyView()
                    }

                }
            }
            .font(.title)
            .frame(height: 30)

            Button(startButtonText) {

            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.bottom)
            .disabled(viewModel.isInvalidState())

        }
        .padding(.top, 16)
        .padding(.horizontal, 25)
        .padding(.bottom,5)
        .ornament(attachmentAnchor: .scene(alignment: .bottom)) {
            Picker("", selection: $viewModel.clockType) {
                Text("Timer").tag(ClockType.Timer)
                Text("Stop Watch").tag(ClockType.StopWatch)
            }
            .pickerStyle(.segmented)
            .padding()
            .frame(width: 350)

        }
        .frame(height: 230)
    }
}

#Preview {
    ContentView()
        .glassBackgroundEffect()
}
