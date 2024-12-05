import { mediaquery } from '@kit.ArkUI';
import { distributedDeviceManager } from '@kit.DistributedServiceKit';
import { common , Want } from '@kit.AbilityKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { CommentDataModel , LiveInfoDataModel } from '../model/LiveDataModel'
import { LiveData } from '../model/LiveData';
import Constants from '../common/Constants';
import Logger from '../utils/Logger';

function getRemoteDeviceId () {
  let dmClass = distributedDeviceManager.createDeviceManager ('com.example.codelab');
  if (typeof dmClass === 'object' && dmClass !== null) {
    let list = dmClass.getAvailableDeviceListSync ();
    if (typeof (list) === 'undefined' || typeof (list.length) === 'undefined') {
      Logger.error ('getRemoteDeviceId err: list is null');
      return;
    }
    if (list.length === 0) {
      Logger.error ('getRemoteDeviceId err: list.length===0');
      return;
    }
    Logger.info (list[0].networkId as string)
    return list[0].networkId;
  } else {
    Logger.error ('getRemoteDeviceId err: dmClass is null');
    return;
  }
}

@Component
export struct CommentPage {
  @State comments: Array<LiveInfoDataModel> = LiveData
  @State text: string = ''
  @State isPhone: boolean = false
  @State @Watch ("onLiveListUpdated") liveList: Array<CommentDataModel> = [];
  @Link @Watch ('onActiveUpdated') active: number;
  scroller: Scroller = new Scroller ();
  listenerIsPhone = mediaquery.matchMediaSync ('(orientation:landscape)');
  private content = getContext (this) as common.UIAbilityContext;

  onPortrait (mediaQueryResult: mediaquery.MediaQueryResult) {
    this.isPhone = !mediaQueryResult.matches;
  }

  onActiveUpdated (): void {
    this.updateCommentList ();
  }

  onLiveListUpdated (): void {
    let i = 0;
    let intervalID = setInterval (() => {
      i++;
      this.scroller.scrollPage ({ next: true })
      if (i === this.liveList?.length) {
        clearInterval (intervalID);
      }
    } , 1000)
  }

  updateCommentList () {
    let i = 0;
    let intervalID = setInterval (() => {
      this.liveList.push (this.comments[0].commentList![i++])
      if (i === this.comments[0].commentList?.length) {
        clearInterval (intervalID);
      }
    } , 1000)
  }

  aboutToAppear (): void {
    this.listenerIsPhone.on ('change' , (result: mediaquery.MediaQueryResult) => {
      this.onPortrait (result);
    });
    Logger.info (deviceInfo.deviceType)
    this.updateCommentList ()
  }

  build () {
    Column () {
      Column () {
        List ({ space: Constants.SPACE_SIX , initialIndex: 0 , scroller: this.scroller }) {
          ForEach (this.liveList , (item: CommentDataModel) => {
            ListItem () {
              Text () {
                Span (item.name)
                  .fontSize ($r ('app.integer.comm_font_size12'))
                  .fontColor ($r ('app.color.start_window_background'))
                Span (':')
                  .fontSize ($r ('app.integer.comm_font_size12'))
                  .fontColor ($r ('app.color.start_window_background'))
                Span (item.comment)
                  .fontSize ($r ('app.integer.comm_font_size12'))
                  .fontColor ($r ('app.color.start_window_background'))
              }
              .padding ({
                left: $r ('app.integer.normal_component_list_padding1') ,
                top: $r ('app.integer.normal_component_list_padding') ,
                right: $r ('app.integer.normal_component_list_padding1') ,
                bottom: $r ('app.integer.normal_component_list_padding')
              })
              .borderRadius ($r ('app.integer.normal_component_border_radius1'))
              .backgroundColor ($r ('app.color.normal_background_color'))
            }
          } , (item: CommentDataModel) => JSON.stringify (item))
        }
        .width (Constants.FULL_PERCENT)
        .height (Constants.FULL_PERCENT)
      }
      .width (Constants.SIXTY_PERCENT)
      .height ($r ('app.integer.comm_height2'))
      .alignItems (HorizontalAlign.Start)
      .margin ({ bottom: $r ('app.integer.normal_component_list_margin_2') })

      Row () {
        TextInput ({ placeholder: $r ('app.string.talk_something') , text: this.text })
          .backgroundColor ($r ('app.color.normal_background_color'))
          .placeholderColor ($r ('app.color.placeholderColor_background'))
          .padding ({ left: $r ('app.integer.normal_component_list_padding3')})
          .fontSize($r ('app.integer.comm_font_size20'))
          .width(deviceInfo.deviceType !== 'phone' ? Constants.EIGHTY_PERCENT : Constants.FULL_PERCENT)
          .height($r('app.integer.comm_btn_height3'))
          .borderRadius($r('app.integer.normal_component_border_radius3'))
          .onChange ((value: string) => {
            this.text = value
          })
          .onSubmit(()=>{
            this.liveList.push({name:$r('app.string.first_five_name'),comment:this.text})
            this.text = ''
          })
        Blank()
        Button($r('app.string.iPhone_input'),{ type: ButtonType.Normal, stateEffect: true })
          .width($r('app.integer.comm_btn_width1'))
          .height($r('app.integer.comm_btn_height4'))
          .borderRadius($r('app.integer.normal_component_border_radius3'))
          .backgroundColor($r('app.color.normal_blue_color'))
          .visibility(deviceInfo.deviceType!=='phone'?Visibility.Visible:Visibility.None)
         .onClick(() => {
             let want: Want = {
               deviceId: getRemoteDeviceId(),
               bundleName: 'com.example.codelab',
               abilityName: 'InputAbility',
             };
             const RESULT_CODE: number = Constants.REQUEST_CODE;
             this.content.startAbilityForResult(want).then ((data)=>{
               if (data?.resultCode===RESULT_CODE) {
                 let comment=data.want?.parameters?.comment;
                 if (comment !== null) {
                   this.liveList.push({name:$r('app.string.first_five_name'),comment:comment!.toString()})
                 }
               }
             }).catch((error:Error)=>{
               Logger.error(JSON.stringify(error));
             })
         })
      }
       .width(Constants.FULL_PERCENT)
      .padding({
        top: $r('app.integer.normal_component_list_padding2'),
        bottom: $r('app.integer.normal_component_list_padding2')
      })
      .justifyContent(FlexAlign.Start)
      .margin({ top: $r('app.integer.normal_component_list_margin_1') })
    }
    .alignItems(HorizontalAlign.Start)
    .width(Constants.FULL_PERCENT)
    .height($r('app.integer.comm_height1'))
  }
}

