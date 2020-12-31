//
//  SCCalendarWidget.swift
//  SCCalendarWidget
//
//  Created by iMac on 2020/12/17.
//

import WidgetKit
import SwiftUI
import Intents

// 提供数据和控制数据的刷新
struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), dateSource: YearInfo.readJsonFile()!, configuration: ConfigurationIntent())
    }
    
    // 是在 Widget 库中展示的时候调用的 Widget被添加的时候执行
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), dateSource: YearInfo.readJsonFile()!, configuration: configuration)
        completion(entry)
    }

    // 刷新数据和控制下一步刷新时间
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
        let entry = SimpleEntry(date: currentDate, dateSource: YearInfo.readJsonFile()!, configuration: configuration)
            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// Provider.Entry
struct SimpleEntry: TimelineEntry {
    let sting: String = ""
    let date: Date
    var dateSource: YearInfo
    let configuration: ConfigurationIntent
}

// 实际展示的 view
struct WMMCalendarEntryView : View {
    // 数据提供
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    var dayInfo: YearInfo.DayInfo {
        entry.dateSource.getDayInfoWith(date: entry.date)!
    }
    
    
    var body: some View {
        
        switch family {
        case .systemSmall:// 小
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top) {
                    Text(dayInfo.date)
                        .font(.system(.body))
                        .foregroundColor(Color(hex:0x4C8253))
                    Spacer(minLength: 0)
                    Text(dayInfo.author)
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.white)
                }
                Divider()
                    .background(Color.white)
                Text(dayInfo.title)
                    .font(.system(size: 16, design: .default))
                    .foregroundColor(Color(hex:0xC3A777))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex:0x00615B), Color(hex:0x00615B)]), startPoint: .top, endPoint: .bottom))
        case .systemMedium:// 中
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top) {
                    Text("来自「\(dayInfo.author)」的主题")
                        .font(.system(size: 16, design: .default))
                        .foregroundColor(Color(hex:0xC3A777))
                    Spacer(minLength: 0)
                    Text(dayInfo.date)
                        .font(.system(.body))
                        .foregroundColor(Color(hex:0x4C8253))
                }
                Divider()
                    .background(Color.white)
                Text(dayInfo.title)
                    .foregroundColor(Color.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex:0x00615B), Color(hex:0x00615B)]), startPoint: .top, endPoint: .bottom))
        default://大
            VStack {
                HStack {
                    Text(entry.date, style: .time)
                    Text(entry.date, style: .time)
                }
                HStack {
                    Text(entry.date, style: .time)
                    Text(entry.date, style: .time)
                }
            }
        }
        
        
    }
}

@main
struct WMMCalendar: Widget {
    let kind: String = "WMMCalendar"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WMMCalendarEntryView(entry: entry) // 实际展示的 view
        }
        .configurationDisplayName("生财日历") //是在添加widget时显示的标题
        .description("每天一起成长.") //显示的描述
        .supportedFamilies([.systemSmall,.systemMedium]) // 支持的尺寸
    }
}

struct WMMCalendar_Previews: PreviewProvider {
    static var previews: some View {
        WMMCalendarEntryView(entry: SimpleEntry(date: Date(), dateSource: YearInfo.readJsonFile()!,
                                                configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
//        WMMCalendarEntryView(entry: SimpleEntry(date: Date(), dateSource: YearInfo.readJsonFile()!,
//                                                configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}


extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
