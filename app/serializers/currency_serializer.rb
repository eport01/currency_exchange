class CurrencySerializer
  include JSONAPI::Serializer 
  set_id {nil}
  attributes :from, :to, :initial, :result 
end