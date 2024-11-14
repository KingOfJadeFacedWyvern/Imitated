import { common } from "@kit.AbilityKit";
import { Message } from "../viewmodel/MessageViewModel";

@Builder
function EmptyBuilder() {}
@Component
export struct MessageItem {
  @Prop message: Message;
  @BuilderParam contentBuilder: () => void = EmptyBuilder;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  build () {
    Row () {
      Image ($r ('app.media.DefaultAvatar'))
        .width (45)
        .aspectRatio (1)
        .borderRadius(20)
        .margin ({ right: 8 })
      Row () {
        this.contentBuilder()
      }
        .constraintSize({maxWidth: 210})
      .borderRadius({
        topLeft: 2,
        topRight:24,
        bottomLeft:24,
        bottomRight: 24
      })
      .backgroundColor (Color.White)
       .onClick(() =>this.message.getCallBack() &&this.message.getCallBack()(this.context) )
    }
    .justifyContent (FlexAlign.Start)
    .alignItems(VerticalAlign.Bottom)

  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      MessageItem()
    }
  }
}
