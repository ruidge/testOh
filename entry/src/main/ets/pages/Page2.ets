import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { Header } from '../component/Header'

@Entry
@Component
struct Page2 {
  @State num1: number = 10
  @Provide num2: number = 100

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

  @Builder
  componentBuilder() {
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
        Child({
          passBuilder: this.componentBuilder, cClick: () => {
            promptAction.showToast({ message: `${this.label} out pass click event` })
          }
        })

        Child({ passBuilder: this.componentBuilder, cClick: this.pClick })

        Button('replace page3')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Page3' });
          })

        Button(`${this.num1} num1++`)
          .onClick(() => {
            this.num1++
          })

        Button(`${this.num2} num2++`)
          .onClick(() => {
            this.num2++
          })

        ChildState({ num: this.num1 })
        ChildProp({ num: this.num1 })
        ChildLink({ num: this.num1 })
        ChildConsume()
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
  cClick: (() => void) | null = null;

  build() {
    Column() {
      this.passBuilder()
    }.onClick(this.cClick)
  }
}

//@State修饰的父组件传入后,父组件修改不会同步到子组件,子组件的修改也不会同步父组件.
@Component
struct ChildState {
  @State num: number = 0

  build() {
    Button(`ChildState ${this.num}`)
      .onClick(() => {
        this.num++
      })
  }
}

//@Prop修饰的父组件传入后,父组件修改会同步到子组件,子组件的修改不会同步父组件.父->子
@Component
struct ChildProp {
  @Prop num: number

  build() {
    Button(`ChildProp ${this.num}`)
      .onClick(() => {
        this.num++
      })
  }
}

//@Link修饰的父组件传入后,父组件修改会同步到子组件,子组件的修改也会同步父组件.父<->子
@Component
struct ChildLink {
  @Link num: number

  build() {
    Button(`ChildLink ${this.num}`)
      .onClick(() => {
        this.num++
      })
  }
}

//@Consume修饰的与父组件@Provide修饰的名字需相同,无需传入,双向同步.父<->子
@Component
struct ChildConsume {
  @Consume num2: number

  build() {
    Button(`ChildConsume ${this.num2}`)
      .onClick(() => {
        this.num2++
      })
  }
}