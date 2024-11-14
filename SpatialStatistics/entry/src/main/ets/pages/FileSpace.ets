import { BusinessError } from '@kit.BasicServicesKit';
import { storageStatistics } from '@kit.CoreFileKit';
import { Constants } from '../constants/Constants';
import { SpaceInfo } from '../view/SpaceInfo';
import commonViewModel from '../viewmodel/CommonViewModel';
import Logger from '../utils/Logger';

@Component
struct FileSpace {
  @State appSize: number = 0;
  @State cacheSize: number = 0;
  @State dataSize: number = 0;

  build () {
    NavDestination () {
      Column () {
        Column () {
          Stack () {
            DataPanel ({
              values: [this.appSize, this.cacheSize, this.dataSize] ,
              max: this.appSize + this.cacheSize + this.dataSize ,
              type: DataPanelType.Circle
            })
              .width ($r ('app.integer.data_panel_size'))
              .height ($r ('app.integer.data_panel_size'))
            Text ($r ('app.string.spatial_statistics'))
              .fontSize ($r ('app.integer.data_panel_text_size'))
          }

          Column () {
            SpaceInfo ({ name: $r ('app.string.app_data_size') , value: this.appSize })
            SpaceInfo ({ name: $r ('app.string.cache_file_size') , value: this.cacheSize })
            SpaceInfo ({ name: $r ('app.string.app_total_data_size') , value: this.dataSize })
          }
          .borderRadius ($r ('app.integer.comm_border_radius1'))
          .backgroundColor ($r ('app.color.white_background'))
          .padding ({
            right: $r ('app.integer.comm_padding_margin2') ,
            left: $r ('app.integer.comm_padding_margin2')
          })
        }

        Button ($r ('app.string.file_space_statistics')).onClick ((event: ClickEvent) => {
          storageStatistics.getCurrentBundleStats ().then ((BundleStats: storageStatistics.BundleStats) => {
            this.appSize = BundleStats.appSize
            this.cacheSize = BundleStats.cacheSize
            this.dataSize = BundleStats.dataSize
          }).catch ((error: BusinessError) => {
            Logger.error (`getCurrentBundleStats failed: ${JSON.stringify (error)}`)
          })
        })
      }
      .height (Constants.FULL_PERCENT)
      .justifyContent (FlexAlign.SpaceBetween)
      .padding ({
        bottom: $r ('app.integer.comm_padding_margin3')
      })
      .margin ({
        right: $r ('app.integer.comm_padding_margin3') ,
        left: $r ('app.integer.comm_padding_margin3')
      })
    }
    .title (commonViewModel.getResourceString ($r ('app.string.file_space_statistics')))
    .backgroundColor ($r ('app.color.comm_background1'))
  }
}


@Preview
struct PreviewCode {
  build () {
    Column () {
      FileSpace ()
    }
  }
}











