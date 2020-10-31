# frozen_string_literal: true

require_relative 'generator'
require_relative 'template_util'

module GenronSF
  module EBook
    class SubjectGenerator < Generator
      attr_reader :subject

      def initialize(subject)
        @subject = subject
        super()
      end

      def generate(path = nil) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        book.identifier = subject.url
        book.language = 'ja'
        book.title = subject.theme
        book.creator = 'ゲンロン 大森望 SF創作講座'
        book.contributor = subject.lecturers.find { |lecturer| lecturer.roles.include?('課題提示') }

        File.open(TemplateUtil::CSS_FILE_PATH) do |file|
          book.add_item(File.basename(file.path), content: file)
        end

        book.ordered do
          subject.entries.each do |work|
            book.add_item(
              "#{work.student.id}-title.xhtml",
              content: StringIO.new(TemplateUtil.title_xhtml(work.student.name)),
              toc_text: work.student.name,
            )
            book.add_item(
              "#{work.student.id}-work.xhtml",
              content: StringIO.new(TemplateUtil.work_xhtml(work)),
            )
          end
        end

        book.generate_epub(path || "SF創作講座#{subject.year}-#{subject.number.to_s.rjust(2, '0')}.epub")
      end
    end
  end
end
