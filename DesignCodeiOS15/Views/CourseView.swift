//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-28.
//

import SwiftUI

struct CourseView: View {
    let course: Course
    let namespace: Namespace.ID
    @Binding var show: Bool
    @State private var appearStates = (divider: false, author: false, content: false)
    @State private var dragViewTranslation: CGSize = .zero
    @State private var isDraggable = true

    var body: some View {
        ZStack {
            ScrollView {
                cover
                content
            }
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: dragViewTranslation.width / 4, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(dragViewTranslation.width / -1000 + 1)
            .background(Color.black.opacity(dragViewTranslation.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()

            closeButton
                .onChange(of: show) { _ in
                    fadeOut()
                }
        }
        .onAppear {
            fadeIn()
        }
    }

    private var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                guard value.startLocation.x < 50 else { return }

                withAnimation(.closeCard) {
                    dragViewTranslation = value.translation
                }

                if dragViewTranslation.width > 120 {
                    dragDismiss()
                }
            }
            .onEnded { value in
                if dragViewTranslation.width > 80 {
                    dragDismiss()
                }
            }
    }

    private var cover: some View {
        GeometryReader { proxy in
            let scrollY: CGFloat = max(proxy.frame(in: .global).minY, 0)

            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 500 + scrollY)
            .foregroundColor(.black)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image_\(course.id)", in: namespace)
                    .offset(y: scrollY * -0.8)
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background_\(course.id)", in: namespace)
                    .offset(y: -scrollY)
                    .scaleEffect(scrollY / 1000 + 1)
                    .blur(radius: scrollY / 30)
            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask_\(course.id)", in: namespace)
                    .offset(y: -scrollY)
            )
            .overlay {
                overlayContent
                    .offset(y: scrollY * -0.6)
            }
        }
        .frame(height: 500)
    }

    private var closeButton: some View {
        Button { dismiss() } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(25)
        .ignoresSafeArea()
    }

    private var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title_\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(course.subtitle.uppercased())
                .matchedGeometryEffect(id: "subtitle_\(course.id)", in: namespace)
                .font(.footnote.weight(.semibold))
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text_\(course.id)", in: namespace)
            Divider()
                .opacity(appearStates.divider ? 1 : 0)
            HStack {
                Image(course.logo)
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 18, style: .continuous)
                    )
                    .strokeStyle(cornerRadius: 18)
                Text("Taught by Meng To")
                    .font(.footnote)
            }
            .opacity(appearStates.author ? 1 : 0)
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur_\(course.id)", in: namespace)
        )
        .offset(y: 250)
        .padding(20)
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("SwiftUI is hands-down the best way for designers to take a first step into code. ")
                .font(.title3).fontWeight(.medium)
            Text("This course")
                .font(.title).bold()
            Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            Text("This year, SwiftUI got major upgrades from the WWDC 2020. The big news is that thanks to Apple Silicon, Macs will be able to run iOS and iPad apps soon. SwiftUI is the only framework that allows you to build apps for all of Apple's five platforms: iOS, iPadOS, macOS, tvOS and watchOS with the same codebase. New features like the Sidebar, Lazy Grid, Matched Geometry Effect and Xcode 12's visual editing tools will make it easier than ever to build for multiple platforms.")
            Text("Multiplatform app")
                .font(.title).bold()
            Text("For the first time, you can build entire apps using SwiftUI only. In Xcode 12, you can now create multi-platform apps with minimal code changes. SwiftUI will automatically translate the navigation, fonts, forms and controls to its respective platform. For example, a sidebar will look differently on the Mac versus the iPad, while using exactly the same code. Dynamic type will adjust for the appropriate platform language, readability and information density. ")
        }
        .padding(20)
        .offset(y: 120)
        .padding(.bottom, 200)
        .opacity(appearStates.content ? 1 : 0)
    }

    private func dismiss() {
        withAnimation(.closeCard) {
            show = false
        }
    }

    private func fadeIn() {
        withAnimation(.easeInOut.delay(0.3)) {
            appearStates.author = true
        }
        withAnimation(.easeInOut.delay(0.4)) {
            appearStates.divider = true
        }
        withAnimation(.easeInOut.delay(0.5)) {
            appearStates.content = true
        }
    }

    private func fadeOut() {
        appearStates.content = false
        appearStates.divider = false
        appearStates.author = false
    }

    private func dragDismiss() {
        withAnimation(.closeCard.delay(0.3)) {
            show = false
        }

        withAnimation(.easeInOut) {
            dragViewTranslation = .zero
        }

        isDraggable = false
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        CourseView(course: courses[0], namespace: namespace, show: .constant(true))
    }
}
