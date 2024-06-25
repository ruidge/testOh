import hilog from '@ohos.hilog'
import { Article } from '../bean/bean';
import { Header } from '../component/Header'

@Entry
@Component
struct Page3 {
  @State isListReachEnd: boolean = false;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章简介内容'),
    new Article('002', '第2篇文章', '文章简介内容'),
    new Article('003', '第3篇文章', '文章简介内容'),
    new Article('004', '第4篇文章', '文章简介内容'),
    new Article('005', '第5篇文章', '文章简介内容'),
    new Article('006', '第6篇文章', '文章简介内容'),
    new Article('007', '第7篇文章', '文章简介内容'),
    new Article('008', '第8篇文章', '文章简介内容'),
    new Article('009', '第9篇文章', '文章简介内容')
  ]

  loadMoreArticles() {
    this.articleList.push(new Article('100', '加载的新文章', '文章简介内容'));
  }

  build() {
    Column() {
      Header({ title: 'Page4' })
      List() {
        //keyGenerator缺省为index + '__' + JSON.stringify(item)
        //在插入数据场景下,使用缺省会导致插入位置之后重新创建,返回index会导致两次index错乱问题
        ForEach(this.articleList, (item: Article) => {
          ListItem() {
            ArticleCard({ article: item })
              .margin({ top: 10 })
          }
        }, (item: Article) => item.id)
      }
      .onReachEnd(() => {
        this.isListReachEnd = true;
      })
      .parallelGesture(
        PanGesture({ direction: PanDirection.Up, distance: 80 })
          .onActionStart(() => {
            if (this.isListReachEnd) {
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
      )
      .scrollBar(BarState.On)
    }
    .width('100%')
    .height('100%')
  }
}


@Component
struct ArticleCard {
  // @ObjectLink
  article: Article | null = null;

  build() {
    Row() {
      Image($r('app.media.icon'))
        .width(80)
        .height(80)
        .margin({ right: 20 })

      Column() {
        Text(this.article?.title)
          .fontSize(20)
          .margin({ bottom: 8 })
        Text(this.article?.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })
        Text(this.article?.liked + "")
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })
        Text(this.article?.count + "")
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('100%')
    }
    .onClick(() => {
      if (this.article != null) {
        this.article.liked = true
        this.article.count++
      }
    })
    .margin({ left: 20, right: 20 })
    .padding({ left: 20, right: 20 })
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}