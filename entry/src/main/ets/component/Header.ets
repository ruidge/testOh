import router from '@ohos.router'

@Component
export struct Header {
  @State showBack: boolean = true
  private hHeight: Length = 50
  private title: string | Resource = ''
  private funBack: () => void = () => {
    router.back()
  }

  build() {
    Stack() {
      Row() {
        Text(this.title)
          .fontWeight(FontWeight.Bold)
          .fontSize(30)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)

      if (this.showBack) {
        Image($r('app.media.common_ic_nav_btn_back_black'))
          .width(this.hHeight)
          .height(this.hHeight)
          .onClick(this.funBack.bind(this))
      }
    }
    .width('100%')
    .height(this.hHeight)
    .alignContent(Alignment.TopStart)
  }
}