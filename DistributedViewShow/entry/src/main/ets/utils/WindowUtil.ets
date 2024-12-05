import { AbilityConstant , common } from "@kit.AbilityKit";
import { window } from "@kit.ArkUI";
import Logger from "./Logger";
import { BusinessError } from "@kit.BasicServicesKit";

const TAG: string = '[WindowUtil]';

export class WindowUtil {
  public static updateStatusBarColor (context: common.BaseContext , isDark: boolean) {
    window.getLastWindow (context).then ((windowClass: window.Window) => {
      try {
        windowClass.setWindowSystemBarProperties ({ statusBarContentColor: isDark ? '#FFFFFF' : '#000000' })
      } catch (exception) {
        Logger.error (TAG , 'updateStatusBarColor failed: ' + JSON.stringify (exception));
      }
    })
  }

  public static requestFullScreen (windowStage: window.WindowStage , context: Context) {
    windowStage.getMainWindow ((error: BusinessError , data: window.Window) => {
      if (error) {
        Logger.error (TAG , 'getMainWindow failed: ' + JSON.stringify (error));
        return;
      }
      let windowClass: window.Window = data;
      Logger.info (TAG , 'getMainWindow success' + JSON.stringify (windowClass));
      let isLayoutFullScreen: boolean = true;
      try {
        let area: window.AvoidArea = windowClass.getWindowAvoidArea (window.AvoidAreaType.TYPE_SYSTEM)
        let naviBarArea: window.AvoidArea =
          windowClass.getWindowAvoidArea (window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        Logger.info (TAG ,
          'Succeeded get the window navigation indicator HEIGHT: ' + px2vp (naviBarArea.bottomRect.height) + ' area: ' +
          JSON.stringify (naviBarArea));
        WindowUtil.getDeviceSize (context , area , naviBarArea)
        if (area.topRect.height > 0) {
          let promise: Promise<void> = windowClass.setWindowLayoutFullScreen (isLayoutFullScreen);
          promise.then (() => {
            Logger.info (TAG , 'Succeeded in setting the window layout to full-screen mode.');

          }).catch ((error: BusinessError) => {
            Logger.error (TAG , 'Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify (error));

          })

        }
      } catch {

      }
    })
  }

  static getDeviceSize (context: Context , area: window.AvoidArea , naviBarArea: window.AvoidArea): void {
    window.getLastWindow (context).then ((data: window.Window) => {
      let properties = data.getWindowProperties ();
      AppStorage.setOrCreate<number> ('statusBarHeight' , px2vp (area.topRect.height));
      AppStorage.setOrCreate<number> ('naviIndicatorHeight' , px2vp (naviBarArea.bottomRect.height));
      AppStorage.setOrCreate<number> ('deviceHeight' , px2vp (properties.windowRect.height));
      AppStorage.setOrCreate<number> ('deviceWidth' , px2vp (properties.windowRect.width));
    })
  }

  static setMainWindowRestricted (context: Context): void {
    window.getLastWindow (context).then ((windowClass: window.Window) => {
      if (windowClass === undefined) {
        Logger.error (`MainWindowClass is undefined`);
        return;
      }
      windowClass.setPreferredOrientation (window.Orientation.AUTO_ROTATION_RESTRICTED)
    })
  }

  static setMainWindowPortrait (context: Context): void {
    window.getLastWindow (context).then ((windowClass: window.Window) => {
      if (windowClass === undefined) {
        Logger.error (`MainWindowClass is undefined`);
        return;
      }
      // Setting restricted display
      windowClass.setPreferredOrientation (window.Orientation.PORTRAIT);
    });
  }
  static setMissionContinueActive(context: common.UIAbilityContext, active: boolean) {
    let activeState = active ? AbilityConstant.ContinueState.ACTIVE : AbilityConstant.ContinueState.INACTIVE;
    context.setMissionContinueState(activeState).then(() => {
      Logger.info('setMissionContinueState success');
    }).catch((err: BusinessError) => {
      Logger.error(`setMissionContinueState failed, code is ${err.code}, message is ${err.message}`);
    });
  }

}
