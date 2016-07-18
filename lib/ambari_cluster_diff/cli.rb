class AmbariClusterDiff::CLI < Thor
  option :export_to_tsv, aliases: "-e", banner: "/path/to/exported_results.tsv"
  desc(
    "compare first_cluster_file_path second_cluster_file_path",
    "Prints out the properties in the first cluster compared to the second cluster"
  )
  def compare(first_cluster_json_file_path, second_cluster_json_file_path)
    first_cluster = JSON.parse(file_opener(first_cluster_json_file_path))
    second_cluster = JSON.parse(file_opener(second_cluster_json_file_path))

    results = cluster_diff(first_cluster, second_cluster)
    set_table_print(first_cluster_json_file_path, second_cluster_json_file_path)
    print_results(results)

    if options[:export_to_tsv].present?
      file_name = options[:export_to_tsv]
      raise "File exists" if File.exist?(file_name)
      export_to_file(
        file_name,
        results,
        first_cluster_json_file_path,
        second_cluster_json_file_path,
      )
    end
  end

  private

  def export_to_file(file_name, results, first_cluster_name, second_cluster_name)
    CSV.open(file_name, "w", { col_sep: "\t" }) do |csv|
      csv << [
        "Config Group",
        "Property Key",
        first_cluster_name,
        second_cluster_name,
      ]

      results.each do |result|
        csv << [
          result.config_group,
          result.property_key,
          result.first_cluster_value,
          result.second_cluster_value,
        ]
      end
    end
  end

  def cluster_diff(first_cluster, second_cluster)
    results = []

    first_cluster["configurations"].each do |config_group|
      config_group_key = config_group.keys.first

      config_to_compare = second_cluster["configurations"].find do |config_to_find|
          config_to_find[config_group_key]
        end

      if config_to_compare.present?
        differences = HashDiff.best_diff(
          get_config_properties(first_cluster, config_group[config_group_key]),
          get_config_properties(second_cluster, config_to_compare[config_group_key]),
        )

        differences.each do |difference_item|
          property_difference = AmbariClusterDiff::PropertyDifference.new(
            config_group: config_group_key,
            property_key: difference_item[1],
            first_cluster_value: "",
            second_cluster_value: "",
          )

          case difference_item[0]
          when "-"
            property_difference.first_cluster_value = difference_item[2]
          when "+"
            property_difference.second_cluster_value = difference_item[2]
          when "~"
            property_difference.first_cluster_value = difference_item[2]
            property_difference.second_cluster_value = difference_item[3]
          end

          results << property_difference
        end
      end
    end

    results
  end

  def set_table_print(first_cluster_name, second_cluster_name)
    tp.set :capitalize_headers, false
    tp.set(
      AmbariClusterDiff::PropertyDifference,
      :config_group,
      {
        :property_key => {
          :width => 60
        }
      },
      {
        :first_cluster_value => {
          :display_name => "#{first_cluster_name} Value",
          :width => 30
        }
      },
      {
        :second_cluster_value => {
          :display_name => "#{second_cluster_name} Value",
          :width => 30
        }
      },
    )
  end

  def print_results(results)
    tp results, {}
  end

  def get_config_properties(cluster, config_group)
    if cluster["Blueprints"]["stack_version"] == "2.2"
      config_group
    elsif cluster["Blueprints"]["stack_version"] == "2.3"
      config_group["properties"]
    end
  end

  def file_opener(file_path)
    File.read(file_path)
  end

end
