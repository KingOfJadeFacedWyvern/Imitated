import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build () {
    Column () {
      Button ('登陆').onClick ((event: ClickEvent) => {
        router.pushUrl ({
          url:'pages/OnePage'
        })
      })
    }
  }
}