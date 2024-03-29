// @Observed
class Article {
  constructor(
    public  id: string,
    public title: string,
    public brief: string,
    public liked: Boolean = false,
    public count: number = 0
  ) {
  }
}

export { Article }