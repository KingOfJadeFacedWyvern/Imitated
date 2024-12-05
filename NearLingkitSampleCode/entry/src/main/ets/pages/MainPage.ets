/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { advertising, scan } from '@kit.NearLinkKit';

/*
                                    代码功能解释
          这段代码实现了一个简单的近场通信（Near Field Communication, NFC）应用的主页面。主要功能包括：
                    广告开关：用户可以通过开关来启动或停止广告广播。
                    设备扫描：用户可以通过“开始扫描”按钮启动设备扫描，并通过“停止扫描”按钮停止扫描。
                    扫描结果显示：扫描到的设备信息会显示在一个列表中，包括设备名称和MAC地址。

                                    详细解释
                  初始化：
                          初始化页面，设置日志标签和域名ID。
                          注册页面信息和状态变量。
                  广告开关：
                          显示一个开关，用户可以打开或关闭广告。
                          开关打开时调用 startAdvertising 方法，启动广告广播。
                          开关关闭时调用 stopAdvertising 方法，停止广告广播。
                  设备扫描：
                          显示“开始扫描”按钮，用户点击后清除扫描结果，注册设备发现回调，并跳转到扫描配置页面。
                          显示“停止扫描”按钮，用户点击后停止扫描并取消注册设备发现回调。
                  扫描结果显示：
                          扫描到的设备信息会显示在一个列表中，包括设备名称和MAC地址。
                          用户可以点击设备名称，触发相应的处理事件。
                  返回键处理：
                          处理返回键事件，记录日志并尝试终止当前页面。
                          如果终止成功，返回上一级页面；如果失败，记录错误日志。

 * */



