class CurrencyService
  def self.conn 
    Faraday.new(url: "https://api.apilayer.com/") do |f|
      f.headers[:apikey] = ENV["apikey"]
    end
  end

  def self.get_url(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

  def self.convert(to, from, amount)
    get_url("fixer/convert?to=#{to}&from=#{from}&amount=#{amount}")
  end
end