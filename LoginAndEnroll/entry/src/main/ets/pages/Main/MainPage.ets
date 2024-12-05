import { FooterMain } from './FooterMain';
import { HeaderMain } from './HeaderMain';
import { MiddleMain } from './MiddleMain';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World';

  build () {
    Column () {
      HeaderMain()
      MiddleMain()
      FooterMain()

    }
    .height ('100%')
    .width ('100%')
    .backgroundColor ('#F1F3F5')
  }
}