# GenronSF

Ruby gem for scraping and ebook generation of [超・SF作家育成サイト](https://school.genron.co.jp/works/sf/)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add genron_sf --github fuji-nakahara/genron_sf --branch main

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install genron_sf --source 'https://rubygems.pkg.github.com/fuji-nakahara'

See https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-rubygems-registry for more detail of GitHub Packages.

## Usage

### EBook Generation (CLI)

```console
$ genron_sf --help
Usage: genron_sf [options]
    -t, --type TYPE                  subject or student (default: subject)
    -y, --year YEAR                  2016-
    -n, --id ID                      subject number or student id
    -o, --output PATH                ./path/to/output.epub
$ genron_sf --year 2018 -n 1 # Generate SF創作講座2018-01.epub
```

### Scraping

```ruby
require 'genron_sf'

# 課題一覧
subjects = GenronSF::Subject.list(year: 2018)
subjects.url #=> "https://school.genron.co.jp/works/sf/2018/"
subjects.each do |subject|
  # ...
end

# 課題詳細
subject = GenronSF::Subject.get(year: 2018, number: 1)
subject.url #=> "https://school.genron.co.jp/works/sf/2018/subjects/1/"
subject.theme #=> "AIあるいは仮想通貨を題材に短編を書け"
subject.detail #=> "この講座も3年目。...#
subject.summary_deadline #=> #<Date: 2018-06-14 ((2458284j,0s,0n),+0s,2299161j)>
subject.summary_comment_date #=> #<Date: 2018-06-21 ((2458291j,0s,0n),+0s,2299161j)>
subject.work_deadline #=> #<Date: 2018-07-12 ((2458312j,0s,0n),+0s,2299161j)>
subject.work_comment_date #=> #<Date: 2018-07-19 ((2458319j,0s,0n),+0s,2299161j)>
subject.lecturers.find { |lecturer| lecturer.roles.include?('課題提示') }.name #=> "東浩紀"
subject.summaries # 作品の配列
subject.works # 実作提出作品の配列
subject.excellent_entries # 選出・得点作品の配列
score = subject.scores.first
score.work.title #=> "鍬と十字"
score.value #=> 4

# 受講生一覧
students = GenronSF::Student.list(year: 2018)
students.url #=> "https://school.genron.co.jp/works/sf/2018/students/"
students.each do |student|
  # ...
end

# 受講生詳細
student = GenronSF::Student.get(year: 2018, id: 'fujinakahara')
student.url #=> "https://school.genron.co.jp/works/sf/2018/students/fujinakahara/"
student.name #=> "フジ・ナカハラ"
student.profile #=> "@fuji_nakahara https://fuji-nakahara.page/"
student.twitter_screen_name #=> "fuji_nakahara"
student.works # 作品の配列

# 作品詳細
work = GenronSF::Work.get(year: 2018, student_id: 'fujinakahara', id: 2307)
work.url #=> "https://school.genron.co.jp/works/sf/2018/students/fujinakahara/2307/"
work.subject # 課題
work.student # 受講生
work.summary_title #=> "リアル・サイボーグ"
work.summary.text.strip #=> "ヒロトはもちろん、1年4組の生徒は皆、ケイと出会った入学式の朝のことを忘れないだろう。..."
work.summary_character_count #=> 1798
work.title #=> "サイボーグ・クラスメイト"
work.body.text.strip #=> "今のぼくがあるのは、ケイとの出会いがあったからだ。..."
work.character_count #=> 17790
work.appeal #=> "入学式の朝の男子生徒とケイ、体育見学時のヒロトとケイ、そして、放課後の河原での二人。この三回を魅力的なやり取りにするつもりです。..."
work.appeal_character_count #=> 400
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then create and push a git tag, which will start [a GitHub Action workflow](.github/workflows/gem-push.yml), and push the `.gem` file to [GitHub Packages](https://github.com/fuji-nakahara/genron_sf/packages/482545).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/genron_sf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/fuji-nakahara/genron_sf/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GenronSf project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fuji-nakahara/genron_sf/blob/main/CODE_OF_CONDUCT.md).
