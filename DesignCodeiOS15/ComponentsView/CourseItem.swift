//
//  CourseItem.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-28.
//

import SwiftUI

struct CourseItem: View {
    let course: Course
    let namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Spacer()
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
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur_\(course.id)", in: namespace)
            )
        }
        .foregroundColor(.white)
        .background(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image_\(course.id)", in: namespace)
        )
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background_\(course.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask_\(course.id)", in: namespace)
        )
        .frame(height: 300)
        .padding(20)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItem(course: courses[0], namespace: namespace)
    }
}
