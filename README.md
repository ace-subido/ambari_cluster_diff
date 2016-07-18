# ambari_cluster_diff

CLI tool to list configuration differences between Ambari-Managed Hadoop Clusters via Blueprints

## Installation

Hopefully it's as easy as this:

    $ gem install ambari_cluster_diff

But for now, just clone the entire repo and run the executable inside `/exe`

    $ exe/clusterdiff

## Usage

```
$ clusterdiff compare dev-blueprint.json prod-blueprint.json

Comparing dev-blueprint.json and prod-blueprint.json

| Config Group | Property                   | Value for dev.json | Value for prod.json |
| ============ | ========================== | ================== | =================== |
| yarn-site    | yarn.nodemanager.memory.mb | 4096               | 8192                |

$ clusterdiff compare dev.json prod.json --export-to-tsv test.tsv
```

Tested against the following:

- Ambari 2.1 Blueprints
- Ambari 2.2 Blueprints
- HDP 2.2
- HDP 2.3

## Roadmap

- Write tests
- Write tests
- Did I mention to write tests?
- Well I would say, "Refactor". But if I write tests, I guess that would follow.
- Add `-c` or `--config-group` option to print out the diff of just one config group

## Development

Executable is in here:

```
exe/clusterdiff
```

While this has no tests yet, you could test it out by running the executable against 2 blueprints and littering pry everywhere.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ace-subido/ambari_cluster_diff. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

