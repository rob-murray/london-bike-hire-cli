require 'spec_helper'
require 'rspec/mocks/standalone'

class TestDatasource
  def fetch
    {
      1 => double('station', id: 1, name: 'test-station-1', docks_total: 30, docks_free: 10),
      2 => double('station', id: 2, name: 'test-station-2', docks_total: 30, docks_free: 20)
    }
  end
end
