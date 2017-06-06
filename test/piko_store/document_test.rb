# frozen_string_literal: true

require "test_helper"
require "piko_store/document.rb"

module PikoStore
  class DocumentTest < Minitest::Test
    def test_that_instance_is_created_from_hash
      doc = Document.new(foo: "bar")
      assert_instance_of PikoStore::Document, doc
    end

    def test_that_instance_has_generated_id_when_do_not_given
      doc = Document.new(foo: "bar")
      assert_instance_of BSON::ObjectId, doc.id
    end

    def test_that_instance_can_generate_bson_object_id_from_string
      doc = Document.new(_id: "58888226a60772001eeadad7", foo: "bar")
      assert_instance_of BSON::ObjectId, doc.id
    end

    def test_that_instance_can_not_convert_other_ids
      doc = Document.new("_id" => "123qwe", foo: "bar")
      assert_equal "123qwe", doc.id
    end

    def test_that_to_h_method_returns_data_with_converted_id
      doc = Document.new("_id" => "58888226a60772001eeadad7", foo: "bar")
      assert_instance_of BSON::ObjectId, doc.to_hash[:_id]
    end

    def test_that_to_h_method_returns_data_with_id_key
      doc = Document.new(foo: "bar")
      assert doc.to_h.key?(:_id)
    end

    def test_that_class_have_string_representation
      assert_equal({ _id: :bar }.to_s, Document.new(_id: :bar).to_s)
    end
  end
end
