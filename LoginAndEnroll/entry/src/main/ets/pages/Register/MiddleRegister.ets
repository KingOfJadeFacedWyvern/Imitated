import { promptAction , router } from "@kit.ArkUI"

@Component
export struct MiddleRegister {
  @State user: string = '';
  @State password: string = '';
  @State rePassword: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1

  Register (): void {
    if (this.user === '' || this.password === '' || this.rePassword === '') {
      promptAction.showToast ({ message: '请输入完整信息' })
    } else if (this.password !== this.rePassword) {
      promptAction.showToast ({ message: '两次密码不一致' })
    } else {
      this.isShowProgress = true
      this.timeOutId = setTimeout (() => {
        promptAction.showToast ({ message: '注册成功' })
        this.isShowProgress = false
        this.timeOutId = -1
        clearTimeout (this.timeOutId)
        router.pushUrl ({
          url: "pages/Login/LoginPage",
          params: {
            user: this.user,
            password: this.password
          }
        })
      }, 3000)
    }
  }

  build () {
    Column () {
      Column () {
        Column ({ space: 3 }) {
          TextInput ({ placeholder: '帐号' })
            .TextInputStyle ()// Line ().LineStyle ()
            .onChange ((value: string) => {
              this.user = value;
            })


          TextInput ({ placeholder: '密码' })
            .TextInputStyle (InputType.Password)

            .onChange ((value: string) => {
              this.password = value;
            })
          Line ().LineStyle ()

          TextInput ({ placeholder: '确认密码' })
            .TextInputStyle (InputType.Password)
            .onChange ((value: string) => {
              this.rePassword = value;
            })
          Line ().LineStyle ()
        }
        .margin ({ top: 10 })


        Row () {
          Text ('发送短信验证码')
            .fontSize (15)
            .fontColor (Color.Blue)
            .margin ({ left: 10 })
          Blank ()
          Text ('重置密码')
            .fontSize (15)
            .fontColor (Color.Blue)
            .margin ({ right: 10 })
        }
        .width ('100%')
        .margin ({ top: 5 })

        Column ({ space: 10 }) {
          Button ('登陆').onClick ((event: ClickEvent) => {
            promptAction.showToast ({ message: this.user + this.password + this.rePassword })
            // router.pushUrl ({
            //   url: "pages/Login/MainPage",
            // })
          })
            .width ('80%')
            .margin ({ top: 45 })

          Button ('注册').onClick ((event: ClickEvent) => {
            this.Register ()

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
      MiddleRegister ()
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
function TextInputStyle (type?: InputType) {
  .type (type)
  .width ('100%')
  .height (45)
  .backgroundColor ('#F1F3F5')
  .fontSize (15)
  .maxLength (20)
  .placeholderColor ("#99182431")
  .padding ({ left: 5 })
  .showUnderline (true)
  .underlineColor (Color.Red)
}

