// 定义评论数据模型类，用于存储评论相关信息
export class CommentDataModel {
  // 评论者名称，可以是字符串或资源类型
  public name: string | Resource = '';
  // 评论内容，可以是字符串或资源类型
  public comment: string | Resource = '';
}

// 定义直播信息数据模型类，用于存储直播相关信息
export class LiveInfoDataModel {
  // 直播uri，可选字段，可以是字符串或资源类型
  public uri?: string | Resource;
  // 直播名称，可选字段，可以是字符串或资源类型
  public name?: string | Resource;
  // 观看人数，可选字段，可以是字符串或资源类型
  public peopleNum?: string | Resource;
  // 评论列表，可选字段，每个评论是一个CommentDataModel实例
  public commentList?: Array<CommentDataModel>;
}

// 基础数据源类，实现了IDataSource接口
class BasicDataSource implements IDataSource {
  // 存储数据变更监听器的数组
  private listeners: DataChangeListener[] = [];

  // 返回数据总数，此处为示例，总是返回0
  public totalCount(): number {
    return 0;
  }

  // 根据索引获取数据，此处为示例，总是返回空字符串
  public getData(index: number): string {
    return '';
  }

  // 注册数据变更监听器，避免重复注册
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 取消注册数据变更监听器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知所有监听器数据已重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知所有监听器数据已添加
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知所有监听器数据已变更
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }
}

// 自定义数据源类，继承自BasicDataSource
export class MyDataSource extends BasicDataSource {
  // 存储数据的数组
  public dataArray: string[] = [];

  // 构造函数，接受一个CommentDataModel数组或number数组作为参数
  constructor(ele: CommentDataModel[] | number[]) {
    super();
    for (let index = 0;index < ele.length; index++) {
      // 将每个元素转换为字符串后添加到dataArray中
      this.dataArray.push(String(ele[index]));
    }
  }

  // 重写totalCount方法，返回dataArray的长度
  public totalCount(): number {
    return this.dataArray.length;
  }

  // 重写getData方法，根据索引返回dataArray中的数据
  public getData(index: number): string {
    return this.dataArray[index];
  }

  // 在指定索引位置添加数据，并通知数据添加事件
  public addData(index: number, data: string): void {
    // 在dataArray中指定索引位置插入数据
    this.dataArray.splice(index, 0, data);
    // 通知数据添加事件
    this.notifyDataAdd(index);
  }
}
