# frozen_string_literal: true

require "test_helper"
require "piko_store/filter.rb"

module PikoStore
  class FilterTest < Minitest::Test
    def test_that_instance_is_created_from_hash
      filter = Filter.new(foo: "bar")
      assert_instance_of PikoStore::Filter, filter
    end

    def test_that_instance_does_not_have_generated_id_when_not_given
      filter = Filter.new(foo: "bar")
      assert_nil filter.id
    end

    def test_that_instance_can_generate_bson_object_id_from_string
      filter = Filter.new(_id: "58888226a60772001eeadad7", foo: "bar")
      assert_instance_of BSON::ObjectId, filter.id
    end

    def test_that_instance_do_not_convert_other_ids
      filter = Filter.new("_id" => "123qwe", foo: "bar")
      assert_equal "123qwe", filter.id
    end

    def test_that_to_h_method_returns_data_with_converted_id
      filter = Filter.new("_id" => "58888226a60772001eeadad7", foo: "bar")
      assert_instance_of BSON::ObjectId, filter.to_hash[:_id]
    end

    def test_that_to_h_method_returns_data_without_id_when_not_gien
      filter = Filter.new(foo: "bar")
      refute filter.to_h.key?(:_id)
    end

    def test_that_to_h_method_rerutns_data_with_nil_id
      filter = Filter.new(_id: nil)
      assert filter.to_h.key?(:_id)
    end

    def test_that_class_have_string_representation
      assert_equal({ foo: :bar }.to_s, Filter.new(foo: :bar).to_s)
    end
  end
end