//在此示例中，advHandle 是一个数字，表示广告 ID
let advHandle: number = 0xFF;
@Component
export struct MainPage {
  logTag: string = 'MainPage';
  domainId: number = 0x0000;
  @Consume('pageInfos') pageInfos: NavPathStack
  // scanResults 是一个数组，用于存储扫描设备的信息
  @State scanResults: Array<scan.ScanResults> = [];

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(15)
      .backgroundColor($r('sys.color.container_modal_unfocus_background'))
      .width('100%')
      .padding(5)
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        Stack() {
          Column() {
            Row() {
              Blank().height('8%')
            }

            //广告开关
            Row() {
              Text('Advertising Switch')
              Blank().width('10%')
              Toggle({
                type: ToggleType.Switch,
                isOn: false
              })
                .selectedColor($r('sys.color.brand'))
                .switchPointColor($r('sys.color.comp_background_list_card'))
                .onChange((isOn: boolean) => {
                  hilog.info(this.domainId, this.logTag, `Component status: ${isOn}`);
                  if (isOn === true) {
                    //在开关打开时开始播报
                    this.startAdvertising(); //TODO
                  } else {
                    // 当开关关闭时停止广告
                    this.stopAdvertising();
                  }
                })
            }

            Row() {
              Blank().height('3%')
            }

            // “开始扫描”按钮
            Row() {
              Button('Start Scan').onClick(() => {
                this.scanResults = []; // 清除扫描结果。
                //应在扫描开始之前注册回调函数。
                this.onDeviceFound();
                this.pageInfos.pushPathByName('ScanConfigPage', null);
              }).width('28%')
            }

            Row() {
              Blank().height('3%')
            }

            // Stop Scan button
            Row() {
              Button('Stop Scan').onClick(() => {
                this.stopScan();
                // 扫描过程完成后，需要取消注册回调函数。
                this.offDeviceFound();
              }).width('28%')
            }

            Row() {
              Blank().height('5%')
            }

            List() {
              ListItem() {
                Row() {
                  Blank().height('5%')
                }
              }

              // 扫描结果列表
              ListItemGroup ({ header: this.itemHead ('Scan Results') }) {
                ForEach (this.scanResults , (item: scan.ScanResults) => {
                  ListItem () {
                    Column () {
                      // 在此示例中，将显示每个扫描设备的设备名称和 MAC 地址。
                      Text (`${item.deviceName}  [${item.address}]`).onClick (() => {
                      })
                    }.width ('100%')
                  }
                } , (item: scan.ScanResults) => item.address)
              }
            }
          }
        }
      }
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      hilog.info(this.domainId, this.logTag, 'MainPage onBackPressed');
      try {
        (getContext() as common.UIAbilityContext).terminateSelf();
      } catch (err) {
        hilog.error(
          this.domainId, this.logTag,
          `Failed to terminateSelf. errCode:
          ${(err as BusinessError).code},
          errMessage: ${(err as BusinessError).message}`
        );
      }
      return true;
    })
  }

  // Stop scan
  stopScan() {
    try {
      scan.stopScan()
        .then(() => {
          hilog.info(this.domainId, this.logTag, 'stop scan success');
        });
    } catch (err) {
      hilog.error(this.domainId, this.logTag,
        `errCode: ${(err as BusinessError).code}, errMessage: ${(err as BusinessError).message}`);
    }
  }

  // 为 device found 事件注册一个回调函数，该函数将一个新的 found 设备添加到 scanResults。
  onDeviceFound() {
    hilog.info(this.domainId, this.logTag, 'onDeviceFound()');
    let scanCallback: (data: Array<scan.ScanResults>) => void = (data: Array<scan.ScanResults>) => {
      // For each new scan result, check if the device is already in existing scan results.
      for (let indexData = 0; indexData < data.length; indexData++) {
        let flag: boolean = false;
        for (let indexResults = 0; indexResults < this.scanResults.length; indexResults++) {
          if (this.scanResults[indexResults].address === data[indexData].address) {
            flag = true;
            break;
          }
        }
        if (!flag) {
          // 仅当找到的设备不在现有扫描结果中时，才将其添加到扫描结果列表。
          this.scanResults.push(data[indexData]);
          hilog.info(this.domainId, this.logTag, `nearlink deviceInfo = ${JSON.stringify(data)}`);
        }
      }
    }
    try {
      scan.on('deviceFound', scanCallback);
    } catch (err) {
      hilog.error(this.domainId, this.logTag,
        `errCode: ${(err as BusinessError).code}, errMessage: ${(err as BusinessError).message}`);
    }
  }

  // 取消注册 device found 事件的回调函数
  offDeviceFound() {
    hilog.debug(this.domainId, this.logTag, 'offDeviceFound()');
    try {
      scan.off('deviceFound');
    } catch (err) {
      hilog.error(this.domainId, this.logTag,
        `errCode: ${(err as BusinessError).code}, errMessage: ${(err as BusinessError).message}`);
    }
  }

  // 开始推广
  startAdvertising() {
    hilog.debug(this.domainId, this.logTag, 'startAdvertising()');
    // 您可以自定义制造数据的数据缓冲区
    let manufactureValueBuffer = new Uint8Array(4);
    manufactureValueBuffer[0] = 1;
    manufactureValueBuffer[1] = 2;
    manufactureValueBuffer[2] = 3;
    manufactureValueBuffer[3] = 4;
    // 您可以自定义服务数据的数据缓冲区
    let serviceValueBuffer = new Uint8Array(4);
    serviceValueBuffer[0] = 5;
    serviceValueBuffer[1] = 6;
    serviceValueBuffer[2] = 7;
    serviceValueBuffer[3] = 8;
    try {
      // 您可以自定义广告设置
      let setting: advertising.AdvertisingSettings = {
        interval: 160,
        power: 2,
      };
      let manufactureDataUnit: advertising.ManufacturerData = {
        manufacturerId: 4567,
        manufacturerData: manufactureValueBuffer.buffer
      };
      let serviceDataUnit: advertising.ServiceData = {
        serviceUuid: '37bea880-fc70-11ea-b720-00000000fdee',
        serviceData: serviceValueBuffer.buffer
      };
      let advData: advertising.AdvertisingData = {
        serviceUuids: ['37bea880-fc70-11ea-b720-00000000fdee'],
        manufacturerData: [manufactureDataUnit],
        serviceData: [serviceDataUnit],
        includeDeviceName : true,
      };
      let advertisingParams: advertising.AdvertisingParams = {
        advertisingSettings: setting,
        advertisingData: advData,
      }
      advertising.startAdvertising(advertisingParams)
        .then((outAdvHandle: number) => {
          advHandle = outAdvHandle;
        });
      hilog.info(this.domainId, this.logTag, 'Start advertising success');
    } catch (err) {
      hilog.error(this.domainId, this.logTag,
        `errCode: ${(err as BusinessError).code}, errMessage: ${(err as BusinessError).message}`);
    }
  }

  //停止广告
  stopAdvertising() {
    hilog.debug(this.domainId, this.logTag, 'stopAdvertising()');
    try {
      advertising.stopAdvertising(advHandle).then(() => {
        hilog.info(this.domainId, this.logTag, 'Stop advertising success');
      });
    } catch (err) {
      hilog.error(this.domainId, this.logTag,
        `errCode: ${(err as BusinessError).code}, errMessage: ${(err as BusinessError).message}`);
    }
  }

}

