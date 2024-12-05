import { router } from "@kit.ArkUI"

@Component
export struct MiddleMain {
  @State user: number = 0;
  @State password: number = 0;
  build () {
    Column () {
      Column () {
        Column ({ space: 3 }) {
          TextInput ({ placeholder: '帐号' })
            .TextInputStyle ()

          // Line ().LineStyle ()


          TextInput ({ placeholder: '密码' })
            .TextInputStyle (InputType.Password)

          Line ().LineStyle ()


        }
        .margin ({ top: 10 })


        Row () {
          Text ('短信验证码登录')
            .fontSize (15)
            .fontColor (Color.Blue)
            .margin ({ left: 10 })
          Blank ()
          Text ('忘记密码')
            .fontSize (15)
            .fontColor (Color.Blue)
            .margin ({ right: 10 })

        }
        .width ('100%')
        .margin ({ top: 20 })

        Column ({ space: 10 }) {
          Button ('登陆').onClick ((event: ClickEvent) => {
            router.pushUrl ({
              url: "pages/Login/LoginPage",
            })
          })
            .width ('80%')
            .margin ({ top: 45 })

          Button ('注册').onClick ((event: ClickEvent) => {
            router.pushUrl ({
              url: "pages/Register/RegisterPage" ,
            })
          })
            .fontSize (20)// .fontWeight(400)
            .fontColor ("#007DFF")
            .backgroundColor (Color.Transparent)
          Text ('其他方式登陆')
            .margin ({ top: 10 })

        }
        .width ('100%')
        .height ('50%')

      }
      .width ('100%')
      .height ('100%')
    }
    .width ('100%')
    .height ('50%')
  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      MiddleMain ()
    }
  }
}

@Extend (Line)
function LineStyle () {
  .width ('100%')
  .height (1)
  .backgroundColor (Color.Gray)
}

@Extend (TextInput)
function TextInputStyle (type?: InputType , bottom?: number) {
  .type (type)
  .width ('100%')
  .height (45)
  .backgroundColor ('#F1F3F5')
  .fontSize (15)
  .maxLength (20)
  .placeholderColor ("#99182431")
  .padding ({ left: 5 })
  .margin ({ bottom })
  .showUnderline (true)
  .underlineColor (Color.Red)

}
