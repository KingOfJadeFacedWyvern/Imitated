

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import Logger from '../utils/Logger';

export default class InputAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    Logger.info('InputAbility onCreate');
  }

  onDestroy(): void {
    Logger.info('InputAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info('InputAbility onWindowStageCreate');

    windowStage.loadContent('pages/InputPage', (err) => {
      if (err.code) {
        Logger.error(JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info('InputAbility onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info('InputAbility onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info('InputAbility onBackground');
  }
}