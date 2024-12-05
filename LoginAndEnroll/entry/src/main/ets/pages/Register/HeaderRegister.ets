@Preview
 struct PreviewCode {
  build () {
    Column () {
      HeaderRegister()
    }
  }
}
@Component
export struct HeaderRegister {
  build () {
    Column () {
      Column ({space: 12}) {
        Image ($r ('app.media.app_icon'))
          .width (45)
          .aspectRatio (1)
        Text('注册世界')
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
        Text('注册以登陆的')
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