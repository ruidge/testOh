import hilog from '@ohos.hilog'
import { Header } from '../component/Header'

@Entry
@Component
struct Page3 {
  onPageShow() {
    hilog.warn(1, 'testTag', `Page3 onPageShow `)
  }

  onPageHide() {
    hilog.warn(1, 'testTag', `Page3 onPageHide `)
  }

  onBackPress() {
    hilog.warn(1, 'testTag', `Page3 onBackPress `)
  }

  aboutToAppear() {
    hilog.warn(1, 'testTag', `Page3 aboutToAppear `)
  }

  aboutToDisappear() {
    hilog.warn(1, 'testTag', `Page3 aboutToDisappear `)
  }

  build() {
    Column() {
      Header({ title: 'Page3' })
      Column() {
      }
      .width('100%')
      .height('100%')
    }
  }
}