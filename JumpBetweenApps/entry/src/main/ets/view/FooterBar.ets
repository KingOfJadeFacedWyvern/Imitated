
@Component
struct FooterBar {
  build () {
    Row () {
      Image ($r ('app.media.emoji'))
        .width (24)
        .aspectRatio (1)
      TextInput ()
        .layoutWeight (1)
        .margin ({ left: 10 , right: 10 })
      Image ($r ('app.media.ic_plus'))
        .width (24)
        .aspectRatio (1)
    }
    .width ('100%')
    .height (60)
    .padding ({ left: 16 , right: 16 })
    .backgroundColor (Color.White)

  }
}

// @Preview
// struct PreviewCode {
//   build () {
//     Column () {
//       FooterBar ()
//     }
//   }
// }