import promptAction from '@ohos.promptAction';
import { Header } from '../component/Header';


class PropB {
  code: number;

  constructor(code: number) {
    this.code = code;
  }
}

@Entry()
@Component
struct Page5 {
  @State num3: number = 100

  @Builder
  childBuilder() {
    Button(`childBuilder`)
  }

  build() {
    Column() {
      Header({ title: 'Page5' })
      Column() {
        Child({
          passBuilder: this.childBuilder, cClick: () => {
            promptAction.showToast({ message: `child click` })
          }
        })
          .margin({ bottom: 10 })

        ChildLink()
        ChildProp()
      }
      .width('100%')
      .height('100%')
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


@Component
struct ChildLink {
  build() {
    Column() {
    }
  }
}

@Component
struct ChildProp {
  build() {
    Column() {
    }
  }
}