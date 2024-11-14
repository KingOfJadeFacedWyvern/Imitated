import { fileIo as fs, ReadOptions, statfs } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import { Constants } from '../constants/Constants';
import { SpaceInfo } from '../view/SpaceInfo';
import commonViewModel from '../viewmodel/CommonViewModel';
import Logger from '../utils/Logger';

@Component
struct AppSpatial {
  @State freeSize: number = 0;
  @State totalSize: number = 0;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private path=this.context.filesDir

  aboutToAppear(): void {

  }
  /*
                                  代码解释
       这段代码的功能是创建并写入一个缓存文件，然后读取该文件的内容并输出。具体步骤如下：
              生成文件路径：根据 this.path 和常量 Constants.FILE_PATH_NAME 拼接生成文件路径。
              打开文件：使用 fs.openSync 打开文件，如果文件不存在则创建文件，模式为读写。
              写入数据：使用 fs.writeSync 将常量 Constants.WRITE_CONTENT 写入文件，并记录写入的字节数。
              读取数据：创建一个 ArrayBuffer，设置读取选项，使用 fs.readSync 从文件中读取数据。
              输出内容：将读取的数据转换为字符串并输出。
              关闭文件：使用 fs.closeSync 关闭文件。
* */
  createCacheFile(): void {
    let filePath=this.path+Constants.FILE_PATH_NAME;
    let file=fs.openSync(filePath,fs.OpenMode.READ_WRITE|fs.OpenMode.CREATE)
    let writeLength=fs.writeSync(file.fd,Constants.WRITE_CONTENT)
    Logger.info(`Write data to file succeed and size is: ${writeLength}`)
    let arrayBuffer=new ArrayBuffer(4096)
    let readOptions:ReadOptions = {
      offset: 0,
      length: arrayBuffer.byteLength,
    }
    let readLength=fs.readSync(file.fd,arrayBuffer,readOptions)
    let buf=buffer.from(arrayBuffer,0,readLength)
    Logger.info(`The content of file: ${buf.toString()}`);
    fs.closeSync(file)
  }
  build () {
    NavDestination() {
      Column () {
        Column () {
          Stack() {
            DataPanel({
              values: [this.freeSize, this.totalSize],
              max:this.freeSize+this.totalSize,
              type:DataPanelType.Circle
            })
              .width($r('app.integer.data_panel_size'))
              .height($r('app.integer.data_panel_size'))
            Text($r('app.string.spatial_statistics'))
              .fontSize($r('app.integer.data_panel_text_size'))
          }

          Column () {
            SpaceInfo({name:$r('app.string.free_bytes'),value:this.freeSize})
            SpaceInfo({name:$r('app.string.total_bytes'),value:this.totalSize})
          }
          .borderRadius($r('app.integer.comm_border_radius1'))
          .backgroundColor($r('app.color.white_background'))
          .padding({
            right: $r('app.integer.comm_padding_margin2'),
            left: $r('app.integer.comm_padding_margin2')
          })
        }

        Button ($r ('app.string.app_space_statistics')).onClick ((event: ClickEvent) => {
                  this.freeSize=statfs.getFreeSizeSync(this.path)
                  this.totalSize=statfs.getFreeSizeSync(this.path)
        })
      }
      .height(Constants.FULL_PERCENT)
      .justifyContent (FlexAlign.SpaceBetween)
      .padding({
        bottom: $r('app.integer.comm_padding_margin3')

      })

    }
    .title(commonViewModel.getResourceString($r('app.string.app_space_statistics')))
    .backgroundColor($r('app.color.comm_background1'))

  }
}

@Preview
struct PreviewCode {
  build () {
    Column () {
      AppSpatial()
    }
  }
}