rubygems-integration:
  pkg.installed

mailcatcher:
  gem.installed:
    - name: mailcatcher
  require:
    - pkg: rubygems-integration
