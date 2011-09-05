class ActiveRecord::Base
  yaml_as "tag:ruby.yaml.org,2002:ActiveRecord"

  def self.yaml_new(klass, tag, val)
    pks = klass.primary_key
    case pks
    when Array
        ids = pks.map{|pk| val['attributes'][pk.to_s] }
    else
        ids = val['attributes']['id']
    end

    klass.find(ids)
  rescue ActiveRecord::RecordNotFound
    raise Delayed::DeserializationError
  end

  def to_yaml_properties
    ['@attributes']
  end
end
