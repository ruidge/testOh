import { Header } from '../component/Header'

@Entry
@Component
struct Page3 {
  @Provide('a') reviewVotes: number = 0;
  @State b: ClassB = new ClassB(new ClassA(10));

  build() {
    Column() {
      Header({ title: 'Page3' })

      Column() {
        Button(`reviewVotes(${this.reviewVotes}), give +1`)
          .onClick(() => this.reviewVotes += 1)
        CompB()
      }

      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        ViewA({ label: "ViewA #1", a: this.b.a })
        ViewA({ label: "ViewA #2", a: this.b.a })

        Button(`ViewB: this.b.a.c += 1`)
          .width(320)
          .margin(4)
          .onClick(() => {
            this.b.a.c += 1;
          })
        Button(`ViewB: this.b.a = new ClassA(0)`)
          .width(240)
          .margin(4)
          .onClick(() => {
            this.b.a = new ClassA(0);
          })
        Button(`ViewB: this.b = new ClassB(ClassA(0))`)
          .width(240)
          .margin(4)
          .onClick(() => {
            this.b = new ClassB(new ClassA(0));
          })
      }
    }
  }
}

@Observed
class ClassA {
  public name: string;
  public c: number;

  constructor(c: number, name: string = '') {
    this.name = name;
    this.c = c;
  }
}

class ClassB {
  public a: ClassA;

  constructor(a: ClassA) {
    this.a = a;
  }
}

@Component
struct ViewA {
  label: string = "ep1";
  @ObjectLink a: ClassA;

  build() {
    Column() {
      Text(`ViewA [${this.label}]: a.c=${this.a.c}`)
        .fontSize(20)
      Button(`+1`)
        .width(100)
        .margin(2)
        .onClick(() => {
          this.a.c += 1;
        })
      Button(`reset`)
        .width(100)
        .margin(2)
        .onClick(() => {
          this.a = new ClassA(0); // 错误：ObjectLink装饰的变量a是不可变的
        })
    }
  }
}

/*
---------------------------------------
*/
@Component
struct CompD {
  // @Consume装饰的变量通过相同的属性名绑定其祖先组件CompA内的@Provide装饰的变量
  @Consume('a') count: number;

  build() {
    Column() {
      Text(`reviewVotes(${this.count})`)
      Button(`reviewVotes(${this.count}), give +1`)
        .onClick(() => this.count += 1)
    }
    .width('50%')
  }
}

@Component
struct CompC {
  build() {
    Row({ space: 5 }) {
      CompD()
      CompD()
    }
  }
}

@Component
struct CompB {
  build() {
    CompC()
  }
}