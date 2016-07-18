class AmbariClusterDiff::PropertyDifference
  include Virtus.model

  attribute :config_group, String
  attribute :property_key, String
  attribute :first_cluster_value, String
  attribute :second_cluster_value, String
end
