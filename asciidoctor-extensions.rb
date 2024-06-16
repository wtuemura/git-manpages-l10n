require 'asciidoctor'
require 'asciidoctor/extensions'

module Git
  module Documentation
    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
      use_dsl

      named :chrome

      def process(parent, target, attrs)
        prefix = parent.document.attr('git-relative-html-prefix')
        if parent.document.doctype == 'book'
          "<ulink url=\"#{prefix}#{target}.html\">" \
          "#{target}(#{attrs[1]})</ulink>"
        elsif parent.document.basebackend? 'html'
          %(<a href="#{prefix}#{target}.html"><b>#{target}</b>(#{attrs[1]})</a>)
        elsif parent.document.basebackend? 'manpage'
          "\\fB#{target}\\fR(#{attrs[1]})"
        end
      end
    end
  end
end

Asciidoctor::Extensions.register do
  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
end
