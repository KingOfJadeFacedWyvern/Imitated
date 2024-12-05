@Preview
 struct PreviewCode {
  build () {
    Column () {
      HeaderMain()
    }
  }
}
@Component
export struct HeaderMain {
  build () {
    Column () {
      Column ({space: 12}) {
        Image ($r ('app.media.app_icon'))
          .width (45)
          .aspectRatio (1)
        Text('登陆世界')
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
        Text('登录以获取更多服务哟')
        .fontSize(22)


      }
      .width('100%')
      .height('100%')
      .justifyContent (FlexAlign.Center)
    }
    .width('100%')
    .height('35%')

  }
}