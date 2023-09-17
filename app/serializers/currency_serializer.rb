class CurrencySerializer
  include JSONAPI::Serializer 
  set_id {nil}
  attributes :result 
end