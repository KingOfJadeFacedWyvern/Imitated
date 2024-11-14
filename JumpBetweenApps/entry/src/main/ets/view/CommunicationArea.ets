import { Message , MessageViewModel } from "../viewmodel/MessageViewModel"
import { MessageItem } from "./MessageItem"

@Builder
function AppGalleryShareBox () {
  Row () {
    Column () {
      Text ($r ('app.string.huawei_reader'))
        .fontColor (Color.Black)
        .fontFamily ('思源黑体')
        .fontSize (15)
        .fontWeight (500)
        .lineHeight (20)
        .letterSpacing (0)
        .textAlign (TextAlign.Start)
        .margin ({ bottom: 8 })
        .maxLines (1)
        .textOverflow ({ overflow: TextOverflow.Ellipsis })
      Text ($r ('app.string.read_des'))
        .fontColor ('rgba(0,0,0,0.6)')
        .fontFamily ('思源黑体')
        .fontSize (13)
        .fontWeight (400)
        .lineHeight (20)
        .letterSpacing (0)
        .textAlign (TextAlign.Start)
        .maxLines (3)
        .maxLines (1)
        .textOverflow ({ overflow: TextOverflow.Ellipsis })

    }
    .height (92)
    .justifyContent (FlexAlign.Start)
    .alignItems (HorizontalAlign.Center)
    .margin ({ right: 16 })
    .layoutWeight (1)

    Image ($r ('app.media.hwread'))
      .width (93)
      .aspectRatio (1)
      .borderRadius (12)

  }
  .width (210)
  .height (116)
  .padding ({
    top: 12 ,
    left: 11 ,
    bottom: 12 ,
    right: 10
  })

}

@Builder
function NavigationMessageBox () {
  Stack () {
    Image ($r ('app.media.map'))
      .width (190)
      .aspectRatio (1)
      .borderRadius (24)
      .objectFit (ImageFit.Contain)
    Image ($r ('app.media.position_cursor'))
      .width (35)
      .aspectRatio (1)
  }
  .width (190)
  .height (190)
}

@Builder
function GoodsBox () {
  Column () {
    Text ($r ('app.string.goods_detail'))
      .fontColor (Color.Black)
      .fontFamily ('思源黑体')
      .fontSize (12)
      .fontWeight (FontWeight.Bold)
      .lineHeight (20)
      .letterSpacing (0)
      .textAlign (TextAlign.Start)
    Row () {
      Text ($r ('app.string.goods_name'))
        .layoutWeight (1)
        .fontColor ('rgba(0,0,0,0.6)')
        .fontFamily ('思源黑体')
        .fontSize (12)
        .fontWeight (FontWeight.Bold)
        .lineHeight (20)
        .letterSpacing (0)
        .textAlign (TextAlign.Start)
      Image ($r ('app.media.goods'))
        .width (61)
        .aspectRatio (1)

    }
    .justifyContent (FlexAlign.SpaceBetween)
    .alignItems (VerticalAlign.Bottom)
  }
  .width (210)
  .height (116)
  .padding ({
    left: 11 ,
    top: 7 ,
    right: 14 ,
    bottom: 16
  })
}

@Component
export default struct CommunicationArea {
  @State messages: Message[] = new MessageViewModel ().getMessages()
  private contentBuilders: Map<string , () => void> = new Map ()

  aboutToAppear (): void {
    this.contentBuilders.set ('001' , AppGalleryShareBox);
    this.contentBuilders.set ('002' , NavigationMessageBox);
    this.contentBuilders.set ('003' , GoodsBox);
  }

  build () {
    Column () {
      List () {
        ForEach (this.messages , (message: Message , index: number) => {
          if (this.contentBuilders.has (message.getId ())) {
            MessageItem ({ message , contentBuilder: this.contentBuilders.get (message.getId ()) })
          } else {
            MessageItem ({ message })
          }
        } , (message: Message) => message.getId ())
      }
      .width ('100%')
      .height ('100%')
      .padding ({ left: 12 , top: 124 })
      .edgeEffect (EdgeEffect.Spring)
    }
    .width ('100%')
    .height ('100%')
    .backgroundColor ('#F1F3F5')
  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      CommunicationArea ()
    }
  }
}