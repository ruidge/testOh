import { Header } from '../component/Header'

@Entry
@Component
struct Page3 {
  build() {
    Column() {
      Header({ title: 'Page3' })
    }
  }
}