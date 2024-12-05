import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Constants from '../common/Constants';
import Logger from '../utils/Logger';

@Entry
@Component
struct InputPage {
  @StorageLink ('inputText') inputText: string = '';
  private content = getContext (this) as common.UIAbilityContext

  onPageShow (): void {
    Logger.info (this.inputText);
  }

  build () {
    Row () {
      TextArea ({ text: this.inputText , placeholder: '请输入内容' })
        .fontWeight (Constants.FONT_WEIGHT_MD)
        .fontSize ($r ('app.integer.comm_font_size30'))
        .textAlign (TextAlign.Center)
        .align (Alignment.Center)
        .width (Constants.EIGHTY_PERCENT)
        .onChange ((value: string) => {
          this.inputText = value;
          AppStorage.set ('inputText' , value);
        })
        .backgroundColor (Color.Transparent)
        .outlineColor ($r ('app.color.normal_blue_color'))
        .restoreId (2)
        .id ('inputText')
      Blank ()
      Row () {
        Button (
          $r ('app.string.input_submit') ,
          { type: ButtonType.Capsule , stateEffect: true }
        )
          .height ($r ('app.integer.comm_btn_width'))
          .width ($r ('app.integer.comm_btn_width'))
          .backgroundColor (0x317AFF)
          .borderRadius ($r ('app.integer.normal_component_border_radius'))
          .margin ($r ('app.integer.normal_component_list_margin'))
          .onClick (() => {
            const RESULT_CODE: number = 1001;
            this.content.terminateSelfWithResult (
              {
                resultCode: RESULT_CODE ,

                want: {
                  bundleName: 'com.example.codelab' ,
                  abilityName: 'EntryAbility' ,
                  moduleName: 'entry' ,
                  parameters: {
                    comment: this.inputText
                  }
                }
              } , (err: BusinessError) => {
              Logger.info ('terminateSelfWithResult:' + JSON.stringify (err))
            })
          })
      }
      .margin ({ left: $r ('app.integer.normal_component_list_margin_1') })
    }
    .width (Constants.FULL_PERCENT)
    .height (Constants.FULL_PERCENT)
  }
}