
import { Constants } from '../constants/Constants';

@Component
export struct SpaceInfo {
  @Prop name: ResourceStr;
  @Prop value: number;

  build() {
    Row() {
      Text(this.name)//todo
        .fontColor($r('app.color.comm_font_color1'))//todo
      Text(this.value + Constants.BYTE_UNIT)
        .fontColor($r('app.color.comm_font_color2'))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(Constants.FULL_PERCENT)
    .height($r('app.integer.card_height'))
  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      SpaceInfo()
    }
  }
}