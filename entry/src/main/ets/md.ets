import { BusinessError } from '@ohos.base';


//使用Record作为Object的替代,可动态获取属性值
let tmpStr: Record<string, Object> = JSON.parse('');
if (tmpStr.msg != undefined) {
}
if (tmpStr.code != undefined) {
}

let entries = new Map([
  ['foo', 123],
  ['bar', 456]
]);

let obj: Record<string, Object> = {};
entries.forEach((value, key) => {
  if (key != undefined && key != null) {
    obj[key] = value;
  }
})
obj.foo
obj['foo']

//-----------------------------------
class Test {
  value: number = 1
  // constructor(value: number) {
  //   this.value = value;
  // }
}

//无参构造函数才能用此写法,默认是无参
let t: Test = { value: 2 };


class Test2 {
  value: number | undefined = 1
  value2?: number

  constructor(value?: number) {
    this.value = value;
  }
}

//有参必须用new,但是有参可选也可以用{}
let t2: Test2 = new Test2(2);
t2.value2?.toLocaleString()
if (t2.value2) {
  t2.value2.toLocaleString()
}
let t3: Test = { value: 2 };


//-----------------------------------
function ThrowError(error: BusinessError) {
  // throw error;
  throw error as Error;
}

try {
} catch (error) {
  console.log((error as BusinessError).message);
}


//-----------------------------------
interface A {
  foo: () => void
}
let a: A = {
  foo: () => {
  }
};
a.foo();

