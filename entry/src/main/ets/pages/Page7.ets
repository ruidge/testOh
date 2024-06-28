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