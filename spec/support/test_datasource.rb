class TestDatasource
  def fetch
    stations.values
  end

  private

  def stations
    {
      1 => LondonBikeHireCli::Station.new(
                  id: 1,
                  name: 'test-station-1',
                  docks_total: 30,
                  docks_free: 10,
                  lat: 51.53005939,
                  long: -0.120973687
      ),
      2 => LondonBikeHireCli::Station.new(
                  id: 2,
                  name: 'test-station-2',
                  docks_total: 30,
                  docks_free: 20,
                  lat: 51.50810309,
                  long: -0.12602103
      )
    }
  end
end
