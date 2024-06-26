import promptAction from '@ohos.promptAction';
import { Header } from '../component/Header';
import { PropB } from './Page4';
import { JSON } from '@kit.ArkTS';


AppStorage.setOrCreate('PropA', 47);
AppStorage.setOrCreate('PropB', new PropB(50));
let storage = new LocalStorage();
storage.setOrCreate('PropA', 48);
storage.setOrCreate('PropB', new PropB(100));


class LogTrack {
  @Track str1: string;
  @Track str2: string;

  constructor(str1: string) {
    this.str1 = str1;
    this.str2 = 'World';
  }
}

class LogNotTrack {
  str1: string;
  str2: string;

  constructor(str1: string) {
    this.str1 = str1;
    this.str2 = '世界';
  }
}

@Entry(storage)
@Component
struct Page5 {
  scroller = new Scroller()
  @State @Watch('num3Changed') num3: number = 100
  @State num4: number = 0
  //
  @StorageLink('PropA') storageLink: number = 1;
  @LocalStorageLink('PropA') localStorageLink: number = 1;
  @StorageLink('PropB') storageLinkObject: PropB = new PropB(1);
  @LocalStorageLink('PropB') localStorageLinkObject: PropB = new PropB(1);
  @StorageLink("map") message: Map<number, string> = new Map([[0, "a"], [1, "b"], [3, "c"]]);
  //
  @State text: string = '1'
  controller: TextInputController = new TextInputController()
  //
  @State logTrack: LogTrack = new LogTrack('Hello');
  @State logNotTrack: LogNotTrack = new LogNotTrack('你好');
  @State log: Log = new Log('origin info.');

  @Builder
  childBuilder() {
    Button(`childBuilder num3:${this.num3}`)
  }

  //该方法不在build中,通过@Watch也可以监听num3的变化
  num3Changed(num: number) {
    promptAction.showToast({ message: `num:${num};num3:${this.num3}` })
    this.num4 = this.num3 + 100
  }

  build() {
    Column() {
      Header({ title: 'Page5' })
      Scroll(this.scroller) {
        Column() {
          Text(`num3:${this.num3};num4:${this.num4}`)
          Child({
            passBuilder: this.childBuilder, cClick: () => {
              this.num3++
            }
          })
            .margin({ bottom: 10 })
          Button(`From AppStorage ${this.storageLink}`)
            .onClick(() => {
              this.storageLink += 1;
            })

          Button(`From LocalStorage ${this.localStorageLink}`)
            .onClick(() => {
              this.localStorageLink += 1;
            })

          Button(`From AppStorage ${this.storageLinkObject.code}`)
            .onClick(() => {
              this.storageLinkObject.code += 1;
            })

          Button(`From LocalStorage ${this.localStorageLinkObject.code}`)
            .onClick(() => {
              this.localStorageLinkObject.code += 1;
            })
            .margin({ bottom: 10 })

          ForEach(Array.from(this.message.entries()), (item: [number, string]) => {
            Text(`${item[0]}`).fontSize(20)
            Text(`${item[1]}`).fontSize(20)
            Divider()
          })
          Button('init map').onClick(() => {
            this.message = new Map([[0, "a"], [1, "b"], [3, "c"]]);
          })
          Button('set new one').onClick(() => {
            this.message.set(4, "d");
          })
          Button('clear').onClick(() => {
            this.message.clear();
          })
          Button('replace the existing one').onClick(() => {
            this.message.set(0, "aa");
          })
          Button('delete the existing one').onClick(() => {
            let result = AppStorage.get<Map<number, string>>("map")?.delete(0);
            if (!result) {
              AppStorage.get<Map<number, string>>("map")?.delete(1);
            }
          })
            .margin({ bottom: 10 })

          Text(this.text)
          //$$引用初始值,修改会同步回去
          TextInput({ text: $$this.text, placeholder: 'input your word...', controller: this.controller })
            .placeholderColor(Color.Grey)
            .placeholderFont({ size: 14, weight: 400 })
            .caretColor(Color.Blue)
            .width(300)
            .margin({ bottom: 10 })

          Text(this.logTrack.str1)// UINode1
            .fontSize(this.isRender(1))
            .fontWeight(FontWeight.Bold)
          Text(this.logTrack.str2)// UINode2
            .fontSize(this.isRender(2))
            .fontWeight(FontWeight.Bold)
          Button('change logTrack.str1')
            .onClick(() => {
              //点击后只有1刷新
              this.logTrack.str1 = 'Bye';
            })
          Text(this.logNotTrack.str1)// UINode3
            .fontSize(this.isRender(3))
            .fontWeight(FontWeight.Bold)
          Text(this.logNotTrack.str2)// UINode4
            .fontSize(this.isRender(4))
            .fontWeight(FontWeight.Bold)
          Button('change logNotTrack.str1')
            .onClick(() => {
              //点击后3,4都刷新
              this.logNotTrack.str1 = '再见';
            })

          Text(`${JSON.stringify(this.log)}`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              // The properties without @Track can be used in the event handler.
              console.log('owner: ' + this.log.owner +
                ' id: ' + this.log.id +
                ' time: ' + this.log.time +
                ' location: ' + this.log.location +
                ' reason: ' + this.log.reason);
              this.log.time = new Date();
              this.log.id++;

              // this.log.logInfo += ' info.';
            })

            .margin({ bottom: 100 })
        }
        .width('100%')
        // .height('100%')
        .justifyContent(FlexAlign.Start)
      }
      .scrollable(ScrollDirection.Vertical)
    }
  }

  isRender(index: number) {
    console.log(`Text ${index} is rendered`)
    return 20;
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

class Log {
  //标识了@Track,只有@Track值改变了才认为该对象改变
  //不标,则任何一个变了都认为改变
  @Track
  logInfo: string;
  owner: string;
  id: number;
  time: Date;
  location: string;
  reason: string;

  constructor(logInfo: string) {
    this.logInfo = logInfo;
    this.owner = 'OH';
    this.id = 0;
    this.time = new Date();
    this.location = 'CN';
    this.reason = 'NULL';
  }
}
