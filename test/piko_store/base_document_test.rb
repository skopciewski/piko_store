# frozen_string_literal: true

require "test_helper"
require "piko_store/base_document.rb"

module PikoStore
  class Foo < BaseDocument
    def to_h
      {}
    end
  end

  class BaseDocumentTest < Minitest::Test
    def test_that_id_method_is_not_implemented
      assert_raises NotImplementedError do
        doc = Foo.new(foo: "bar")
        doc.id
      end
    end

    def test_that_to_h_method_is_not_implemented
      assert_raises NotImplementedError do
        doc = BaseDocument.new(foo: "bar")
        doc.to_h
      end
    end
  end
end
