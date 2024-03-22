import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { Header } from '../component/Header'

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

  label: string = `Parent`

  @Builder componentBuilder() {
    //label名字相同,调用方则使用调用方的label值
    Text(`${this.label}`)
      .fontSize(20)
  }

  pClick: () => void = () => {
    promptAction.showToast({ message: `${this.label} out pass click event` })
  }

  build() {
    Column() {
      Header({ title: 'Page2' })
      Column() {
        this.componentBuilder()
        Child({ passBuilder: this.componentBuilder, cClick: () => {
          promptAction.showToast({ message: `${this.label} out pass click event` })
        } })

        Child({ passBuilder: this.componentBuilder, cClick: this.pClick })

        Button('replace page3')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Page3' });
          })
      }
      .width('100%')
      .height('100%')
      //默认为居中
      // .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
  }
}

@Component
struct Child {
  label: string = `Child`
  //修饰外部传进来的函数是@Builder
  @BuilderParam passBuilder: () => void;
  cClick: () => void;

  build() {
    Column() {
      this.passBuilder()
    }.onClick(this.cClick)
  }
}