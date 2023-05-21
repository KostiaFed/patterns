require 'json'
require 'yaml'

A = { 'a' => 1, 'b' => 2, 'c' => 3 }

class Default_Opener
  def self.open
    p A
  end
end

class JSON_Opener < Default_Opener
  def self.open
    p A.to_json
  end
end

class YAML_Opener < Default_Opener
  def self.open
    p A.to_yaml
  end
end

Default_Opener.open
JSON_Opener.open
YAML_Opener.open
