import { Header } from '../component/Header';

import { promptAction } from '@kit.ArkUI';

import { WebUtil } from '@ohos/utils';

let storage = new LocalStorage();

let url = 'https://www.baidu.com'

@Entry(storage)
@Component
struct Page6 {
  aboutToAppear(): void {
    WebUtil.createNWeb(url, AppStorage.get("UIContext"))
    WebUtil.setOnPageEndAction(url, () => {
      promptAction.showToast({ message: `加载完成` })
    })
  }

  build() {
    Column() {
      Header({ title: `Page6` })
      Column() {
        NodeContainer(WebUtil.getNWeb(url))
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
    }
  }
}