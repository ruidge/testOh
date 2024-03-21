import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'
import router from '@ohos.router'

@Entry
@Component
struct Page2 {
  onPageShow() {
    hilog.warn(1, 'testTag', `Page2 onPageShow `)
  }

  onPageHide() {
    hilog.warn(1, 'testTag', `Page2 onPageHide `)
  }

  onBackPress() {
    hilog.warn(1, 'testTag', `Page2 onBackPress `)
  }

  aboutToAppear() {
    hilog.warn(1, 'testTag', `Page2 aboutToAppear `)
  }

  aboutToDisappear() {
    hilog.warn(1, 'testTag', `Page2 aboutToDisappear `)
  }

  @Builder
  doAuthorRender() {
  }

  build() {
    Row() {
      Column() {
        Text('Page2')
          .fontSize(50)
          .align(Alignment.Top)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
          })
        Button('back to hello page')
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      //默认为居中
      .alignItems(HorizontalAlign.Center)
    }
    .height('100%')
  }
}