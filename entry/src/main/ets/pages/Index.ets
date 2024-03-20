@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          // .width('100%')
          // .height('100%')
          // .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Clicked Text '
          })
      }
      .width('100%')
      .onClick(() => {
        this.message = 'Clicked Column '
      })
    }
    .height('100%')
    .onClick(() => {
      this.message = 'Clicked Row '
    })
  }
}