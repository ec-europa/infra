mailcatcher-stack:
  pkg.installed:
    - pkgs:
      - rubygems-integration
      - ruby-dev
      - make

mailcatcher:
  gem.installed:
    - name: mailcatcher
  require:
    - pkg: mailcatcher-stack
