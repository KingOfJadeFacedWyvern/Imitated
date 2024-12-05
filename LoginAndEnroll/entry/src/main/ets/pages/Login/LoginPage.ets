import { router } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State message: string = 'Hello World';

  build () {
    Column () {
      Button ('返回').onClick ((event: ClickEvent) => {
        router.back ()
      })
    }
    .height ('100%')
    .width ('100%')
  }
}