

import Logger from '../utils/Logger';


export class CommonViewModel {
  getResourceString(resource: Resource): string {
    let resourceString: string = '';
    try {
      /*
        代码解释
        这段代码的功能是从资源管理器中获取指定资源ID的字符串。
        getContext(this)：获取当前上下文对象。
        resourceManager：从上下文中获取资源管理器对象。
        getStringSync(resource.id)：同步获取指定资源ID的字符串。
        */
      resourceString = getContext(this).resourceManager.getStringSync(resource.id);
    } catch (error) {
      Logger.error(`getResourceString err: ${JSON.stringify(error)}`);
    }
    return resourceString;
  }
}

export default new CommonViewModel();