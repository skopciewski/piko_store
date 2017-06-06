# frozen_string_literal: true

# Copyright (C) 2017 Szymon Kopciewski
#
# This file is part of PikoStore.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "bson"
require "piko_store/logger"

module PikoStore
  class BaseDocument
    include Logger

    def initialize(data)
      @data = data
      logger.debug { format "%s", to_h }
    end

    def id
      raise NotImplementedError
    end

    def to_h
      raise NotImplementedError
    end

    def to_hash
      to_h
    end

    def to_s
      to_h.to_s
    end

    private

    def to_objectid_if_needed(id)
      BSON::ObjectId.legal?(id) ? BSON::ObjectId(id) : id
    end

    def id_from_data
      @data[:_id] || @data["_id"]
    end

    def converted_id
      to_objectid_if_needed(id_from_data)
    end

    def generated_id
      BSON::ObjectId.new
    end

    def data_without_id
      @data.reject { |k, _| ["_id", :_id].include?(k) }
    end

    def id_in_data?
      @data.key?(:_id) || @data.key?("_id")
    end

    def data_with_converted_id
      return data_without_id if id.nil? && !id_in_data?
      data_without_id.merge(_id: id)
    end
  end
end
