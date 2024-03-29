import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { Header } from '../component/Header'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State hideAuthor: boolean = false

  onPageShow() {
    hilog.warn(1, 'testTag', `Index onPageShow `)
  }

  onPageHide() {
    hilog.warn(1, 'testTag', `Index onPageHide `)
  }

  onBackPress() {
    hilog.warn(1, 'testTag', `Index onBackPress `)
  }

  aboutToAppear() {
    hilog.warn(1, 'testTag', `Index aboutToAppear `)
  }

  aboutToDisappear() {
    hilog.warn(1, 'testTag', `Index aboutToDisappear `)
  }

  @Builder
  doAuthorRender() {
    if (!this.hideAuthor) {
      Text($r('app.string.author'))
        .fontSize(30)
        .stateStyles({
          focused: {
            .backgroundColor(Color.Pink)
          },
          pressed: {
            .backgroundColor(Color.Black)
          },
          normal: {
            .backgroundColor(Color.Red)
          }
        })
        .onClick(() => {
          this.hideAuthor = true
        })
    }
  }

  @Builder
  doContentRender() {
    Text(this.message)
      .fontSize(50)
        // .width('100%')
        // .height('100%')
        // .textAlign(TextAlign.Center)
      .fontWeight(FontWeight.Bold)
        //使用声明的箭头函数，可以直接调用，不需要bind this
      .onClick((event) => {
        this.message = `Clicked Text `
        // promptAction.showToast({ message: `x:${event.x},y:${event.y}` })
        promptAction.showDialog({ message: `x:${event.x},y:${event.y}` }).then(() => {
          promptAction.showToast({ message: `showDialog then ` })
        })
      })
  }

  build() {
    Column() {
      Header({ title: 'home', showBack: false })
      Row() {
        Column() {
          this.doAuthorRender()
          LineDivider({ color: Color.Blue, lHeight: 2 })
          Row() {
            this.doContentRender()
          }

          Button('push to page2')
            .onClick(() => {
              router.pushUrl({ url: 'pages/Page2' });
            })
            .margin({ top: 10 })
          Button('push to page3')
            .onClick(() => {
              router.pushUrl({ url: 'pages/Page3' });
            })
            .margin({ top: 10 })
          Button('push to page4')
            .onClick(() => {
              router.pushUrl({ url: 'pages/Page4' });
            })
            .margin({ top: 10 })
        }
        .width('100%')
        //默认为居中
        .alignItems(HorizontalAlign.Center)
        //使用匿名函数表达式配置组件的事件方法，要求使用bind，以确保函数体中的this指向当前组件
        .onClick(function(event){
          this.message = 'Clicked Column '
        }.bind(this))
      }
      //默认为居中
      // .alignItems(VerticalAlign.Bottom)
      .height('100%')
      //使用组件的成员函数配置组件的事件方法,
      //clickRowCallback里面使用了this,所以需要bind,如果用不到,则不需要bind
      .onClick(this.clickRowCallback.bind(this))

    }
  }

  clickRowCallback(): void {
    // this.message = 'Clicked Row '
    promptAction.showToast({ message: `Clicked Row ` })
  }
}

@Component
struct LineDivider {
  private color: ResourceColor = Color.Transparent
  private lHeight: Length = 0

  build() {
    Divider()
      .margin({ left: 20, right: 20 })
      .height(this.lHeight)
      .backgroundColor(this.color)
  }

  onPageShow() {
    //执行不到,只有@Entry回回调此方法
    hilog.warn(1, 'testTag', `LineDivider aboutToAppear `)
  }

  aboutToAppear() {
    hilog.warn(1, 'testTag', `LineDivider aboutToAppear `)
  }

  aboutToDisappear() {
    hilog.warn(1, 'testTag', `LineDivider aboutToDisappear `)
  }
}