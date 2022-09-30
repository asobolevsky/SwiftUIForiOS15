//
//  HomeView.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-12.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var model: Model
    @Namespace private var namespace
    @State private var hasScrolled = false
    @State private var selectedCourse: Course?

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            ScrollView {
                scrollDetection

                featured

                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                ForEach(courses) { course in
                    CourseItem(course: course, namespace: namespace)
                        .onTapGesture {
                            selectedCourse = course
                            withAnimation(.openCard) {
                                model.showDetailedView = true
                            }
                        }
                }
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay(
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            )

            if model.showDetailedView, let course = selectedCourse {
                CourseView(course: course, namespace: namespace, show: $model.showDetailedView)
                    .zIndex(1)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                            removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                        )
                    )
            }
        }
        .statusBarHidden(model.showDetailedView)
    }

    private var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollPreferenceKey.self,
                    value: proxy.frame(in: .named("scroll")).minY
                )
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                hasScrolled = (value < 0)
            }
        }
        .frame(height: 0)
    }

    private var featured: some View {
        TabView {
            ForEach(featuredCourses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .rotation3DEffect(
                            .degrees(minX / -15),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX) / 50)
                        .overlay(
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 3)
                        )
                        .padding(.vertical, 40)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
