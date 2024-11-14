import { common } from "@kit.AbilityKit";
import { pullUpSystemSetting } from "../viewmodel/MessageViewModel";

@Component
export struct WarningBox {
  private context: common.UIAbilityContext = getContext (this) as common.UIAbilityContext;

  build () {
    Row () {
      Image ($r ('app.media.warning'))
        .width (20)
        .aspectRatio (1)
        .margin ({ left: 2 , right: 8.5 })
      Text ($r ('app.string.no_network'))
        .fontColor ('#E84026')
        .fontSize (16)
        .fontWeight (500)
        .lineHeight (20)
        .letterSpacing (0)
        .textAlign (TextAlign.Start)
        .width('80%')
        .maxLines(1)
        .textOverflow({overflow: TextOverflow.Ellipsis})
    }
    .borderRadius(16)
    .backgroundColor('#FCE3DF')
    .size({ width: 'calc(100% - 24vp)', height: 48})
    .justifyContent(FlexAlign.Center)
     .onClick(() => {
       pullUpSystemSetting(this.context)

     })
  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      WarningBox ()
    }
  }
}