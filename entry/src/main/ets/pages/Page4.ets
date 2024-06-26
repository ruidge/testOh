import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'
import router from '@ohos.router'
import { Header } from '../component/Header'


function sum(x: number, y: number): number {
  return x + y;
}

// 函数表达式（Function Expression）
let mySum: (x: number, y: number) => number = (x: number, y: number): number => {
  return x + y;
}


export class PropB {
  code: number;

  constructor(code: number) {
    this.code = code;
  }
}

class PropC {
  propB: PropB;

  constructor(propB: PropB) {
    this.propB = propB;
  }
}


// AppStorage.setOrCreate('PropA', 47);
// AppStorage.setOrCreate('PropB', new PropB(50));

// 创建新实例并使用给定对象初始化
let para: Record<string, number | string> = { 'PropA': 47, 'PropAA': "48" };
let para2: Map<string, number | string> = new Map
para2.set('PropA', 47)
para2.set('PropAA', "48")
let storage: LocalStorage = new LocalStorage(para);
storage.setOrCreate('PropB', new PropB(50));
storage.setOrCreate('PropC', new PropC(new PropB(100)));
storage.setOrCreate('PropD', 200);


@Entry(storage)
@Component
struct Page4 {
  @State num3: number = 100
  @LocalStorageLink('PropA') parentLinkNumber: number = 1;
  //一层嵌套可以识别到属性的变化
  @LocalStorageLink('PropB') parentLinkObject: PropB = new PropB(0);
  //再嵌套一层识别不到
  @LocalStorageLink('PropC') parentLinkObject2: PropC = new PropC(new PropB(100));
  @LocalStorageProp('PropD') parentLinkNumber2: number = 1;
  //全局无此key使用1,有key使用全局的
  @StorageLink('PropA') storageLink: number = 1;
  @StorageLink('PropB') storageLinkObject: PropB = new PropB(1);

  sum(x: number, y: number): number {
    return x + y;
  }

  mySum: (x: number, y: number) => number = (x: number, y: number): number => {
    return x + y;
  }

  @Builder
  childBuilder() {
    Button(`childBuilder`)
  }

  build() {
    Column() {
      Header({ title: 'Page4' })
      Column() {
        Child({
          passBuilder: this.childBuilder, cClick: () => {
            promptAction.showToast({ message: `child click` })
          }
        })
          .margin({ bottom: 10 })
        Button(`Parent from LocalStorage ${this.parentLinkNumber}`)
          .onClick(() => {
            this.parentLinkNumber += 1;
          })
        Button(`Parent from LocalStorage ${this.parentLinkObject.code}`)
          .onClick(() => {
            this.parentLinkObject.code += 1;
          })
        Button(`Parent2 from LocalStorage ${this.parentLinkObject2.propB.code}`)
          .onClick(() => {
            //改变嵌套对象的属性的值,页面不会刷新
            // this.parentLinkObject2.propB.code += 1;
            //这里取出已经改变的值(比如在child点击的),赋值新对象,然后会触发页面刷新
            let code = this.parentLinkObject2.propB.code += 1;
            this.parentLinkObject2.propB = new PropB(code)

          })
        Button(`ParentD from LocalStorage ${this.parentLinkNumber2}`)
          .onClick(() => {
            //这里改变只影响当前组件,不会影响到全局
            this.parentLinkNumber2 += 1;
          })
          .margin({ bottom: 10 })

        ChildLink()
          .margin({ bottom: 10 })
        ChildProp()
          .margin({ bottom: 10 })

        Button(`From AppStorage ${this.storageLink}`)
          .onClick(() => {
            this.storageLink += 1;
          })

        Button(`From AppStorage ${this.storageLinkObject.code}`)
          .onClick(() => {
            this.storageLinkObject.code += 1;
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
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
  @LocalStorageLink('PropA') childLinkNumber: number = 1;
  @LocalStorageLink('PropB') childLinkObject: PropB = new PropB(0);
  @LocalStorageLink('PropC') childLinkObject2: PropC = new PropC(new PropB(100));
  @LocalStorageProp('PropD') childLinkNumber2: number = 1;

  build() {
    Column() {
      Button(`ChildLink from LocalStorage ${this.childLinkNumber}`)
        .onClick(() => {
          this.childLinkNumber += 1;
        })
      Button(`ChildLink from LocalStorage ${this.childLinkObject.code}`)
        .onClick(() => {
          this.childLinkObject.code += 1;
        })
      Button(`ChildLink2 from LocalStorage ${this.childLinkObject2.propB.code}`)
        .onClick(() => {
          //这里点击只会改变嵌套对象的属性的值,但是页面并不会刷新
          this.childLinkObject2.propB.code += 1;
        })
      Button(`ChildLink from LocalStorage ${this.childLinkNumber2}`)
        .onClick(() => {
          //这里改变只影响当前组件,不会影响到全局
          this.childLinkNumber2 += 1;
        })
    }
  }
}

@Component
struct ChildProp {
  @LocalStorageProp('PropA') childLinkNumber: number = 1;
  @LocalStorageProp('PropB') childLinkObject: PropB = new PropB(0);
  @LocalStorageLink('PropD') childLinkNumber2: number = 1;

  build() {
    Column() {
      Button(`ChildProp from LocalStorage ${this.childLinkNumber}`)
        .onClick(() => {
          this.childLinkNumber += 1;
        })
      Button(`ChildProp from LocalStorage ${this.childLinkObject.code}`)
        .onClick(() => {
          this.childLinkObject.code += 1;
        })
      Button(`ChildPropD from LocalStorage ${this.childLinkNumber2}`)
        .onClick(() => {
          //因为这里是link的,这里改变会影响到全局,从而影响到其他prop的
          this.childLinkNumber2 += 1;
        })
    }
  }
}