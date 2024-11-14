@Component
export struct HeaderBar {
  build () {
    Column () {
      Text ('HeaderBar')
        .width ('100%')
        .height (55)
        .fontColor ('rgb(24,36,48)')
        .fontSize (20)
        .fontWeight (500)
        .lineHeight (21)
        .letterSpacing (0)
        .textAlign (TextAlign.Center)



    }
    .width ('100%')
    .zIndex(1)
    .backgroundColor('#F1F3F5')

    .expandSafeArea ([SafeAreaType.KEYBOARD])
    .justifyContent(FlexAlign.Center)
  }
}

