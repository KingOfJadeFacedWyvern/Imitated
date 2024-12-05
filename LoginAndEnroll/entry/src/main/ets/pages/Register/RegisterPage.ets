import { FooterRegister } from './FooterRegister';
import { HeaderRegister } from './HeaderRegister';
import { MiddleRegister } from './MiddleRegister';

@Entry
@Component
struct RegisterPage {
  @State message: string = 'Hello World';

  build () {
    Column () {
      HeaderRegister()
      MiddleRegister()
      FooterRegister()

    }
    .width ('100%')
    .height ('100%')
    .backgroundColor ('#F1F3F5')
  }
}