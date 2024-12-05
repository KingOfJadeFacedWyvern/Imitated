@Preview
struct PreviewCode {
  build () {
    Column () {
      FooterMain()
    }
  }
}
@Component
export struct FooterMain {
  build () {
    Column () {
      Row () {
        Text ('方式一')
          .TextStyle ()
        Text('方式二')
          .TextStyle ()

        Text('方式三')
          .TextStyle ()


      }
      .width('100%')
      .height('100%')
      .justifyContent (FlexAlign.SpaceAround)
      .margin ({ top: 25})
    }
    .width('100%')
    .height('10%')
  }
}

@Extend (Text)
function TextStyle () {
  .width (65)
  .height (65)
  .borderRadius (400)
  .border ({ width: 1 , color: Color.Blue })
  .textAlign (TextAlign.Center)
  .borderColor ('#99182431')
}
