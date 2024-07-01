import { KVStore } from '@ohos/utils';
import { PreferenceManager } from '@ohos/utils';
import { promptAction } from '@kit.ArkUI';

@Builder
function MyBuilder(value: string, size: number) {
  Text(value)
    .fontSize(size)
}

let globalBuilder: WrappedBuilder<[string, number]> = wrapBuilder(MyBuilder);


@Entry()
@Component
struct Page7 {
  @State message: string = 'Hello';
  @State text1: string = '';
  @State text2: string = '';

  aboutToAppear(): void {
    PreferenceManager.getInstance().getValue<string>("text1").then((value) => {
      this.text1 = value ?? ""
    })

    KVStore.getInstance().getValue<string>("text2").then((value) => {
      this.text2 = value ?? ""
    })
  }

  @Styles
  styleRed() {
    .backgroundColor(Color.Red)
  }

  @Styles
  normalStyle() {
    .backgroundColor(Color.Gray)
  }

  @Styles
  pressedStyle() {
    .backgroundColor(Color.Red)
  }

  build() {
    Row() {
      Column() {
        globalBuilder.builder(this.message, 20)
        MyBuilder(this.message, 30)

        Text('text1')
          .styleRed()
        Text('text2')
          .styleBlue()
        Text('text3')
          .fancyText(1, Color.Brown)
          .stateStyles({
            normal: this.normalStyle,
            pressed: this.pressedStyle,
          })
          .margin({ bottom: 30 })

        TextInput({ text: $$this.text1, placeholder: 'text1' })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .caretColor(Color.Blue)
          .width(300)
          .margin({ bottom: 10 })

        Button('save text1 to preference').onClick(() => {
          PreferenceManager.getInstance().setValue<string>("text1", this.text1).then(() => {
            promptAction.showToast({ message: 'save text1 to preference' })
          })
        }).margin({ bottom: 30 })

        TextInput({ text: $$this.text2, placeholder: 'text2' })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .caretColor(Color.Blue)
          .width(300)
          .margin({ bottom: 10 })
        Button('save text2 to kv').onClick(() => {
          KVStore.getInstance().setValue<string>("text2", this.text2).then(() => {
            promptAction.showToast({ message: 'saved text2 to kv' })
          })
        }).margin({ bottom: 30 })

      }
      .width('100%')
    }
    .height('100%')
  }
}

@Styles
function styleBlue() {
  .backgroundColor(Color.Blue)
}

@Extend(Text)
function fancyText(weightValue: number, color: Color) {
  .fontStyle(FontStyle.Italic)
  .fontWeight(weightValue)
  .backgroundColor(color)
}